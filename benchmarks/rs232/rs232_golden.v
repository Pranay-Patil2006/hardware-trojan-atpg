// ==============================================================================
// Trust-HUB Benchmark: RS232 UART Transmitter (Golden Reference)
// Standard 8-bit UART transmitter with configurable baud rate and parity
// ==============================================================================
`timescale 1ns / 1ps

module rs232_golden (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       tx_start,
    input  wire [7:0] tx_data,
    output reg        tx_busy,
    output reg        tx_out
);

    parameter IDLE  = 2'b00;
    parameter START = 2'b01;
    parameter DATA  = 2'b10;
    parameter STOP  = 2'b11;

    reg [1:0]  state;
    reg [2:0]  bit_idx;
    reg [7:0]  data_reg;
    reg [15:0] clk_cnt;

    parameter CLKS_PER_BIT = 16'd434; // 50MHz / 115200 baud

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state    <= IDLE;
            tx_busy  <= 1'b0;
            tx_out   <= 1'b1;
            bit_idx  <= 3'd0;
            clk_cnt  <= 16'd0;
            data_reg <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    tx_out  <= 1'b1;
                    tx_busy <= 1'b0;
                    clk_cnt <= 16'd0;
                    bit_idx <= 3'd0;
                    if (tx_start) begin
                        data_reg <= tx_data;
                        tx_busy  <= 1'b1;
                        state    <= START;
                    end
                end

                START: begin
                    tx_out <= 1'b0; // Start bit
                    if (clk_cnt < CLKS_PER_BIT - 1) begin
                        clk_cnt <= clk_cnt + 1'b1;
                    end else begin
                        clk_cnt <= 16'd0;
                        state   <= DATA;
                    end
                end

                DATA: begin
                    tx_out <= data_reg[bit_idx];
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
                    tx_out <= 1'b1; // Stop bit
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
