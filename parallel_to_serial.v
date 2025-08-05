module parallel_to_serial (
    input wire clk,
    input wire rst_n,
    input wire [7:0] parallel_in,
    input wire load,
    output reg serial_out,
    output reg busy
);

    reg [7:0] shift_reg;
    reg [2:0] bit_count;

    always @(posedge clk) begin
        if (!rst_n) begin
            shift_reg  <= 8'd0;
            bit_count  <= 3'd0;
            serial_out <= 1'bz;
            busy       <= 1'b0;
        end 
        else if (load && !busy) begin
            shift_reg  <= parallel_in;
            bit_count  <= 3'd0;
            busy       <= 1'b1;
        end
        else if (busy) begin
            serial_out <= shift_reg[7];
            shift_reg  <= {shift_reg[6:0], 1'b0};
            bit_count  <= bit_count + 1;

            if (bit_count == 3'd7) begin
                busy <= 1'b0;
            end
        end
        else begin
            serial_out <= 1'bz;
            busy       <= 1'b0;
        end
    end

endmodule
