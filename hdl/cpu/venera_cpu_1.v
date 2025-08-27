// project     : venera_cpu_1
// data        : 11.02.2022
// author      : siarhei baldzenka
// e-mail      : venera.electronica@gmail.com
// description : top file.

`timescale 1ns/100ps

module venera_cpu_1
(
    // global signals
    input  wire        i_clk,
    input  wire        i_reset,
    // instructions memory bus
    output wire        o_mem_instruction_rd,
    output wire [ 7:0] o_mem_instruction_address,
    input  wire        i_mem_instruction_valid,
    input  wire [15:0] i_mem_instruction_data,
    // data memory bus
    output wire        o_mem_data_wr,
    output wire [ 7:0] o_mem_data_address_wr,
    output wire [ 7:0] o_mem_data_in,
    output wire        o_mem_data_rd,
    output wire [ 7:0] o_mem_data_address_rd,
    input  wire [ 7:0] i_mem_data_out,
    // peripheral bus
    output wire        o_p_wr_strobe,
    output wire        o_p_rd_strobe,
    output wire [ 7:0] o_p_addr,
    output wire [ 7:0] o_p_dout,
    input  wire [ 7:0] i_p_din,
    input  wire        i_p_rd_done
);

    wire       set_valid;
    wire [7:0] set_value;

    wire       load_to_accumulator_valid;
    wire [7:0] load_to_accumulator_data;

    wire [7:0] accum_dout;

    wire [2:0] alu_control;
    wire       alu_load;
    wire [7:0] alu_data;

    wire       alu_result_valid;
    wire [7:0] alu_result_data;


    address_counter address_counter_inst
    (
        .i_clk       ( i_clk                     ),
        .i_reset     ( i_reset                   ),
        .i_set_valid ( set_valid                 ),
        .i_set_value ( set_value                 ),
        .o_rd        ( o_mem_instruction_rd      ),
        .o_address   ( o_mem_instruction_address )
    );

    controller controller_inst
    (
        .i_clk                           ( i_clk                     ),
        .i_reset                         ( i_reset                   ),
        .i_instruction_valid             ( i_mem_instruction_valid   ),
        .i_instruction                   ( i_mem_instruction_data    ),
        .o_valid_set_address_instruction ( set_valid                 ),
        .o_value_set_address_instruction ( set_value                 ),
        .o_mem_rd                        ( o_mem_data_rd             ),
        .o_mem_address_rd                ( o_mem_data_address_rd     ),
        .i_mem_data_rd                   ( i_mem_data_out            ),
        .o_mem_wr                        ( o_mem_data_wr             ),
        .o_mem_address_wr                ( o_mem_data_address_wr     ),
        .o_mem_data_wr                   ( o_mem_data_in             ),
        .o_load_to_accumulator_valid     ( load_to_accumulator_valid ),
        .o_load_to_accumulator_data      ( load_to_accumulator_data  ),
        .o_alu_control                   ( alu_control               ),
        .o_alu_load                      ( alu_load                  ),
        .o_alu_data                      ( alu_data                  ),
        .i_current_accum_value           ( accum_dout                )
    );

    accumulator accumulator_inst
    (
        .i_clk       ( i_clk                     ),
        .i_reset     ( i_reset                   ),
        .i_alu_valid ( alu_result_valid          ),
        .i_alu_data  ( alu_result_data           ),
        .i_mem_valid ( load_to_accumulator_valid ),
        .i_mem_data  ( load_to_accumulator_data  ),
        .o_dout      ( accum_dout                )
    );

    alu alu_inst
    (
        .i_clk     ( i_clk            ),
        .i_reset   ( i_reset          ),
        .i_control ( alu_control      ),
        .i_load    ( alu_load         ),
        .i_din_a   ( accum_dout       ),
        .i_din_b   ( alu_data         ),
        .o_valid   ( alu_result_valid ),
        .o_dout    ( alu_result_data  )
    );

endmodule