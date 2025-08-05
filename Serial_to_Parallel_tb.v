module Serial_to_Parallel_tb();

    reg clk;
    reg rst_n;
    reg serial_in;
    reg enable;
    wire [9:0] parallel_out;
    wire done;

    Serial_to_Parallel STP (.clk(clk),.rst_n(rst_n),.serial_in(serial_in),
    .enable(enable),.parallel_out(parallel_out),.done(done));

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    integer i;
    initial begin
        rst_n = 1'b0;
        serial_in = 1'b0;
        enable = 1'b0;
        #2 rst_n = 1'b1;
        enable = 1'b1;
        for(i = 0; i < 50; i = i + 1) begin
            serial_in = $random % 2;
            #1;
        end

        $stop;
    end

endmodule