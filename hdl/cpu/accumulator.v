// project     : venera_cpu_1
// data        : 15.02.2022
// author      : siarhei baldzenka
// e-mail      : venera.electronica@gmail.com
// description : accumulator module for venera_cpu_1.

`timescale 1ns/100ps

module accumulator
(
    // global signals
    input  wire       i_clk,
    input  wire       i_reset,
    // data from alu
    input  wire       i_alu_valid,
    input  wire [7:0] i_alu_data,
    // data from memory
    input  wire       i_mem_valid,
    input  wire [7:0] i_mem_data,
    // data to alu
    output wire [7:0] o_dout
);

    reg [7:0] accum; // AC

    always@(posedge i_clk) begin
        if (i_reset) begin
            accum <= 8'h00;
        end else if (i_alu_valid) begin
            accum <= i_alu_data;
        end else if (i_mem_valid) begin
            accum <= i_mem_data;
        end
    end

    assign o_dout = accum;

endmodule