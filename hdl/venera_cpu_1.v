// project: venera_cpu_1
// author:  sboldenko
// data:    11.02.2022

module venera_cpu_1
(
    // global signals
    input         clk,
    input         areset,
    // instructions memory bus
    output        instruction_rd,
    output [07:0] instruction_address,
    input  [15:0] instruction_data,
    // data memory bus
    output        data_wr,
    output [07:0] data_address_wr,
    output [15:0] data_in,
    output        data_rd,
    output [07:0] data_address_rd,
    input  [15:0] data_out
);

    wire        reset;

    wire        set_valid;
    wire [07:0] set_value;

    wire        load_to_accumulator_valid;
    wire [15:0] load_to_accumulator_data;

    wire [02:0] alu_control;
    wire        alu_load;
    wire [15:0] alu_din_a;
    wire [15:0] alu_din_b;
    wire        alu_valid_dout;
    wire [15:0] alu_dout;

    assign data_in = alu_din_b;

    reset_module reset_module_inst
    (
        .clk    ( clk    ),
        .areset ( areset ),
        .reset  ( reset  )
    );

    address_counter address_counter_inst
    (
        .clk       ( clk                 ),
        .reset     ( reset               ),
        .set_valid ( set_valid           ),
        .set_value ( set_value           ),
        .rd        ( instruction_rd      ),
        .address   ( instruction_address )
    );

    controller controller_inst
    (
        .clk                       ( clk                       ),
        .reset                     ( reset                     ),
        .finish_instruction        ( instruction_rd            ),
        .instruction               ( instruction_data          ),
        .set_address_instruction   ( set_valid                 ),
        .value_address_instruction ( set_value                 ),
        .set_address_data_rd       ( data_rd                   ),
        .value_address_data_rd     ( data_address_rd           ),
        .value_data_rd             ( data_out                  ),
        .set_address_data_wr       ( data_wr                   ),
        .value_address_data_wr     ( data_address_wr           ),
        .load_to_accumulator_valid ( load_to_accumulator_valid ),
        .load_to_accumulator_data  ( load_to_accumulator_data  ),
        .alu_control               ( alu_control               ),
        .alu_load                  ( alu_load                  ),
        .alu_din_a                 ( alu_din_a                 )
    );

    accumulator accumulator_inst
    (
        .clk       ( clk                       ),
        .reset     ( reset                     ),
        .load      ( load_to_accumulator_valid ),
        .load_data ( load_to_accumulator_data  ),
        .valid_din ( alu_valid_dout            ),
        .din       ( alu_dout                  ),
        .dout      ( alu_din_b                 )
    );

    alu alu_inst
    (
        .clk        ( clk            ),
        .reset      ( reset          ),
        .control    ( alu_control    ),
        .load       ( alu_load       ),
        .din_a      ( alu_din_a      ),
        .din_b      ( alu_din_b      ),
        .valid_dout ( alu_valid_dout ),
        .dout       ( alu_dout       )
    );

endmodule