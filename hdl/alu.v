// project: venera_cpu_1
// author:  sboldenko
// data:    15.02.2022

module alu
(
    input         clk,
    input         reset,
    input  [02:0] control,
    input         load,
    input  [15:0] din_a,
    input  [15:0] din_b,
    output        valid_dout,
    output [15:0] dout
);

    reg        valid_dout_reg;
    reg [15:0] result;

    always@(posedge clk) begin
        valid_dout_reg <= load;

        if (reset)
            result <= 16'h0000;
        else if (load)
            case (control)
                3'b001:  result <= din_b + din_a;
                3'b010:  result <= din_b - din_a;
                3'b011:  result <= din_b * din_a;
                default: result <= 16'h0000;
            endcase
    end

    assign valid_dout = valid_dout_reg;
    assign dout       = result;

endmodule