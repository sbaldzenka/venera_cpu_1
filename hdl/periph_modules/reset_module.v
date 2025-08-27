// project     : venera_cpu_1
// data        : 14.02.2022
// author      : siarhei baldzenka
// e-mail      : venera.electronica@gmail.com
// description : synchronous reset.

module reset_module
(
    input  wire i_clk,
    input  wire i_areset,
    output wire o_reset
);

    reg [2:0] crossclock_reset;

    reg [7:0] counter    = 8'd0;
    reg       reset_flag = 1'b0;

    parameter [1:0] S_POWER_UP = 0,
                    S_RESET    = 1,
                    S_IDLE     = 2;

    reg [1:0] current_state = 2'd0;

    always@(posedge i_clk) begin
        crossclock_reset <= {crossclock_reset[1:0], i_areset};
    end

    always@(posedge i_clk)
    begin
        case (current_state)
            S_POWER_UP: begin
                counter <= counter + 1'b1;

                if (counter == 8'hFF) begin
                    current_state <= S_RESET;
                end
            end

            S_RESET: begin
                counter    <= counter + 1'b1;
                reset_flag <= 1'b1;

                if (counter == 8'h0F) begin
                    current_state <= S_IDLE;
                end
            end

            S_IDLE: begin
                reset_flag <= 1'b0;
                counter    <= 8'd0;
            end

            default: current_state <= S_IDLE;
        endcase
    end

    assign o_reset = (current_state == S_IDLE) ? crossclock_reset[2] : reset_flag;

endmodule