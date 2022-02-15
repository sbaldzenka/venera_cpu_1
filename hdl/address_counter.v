// project: venera_cpu_1
// author:  sboldenko
// data:    11.02.2022

module address_counter
(
    input        clk,
    input        reset,
    input        set_valid,
    input  [7:0] set_value,
    output       rd,
    output [7:0] address
);

    reg [1:0] tact;
    reg       tact_flag;
    reg [7:0] current_address;

    always@(posedge clk) begin
        if (reset)
            tact <= 3'b000;
        else
            tact <= tact + 1'b1;

        if (tact == 2'b10)
            tact_flag <= 1'b1;
        else
            tact_flag <= 1'b0;
    end

    always@(posedge clk) begin
        if (reset)
            current_address <= 8'h00;
        else if (set_valid)
            current_address <= set_value;
        else if (tact_flag)
            current_address <= current_address + 1'b1;
    end

    assign rd      = tact_flag;
    assign address = current_address;

endmodule