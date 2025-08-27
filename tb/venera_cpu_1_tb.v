// project     : venera_cpu_1
// data        : 11.02.2022
// author      : siarhei baldzenka
// e-mail      : venera.electronica@gmail.com
// description : testbench.

`timescale 1ns/100ps

module venera_cpu_1_tb();

    reg         clk;
    reg         areset;
    wire        reset;

    wire        instruction_rd;
    wire [ 7:0] instruction_address;
    wire        instruction_valid;
    wire [15:0] instruction_data;

    wire        data_wr;
    wire [ 7:0] data_address_wr;
    wire [ 7:0] data_in;
    wire        data_rd;
    wire [ 7:0] data_address_rd;
    wire [ 7:0] data_out;

    wire        p_wr_strobe;
    wire        p_rd_strobe;
    wire [ 7:0] p_addr;
    wire [ 7:0] p_dout;
    wire [ 7:0] p_din;
    wire        p_rd_done;

    initial begin
        clk    <= 1'b0;
        areset <= 0;
        //#30000;
        //areset <= 1;
        //#200;
        //areset <= 0;
    end

    always #50 clk <= ~clk;

    venera_cpu_1 venera_cpu_1_inst
    (
        .i_clk                     ( clk                 ),
        .i_reset                   ( reset               ),
        .o_mem_instruction_rd      ( instruction_rd      ),
        .o_mem_instruction_address ( instruction_address ),
        .i_mem_instruction_valid   ( instruction_valid   ),
        .i_mem_instruction_data    ( instruction_data    ),
        .o_mem_data_wr             ( data_wr             ),
        .o_mem_data_address_wr     ( data_address_wr     ),
        .o_mem_data_in             ( data_in             ),
        .o_mem_data_rd             ( data_rd             ),
        .o_mem_data_address_rd     ( data_address_rd     ),
        .i_mem_data_out            ( data_out            ),
        .o_p_wr_strobe             ( p_wr_strobe         ),
        .o_p_rd_strobe             ( p_rd_strobe         ),
        .o_p_addr                  ( p_addr              ),
        .o_p_dout                  ( p_dout              ),
        .i_p_din                   ( p_din               ),
        .i_p_rd_done               ( p_rd_done           )
    );

    reset_module reset_module_inst
    (
        .i_clk    ( clk    ),
        .i_areset ( areset ),
        .o_reset  ( reset  )
    );

    instruction_memory instruction_memory_inst
    (
        .i_clk     ( clk                 ),
        .i_rd      ( instruction_rd      ),
        .i_address ( instruction_address ),
        .o_valid   ( instruction_valid   ),
        .o_dout    ( instruction_data    )
    );

    data_memory data_memory_inst
    (
        .i_clk        ( clk             ),
        .i_wr         ( data_wr         ),
        .i_address_wr ( data_address_wr ),
        .i_din        ( data_in         ),
        .i_rd         ( data_rd         ),
        .i_address_rd ( data_address_rd ),
        .o_dout       ( data_out        )
    );

endmodule