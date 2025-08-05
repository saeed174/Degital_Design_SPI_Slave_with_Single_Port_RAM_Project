module Serial_to_Parallel(
    input clk,
    input rst_n,
    input serial_in,
    input enable,
    output reg [9:0] parallel_out,
    output reg done
);

    

    reg [3:0] bit_count;
    reg [9:0] shift_reg;

    always @(posedge clk) begin
        if (!rst_n) begin
            shift_reg    <= 10'b0;
            bit_count    <= 4'b0;
            done         <= 1'b0;
            parallel_out <= 10'b0;
        end
        else if (enable) begin
            shift_reg <= {shift_reg[8:0], serial_in};
            bit_count <= bit_count + 1;

            if (bit_count == 4'b1001) begin
                parallel_out <= {shift_reg[8:0], serial_in};
                shift_reg <= 10'b0;
                done <= 1'b1;
                bit_count <= 4'b0;
            end else begin
                done <= 1'b0;
            end
        end
        else begin
            done <= 1'b0;
        end
    end

endmodule
