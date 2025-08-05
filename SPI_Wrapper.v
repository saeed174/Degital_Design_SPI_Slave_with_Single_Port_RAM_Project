module SPI_Wrapper(
    input MOSI,
    input SS_n,
    input clk,
    input rst_n,
    output MISO
    );
    wire [9:0] rx_data;
    wire rx_valid;
    wire [7:0] tx_data;
    wire tx_valid;

    SPI_Slave SPI (.MOSI(MOSI),.SS_n(SS_n),.clk(clk),.rst_n(rst_n),
    .MISO(MISO),.rx_data(rx_data),.rx_valid(rx_valid),.tx_data(tx_data),
    .tx_valid(tx_valid));

    RAM u_ram(.din(rx_data),.rx_valid(rx_valid),.dout(tx_data),
    .tx_valid(tx_valid),.clk(clk),.rst_n(rst_n));

endmodule