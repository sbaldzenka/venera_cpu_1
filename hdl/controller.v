// project: venera_cpu_1
// author:  sboldenko
// data:    15.02.2022

module controller
(
    input         clk,
    input         reset,

    input         finish_instruction,
    input  [15:0] instruction,

    output        set_address_instruction,
    output [07:0] value_address_instruction,

    output        set_address_data_rd,
    output [07:0] value_address_data_rd,
    input  [15:0] value_data_rd,

    output        set_address_data_wr,
    output [07:0] value_address_data_wr,

    output        load_to_accumulator_valid,
    output [15:0] load_to_accumulator_data,

    output [2:0]  alu_control,
    output        alu_load,
    output [15:0] alu_din_a
);

    reg  [01:0] set_address_reg;
    reg  [07:0] value_address_reg;
    reg  [02:0] set_address_data_rd_reg;
    reg  [07:0] value_address_data_rd_reg;
    reg  [02:0] set_address_data_wr_reg;
    reg  [07:0] value_address_data_wr_reg;
    reg  [02:0] alu_control_reg;
    reg  [01:0] alu_load_reg;
    reg         alu_loading;
    reg  [15:0] alu_din_a_reg;
    wire [07:0] opcode;

    assign opcode = instruction[15:8];

    always@(posedge clk) begin
        set_address_reg         <= 2'b00;
        set_address_data_rd_reg <= 3'b000;
        set_address_data_wr_reg <= 3'b000;
        alu_load_reg            <= {alu_load_reg[0], alu_loading};

        if (finish_instruction)
            alu_loading <= 1'b0;
        else
            case (opcode)
                8'h00: begin 
                    alu_control_reg <= 3'b001;
                    alu_loading     <= 1'b1;
                    alu_din_a_reg   <= {8'h00, instruction[7:0]};
                end
                8'h01: begin
                    alu_control_reg <= 3'b010;
                    alu_loading     <= 1'b1;
                    alu_din_a_reg   <= {8'h00, instruction[7:0]};
                end
                8'h02: begin
                    alu_control_reg <= 3'b011;
                    alu_loading     <= 1'b1;
                    alu_din_a_reg   <= {8'h00, instruction[7:0]};
                end
                8'h03: begin
                    set_address_data_rd_reg   <= {set_address_data_rd_reg[1:0], 1'b1};
                    value_address_data_rd_reg <= {8'h00, instruction[7:0]};
                end
                8'h04: begin
                    set_address_data_wr_reg   <= {set_address_data_wr_reg[1:0], 1'b1};
                    value_address_data_wr_reg <= {8'h00, instruction[7:0]};
                end
                8'h05: begin
                    set_address_reg   <= {set_address_reg[0], 1'b1};
                    value_address_reg <= {8'h00, instruction[7:0]};
                end
            endcase
    end

    assign set_address_instruction   = (set_address_reg == 2'b01) ? 1'b1 : 1'b0;
    assign value_address_instruction = value_address_reg;

    assign set_address_data_rd       = set_address_data_rd_reg;
    assign value_address_data_rd     = value_address_data_rd_reg;

    assign set_address_data_wr       = (set_address_data_wr_reg == 3'b011) ? 1'b1 : 1'b0;
    assign value_address_data_wr     = value_address_data_wr_reg;

    assign load_to_accumulator_valid = (set_address_data_rd_reg == 3'b011) ? 1'b1 : 1'b0;
    assign load_to_accumulator_data  = value_data_rd;

    assign alu_control               = alu_control_reg;
    assign alu_load                  = (alu_load_reg == 2'b01) ? 1'b1 : 1'b0;
    assign alu_din_a                 = alu_din_a_reg;

endmodule