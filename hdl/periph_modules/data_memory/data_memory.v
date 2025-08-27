// project     : venera_cpu_1
// data        : 14.02.2022
// author      : siarhei baldzenka
// e-mail      : venera.electronica@gmail.com
// description : BRAM memory.

module data_memory
(
    input        i_clk,
    input        i_wr,
    input  [7:0] i_address_wr,
    input  [7:0] i_din,
    input        i_rd,
    input  [7:0] i_address_rd,
    output [7:0] o_dout
);

    reg [7:0] mem [0:255];
    reg [7:0] dout_reg;

    initial begin
        $readmemh("../hdl/periph_modules/data_memory/data_mem.dat", mem);
    end

    always@(posedge i_clk) begin
        if (i_wr) begin
            mem[i_address_wr] <= i_din;
        end
    end

    always@(posedge i_clk) begin
        if (i_rd) begin
            dout_reg <= mem[i_address_rd];
        end
    end

    assign o_dout = dout_reg;

endmodule