module parallel_to_serial_tb();

    reg clk;
    reg rst_n;
    reg [7:0] parallel_in;
    reg load;
    wire serial_out;
    wire busy;

    parallel_to_serial P2S (.clk(clk), .rst_n(rst_n), .parallel_in(parallel_in), .load(load), .serial_out(serial_out), .busy(busy));

    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        #2 rst_n = 1'b1;
        parallel_in = 8'b10110101;
        load = 1'b1;
        #20 $stop;
    end

endmodule