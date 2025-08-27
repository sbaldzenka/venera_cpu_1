// project     : venera_cpu_1
// data        : 15.02.2022
// author      : siarhei baldzenka
// e-mail      : venera.electronica@gmail.com
// description : alu for venera_cpu_1.

`timescale 1ns/100ps

module alu
(
    // global signals
    input  wire       i_clk,
    input  wire       i_reset,
    // control and data in
    input  wire [2:0] i_control,
    input  wire       i_load,
    input  wire [7:0] i_din_a,
    input  wire [7:0] i_din_b,
    // result data
    output wire       o_valid,
    output wire [7:0] o_dout
);

    reg       valid_ff;
    reg [7:0] result;

    always@(posedge i_clk) begin
        valid_ff <= i_load;

        if (i_reset) begin
            result <= 8'h00;
        end else if (i_load) begin
            case (i_control)
                3'b001:  result <= i_din_a + i_din_b;
                3'b010:  result <= i_din_a - i_din_b;
                default: result <= 8'h00;
            endcase
        end
    end

    assign o_valid = valid_ff;
    assign o_dout  = result;

endmodule