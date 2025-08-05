module RAM (
    input [9:0] din,
    input rx_valid,clk,rst_n,
    output reg tx_valid,
    output reg [7:0] dout
);

    parameter MEM_DEPTH = 256;
    parameter ADDR_SIZE = 8;
    
    reg [ADDR_SIZE-1:0] write_address;
    reg [ADDR_SIZE-1:0] read_address;

    reg [7:0] mem [0:MEM_DEPTH-1];


    always @(posedge clk) begin
        if(!rst_n) begin
            dout <= 0;
            tx_valid <= 0;
        end
        else begin
            if(rx_valid) begin
                case(din[9:8])
                    2'b00 : begin
                        write_address <= din[7:0];
                        dout <= 8'bzzzzzzzz;
                        tx_valid <= 1'bz;
                    end
                    2'b01 : begin
                        mem [write_address] <= din[7:0];
                        dout <= 8'bzzzzzzzz;
                        tx_valid <= 1'bz;
                    end
                    2'b10 : begin
                        read_address <= din[7:0];
                        dout <= 8'bzzzzzzzz;
                        tx_valid <= 1'bz;
                    end
                    2'b11 : begin
                        dout <= mem [read_address];
                        tx_valid <= 1;
                    end
                    default : begin
                        dout <= 8'bzzzzzzzz;
                        tx_valid <= 1'bz;
                    end
                endcase
            end
            else begin
                dout <= 0;
                tx_valid <= 0;
            end
        end
    end

endmodule //RAM