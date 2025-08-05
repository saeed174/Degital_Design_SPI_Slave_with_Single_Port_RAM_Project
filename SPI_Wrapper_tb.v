module SPI_Wrapper_tb();

    reg MOSI,SS_n,clk,rst_n;
    wire MISO;

    SPI_Wrapper SPI(.MOSI(MOSI),.SS_n(SS_n),.clk(clk),
    .rst_n(rst_n),.MISO(MISO));

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    integer i;
    initial begin
        $readmemh("mem.dat", SPI.u_ram.mem);
        // resq test
        rst_n = 0;
        @(posedge clk);
        rst_n = 1;

        // Write Address
        @(posedge clk);
        SS_n = 0;
        @(posedge clk);
        MOSI = 0;
        @(posedge clk);
        for(i = 0; i < 10; i = i + 1) begin
            if(i < 2) begin
                MOSI = 0;
            end
            else begin
                MOSI = ~MOSI;
            end
            @(posedge clk);
            
        end
        SS_n = 1;

        // Write Data
        @(posedge clk);
        SS_n = 0;
        @(posedge clk);
        MOSI = 0;
        @(posedge clk);
        for(i = 0; i < 10; i = i + 1) begin
            if(i == 0) begin
                MOSI = 0;
            end begin
                MOSI = 1;
            end
            @(posedge clk);
        end
        SS_n = 1;

        // Read Address
        @(posedge clk);
        SS_n = 0;
        @(posedge clk);
        MOSI = 1;
        @(posedge clk);
        for(i = 0; i < 10; i = i + 1) begin
            if(i == 0) begin
                MOSI = 1;
            end
            else if(i == 1) begin
                MOSI = 0;
            end
            else if(i == 2) begin
                MOSI = 0;
            end
            else begin
                MOSI = ~MOSI;
            end
            @(posedge clk);
        end
        SS_n = 1;

        // Read Data
        @(posedge clk);
        SS_n = 0;
        @(posedge clk);
        MOSI = 1;
        @(posedge clk);
        for(i = 0; i < 10; i = i + 1) begin
            MOSI = 1;
            @(posedge clk);
        end
        for(i = 0; i < 11; i = i + 1) begin
            @(posedge clk);
        end
        @(negedge clk);
        SS_n = 1;
        $stop;
    end

endmodule