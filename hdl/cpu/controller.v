// project     : venera_cpu_1
// data        : 15.02.2022
// author      : siarhei baldzenka
// e-mail      : venera.electronica@gmail.com
// description : controller module for venera_cpu_1.

`timescale 1ns/100ps

module controller
(
    // global signals
    input  wire        i_clk,
    input  wire        i_reset,
    // instruction bus
    input  wire        i_instruction_valid,
    input  wire [15:0] i_instruction,
    // value for ac
    output reg         o_valid_set_address_instruction,
    output reg  [ 7:0] o_value_set_address_instruction,
    // memory read bus
    output reg         o_mem_rd,
    output reg  [ 7:0] o_mem_address_rd,
    input  wire [ 7:0] i_mem_data_rd,
    // memory write bus
    output reg         o_mem_wr,
    output reg  [ 7:0] o_mem_address_wr,
    output reg  [ 7:0] o_mem_data_wr,
    // load to accumulator bus
    output reg         o_load_to_accumulator_valid,
    output reg  [ 7:0] o_load_to_accumulator_data,
    // control and load to alu bus
    output reg  [ 2:0] o_alu_control,
    output reg         o_alu_load,
    output reg  [ 7:0] o_alu_data,
    // output accum value
    input  wire [ 7:0] i_current_accum_value
);

    `include "opcodes_def.v"

    reg [7:0] opcode;
    reg [7:0] operand;

    parameter [3:0] S_IDLE           = 4'h00;
    parameter [3:0] S_READ_MEM_DATA  = 4'h01;
    parameter [3:0] S_WAIT_READ_DATA = 4'h02;

    reg [3:0] state;

    always@(posedge i_clk) begin
        if (i_instruction_valid) begin
            opcode  <= i_instruction[15:8];
            operand <= i_instruction[ 7:0];
        end else begin
            opcode  <= 8'h00;
            operand <= 8'h00;
        end
    end

    always@(posedge i_clk) begin
        if (i_reset) begin
            state <= S_IDLE;
        end else begin
            case (state)
                S_IDLE: begin
                    if (opcode == LOAD) begin
                        state <= S_READ_MEM_DATA;
                    end
                end

                S_READ_MEM_DATA: begin
                    state <= S_WAIT_READ_DATA;
                end

                S_WAIT_READ_DATA: begin
                    state <= S_IDLE;
                end
            endcase
        end
    end

    // JUMP logic --------------------------------------------
    always@(posedge i_clk) begin
        if (opcode == JUMP) begin
            o_valid_set_address_instruction <= 1'b1;
            o_value_set_address_instruction <= operand;
        end else begin
            o_valid_set_address_instruction <= 1'b0;
        end
    end

    // LOAD logic --------------------------------------------
    always@(posedge i_clk) begin
        if (opcode == LOAD) begin
            o_mem_rd         <= 1'b1;
            o_mem_address_rd <= operand;
        end else begin
            o_mem_rd         <= 1'b0;
            o_mem_address_rd <= 8'h00;
        end
    end

    always@(posedge i_clk) begin
        if (state == S_WAIT_READ_DATA) begin
            o_load_to_accumulator_valid <= 1'b1;
            o_load_to_accumulator_data  <= i_mem_data_rd;
        end else begin
            o_load_to_accumulator_valid <= 1'b0;
            o_load_to_accumulator_data  <= 8'h00;
        end
    end

    // UNLOAD logic ------------------------------------------
    always@(posedge i_clk) begin
        if (opcode == UNLOAD) begin
            o_mem_wr         <= 1'b1;
            o_mem_address_wr <= operand;
            o_mem_data_wr    <= i_current_accum_value;
        end else begin
            o_mem_wr         <= 1'b0;
            o_mem_address_wr <= 8'h00;
            o_mem_data_wr    <= 8'h00;
        end
    end

    // ADD/SUB logic -----------------------------------------
    always@(posedge i_clk) begin
        if (opcode == ADD || opcode == SUB) begin
            o_alu_load <= 1'b1;
            o_alu_data <= operand;
        end else begin
            o_alu_load <= 1'b0;
        end
    end

    always@(posedge i_clk) begin
        if (opcode == ADD) begin
            o_alu_control <= 3'b001;
        end else if (opcode == SUB) begin
            o_alu_control <= 3'b010;
        end
    end
endmodule