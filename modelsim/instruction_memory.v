// project: venera_cpu_1
// author:  sboldenko
// data:    14.02.2022

module instruction_memory
(
    input         clk,
    input         rd,
    input  [07:0] address,
    output [15:0] dout
);

    reg [15:0] mem [0:255];
    reg [15:0] dout_reg;

    initial begin
        $readmemh("instructions_mem.txt", mem);
    end

    always@(posedge clk) begin
        if (rd)
            dout_reg <= mem[address];
    end

    assign dout = dout_reg;

endmodule