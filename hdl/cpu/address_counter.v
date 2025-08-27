// project     : venera_cpu_1
// data        : 11.02.2022
// author      : siarhei baldzenka
// e-mail      : venera.electronica@gmail.com
// description : address counter for read command from memory.

`timescale 1ns/100ps

module address_counter
(
    // global signals
    input  wire       i_clk,
    input  wire       i_reset,
    // set address
    input  wire       i_set_valid,
    input  wire [7:0] i_set_value,
    // read address bus
    output wire       o_rd,
    output wire [7:0] o_address
);

    reg [1:0] tact;
    reg       tact_flag;
    reg [7:0] program_counter; // PC

    always@(posedge i_clk) begin
        if (i_reset) begin
            tact <= 2'b00;
        end else begin
            tact <= tact + 1'b1;
        end

        if (tact == 2'b10) begin
            tact_flag <= 1'b1;
        end else begin
            tact_flag <= 1'b0;
        end
    end

    always@(posedge i_clk) begin
        if (i_reset) begin
            program_counter <= 8'h00;
        end else if (i_set_valid) begin
            program_counter <= i_set_value;
        end else if (tact_flag) begin
            program_counter <= program_counter + 1'b1;
        end
    end

    assign o_rd      = tact_flag;
    assign o_address = program_counter;

endmodule