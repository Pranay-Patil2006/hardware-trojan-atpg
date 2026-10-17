`timescale 1ns / 1ps

module rs232_tb;
    reg clk;
    reg rst_n;
    reg tx_start;
    reg [7:0] tx_data;
    wire golden_tx_busy, golden_tx_out;
    wire trojan_tx_busy, trojan_tx_out;

    rs232_golden u_golden (
        .clk(clk),
        .rst_n(rst_n),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx_busy(golden_tx_busy),
        .tx_out(golden_tx_out)
    );

    rs232_t100 u_trojan (
        .clk(clk),
        .rst_n(rst_n),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx_busy(trojan_tx_busy),
        .tx_out(trojan_tx_out)
    );

    always #10 clk = ~clk; // 50 MHz

    integer i;
    integer mismatch_count = 0;

    initial begin
        clk = 0;
        rst_n = 0;
        tx_start = 0;
        tx_data = 8'h00;
        #100;
        rst_n = 1;
        #100;

        // Send 20 bytes. Payload byte 8'hA5 triggers the rare counter
        for (i = 0; i < 20; i = i + 1) begin
            @(posedge clk);
            tx_data = (i < 16) ? 8'hA5 : 8'h3C;
            tx_start = 1;
            @(posedge clk);
            tx_start = 0;
            
            // Wait for transmission to finish while monitoring outputs
            while (golden_tx_busy || trojan_tx_busy) begin
                @(posedge clk);
                if (golden_tx_out !== trojan_tx_out) begin
                    mismatch_count = mismatch_count + 1;
                    if (mismatch_count == 1) begin
                        $display("[MISMATCH DETECTED] Time: %0t ps | Byte #%0d | Golden tx_out: %b, Trojan tx_out: %b", 
                                 $time, i, golden_tx_out, trojan_tx_out);
                        $display("  >>> HARDWARE TROJAN PAYLOAD TRIGGERED (Output bit inverted)!");
                    end
                end
            end
            #200;
        end

        $display("Simulation finished. Total mismatch cycles observed: %0d", mismatch_count);
        if (mismatch_count > 0)
            $display(">>> VERIFICATION RESULT: MALICIOUS IMPLANT DETECTED <<<");
        else
            $display(">>> VERIFICATION RESULT: NO IMPLANT DETECTED <<<");
        $finish;
    end
endmodule
