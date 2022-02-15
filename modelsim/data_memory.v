// project: venera_cpu_1
// author:  sboldenko
// data:    14.02.2022

module data_memory
(
    input         clk,
    input         wr,
    input  [07:0] address_wr,
    input  [15:0] din,
    input         rd,
    input  [07:0] address_rd,
    output [15:0] dout
);

    reg [15:0] mem [0:255];
    reg [15:0] dout_reg;

    initial begin
        $readmemh("data_mem.txt", mem);
    end

    always@(posedge clk) begin
        if (wr)
            mem[address_wr] <= din;
    end

    always@(posedge clk) begin
        if (rd)
            dout_reg <= mem[address_rd];
    end

    assign dout = dout_reg;

endmodule