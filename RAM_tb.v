module RAM_tb ();

    reg [9:0] din;
    reg rx_valid,clk,rst_n;
    wire tx_valid;
    wire [7:0] dout;

    RAM DUT(.din(din), .rx_valid(rx_valid), .clk(clk), .rst_n(rst_n), .tx_valid(tx_valid), .dout(dout));

    initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
        end
    end

    integer i;
    initial begin
        $readmemh("mem.dat",DUT.mem);
        rst_n = 0;
        din = 0;
        rx_valid = 0;
        #2 rst_n = 1;

        for(i = 0; i < 256; i = i + 1) begin
            if(i%2 == 0) begin
                din[9:8] = 2'b00;
            end
            else begin
                din[9:8] = 2'b01;
            end
            din[7:0] = $random % 257;
            rx_valid = $random;
            @(negedge clk);
        end

        for(i = 0; i < 256; i = i + 1) begin
            if(i%2 == 0) begin
                din[9:8] = 2'b10;
            end
            else begin
                din[9:8] = 2'b11;
            end
            din[7:0] = $random % 257;
            rx_valid = $random;
            @(negedge clk);
        end

        $stop;
    end

endmodule