// project: venera_cpu_1
// author:  sboldenko
// data:    15.02.2022

module accumulator
(
    input         clk,
    input         reset,
    input         load,
    input  [15:0] load_data,
    input         valid_din,
    input  [15:0] din,
    output [15:0] dout
);

    reg [15:0] accum;

    always@(posedge clk) begin
        if (reset)
            accum <= 16'h0000;
        else if (load)
            accum <= load_data;
        else if (valid_din)
            accum <= din;
    end

    assign dout = accum;

endmodule