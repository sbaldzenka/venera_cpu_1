// project     : venera_cpu_1
// data        : 14.02.2022
// author      : siarhei baldzenka
// e-mail      : venera.electronica@gmail.com
// description : BRAM memory.

`timescale 1ns/100ps

module instruction_memory
(
    input  wire        i_clk,
    input  wire        i_rd,
    input  wire [ 7:0] i_address,
    output wire        o_valid,
    output wire [15:0] o_dout
);

    reg [15:0] mem [0:255];
    reg        valid_reg;
    reg [15:0] dout_reg;

    initial begin
        $readmemh("../hdl/periph_modules/instruction_memory/instructions_mem.dat", mem);
    end

    always@(posedge i_clk) begin
        if (i_rd) begin
            valid_reg <= 1'b1;
            dout_reg  <= mem[i_address];
        end else begin
            valid_reg <= 1'b0;
        end
    end

    assign o_valid = valid_reg;
    assign o_dout  = dout_reg;

endmodule