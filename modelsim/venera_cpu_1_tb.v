// project: venera_cpu_1
// author:  sboldenko
// data:    11.02.2022

module venera_cpu_1_tb();

    reg clk    = 0;
    reg areset = 0;

    wire        instruction_rd;
    wire [07:0] instruction_address;
    wire [15:0] instruction_data;
    wire        data_wr;
    wire [07:0] data_address_wr;
    wire [15:0] data_in;
    wire        data_rd;
    wire [07:0] data_address_rd;
    wire [15:0] data_out;

    always #50 clk <= ~clk;

    initial begin
        areset <= 0;
        #30000;
        areset <= 1;
        #200;
        areset <= 0;
    end

    venera_cpu_1 venera_cpu_1_inst
    (
        .clk                 ( clk                 ),
        .areset              ( areset              ),
        .instruction_rd      ( instruction_rd      ),
        .instruction_address ( instruction_address ),
        .instruction_data    ( instruction_data    ),
        .data_wr             ( data_wr             ),
        .data_address_wr     ( data_address_wr     ),
        .data_in             ( data_in             ),
        .data_rd             ( data_rd             ),
        .data_address_rd     ( data_address_rd     ),
        .data_out            ( data_out            )
    );

    instruction_memory instruction_memory_inst
    (
        .clk     ( clk                 ),
        .rd      ( instruction_rd      ),
        .address ( instruction_address ),
        .dout    ( instruction_data    )
    );

    data_memory data_memory_inst
    (
        .clk        ( clk             ),
        .wr         ( data_wr         ),
        .address_wr ( data_address_wr ),
        .din        ( data_in         ),
        .rd         ( data_rd         ),
        .address_rd ( data_address_rd ),
        .dout       ( data_out        )
    );

endmodule