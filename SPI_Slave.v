module SPI_Slave(
    input MOSI,
    input SS_n,
    input clk,
    input rst_n,
    input [7:0] tx_data,
    input tx_valid,
    output MISO,
    output reg [9:0] rx_data,
    output reg rx_valid
    );

    parameter IDLE = 5'b00001;
    parameter CHK_CMD = 5'b00010;
    parameter WRITE = 5'b00100;
    parameter READ_ADD = 5'b01000;
    parameter READ_DATA = 5'b10000;

    (* fsm_encoding = "one_hot" *)
    reg [4:0] cs,ns;
    reg addr_or_data ;
    reg STP_enable;
    wire STP_Done;
    wire [9:0] STP_out;
    wire PTS_busy, PTS_out;

    Serial_to_Parallel STP (.clk(clk), .rst_n(rst_n), .serial_in(MOSI),
    .enable(STP_enable), .parallel_out(STP_out), .done(STP_Done));

    parallel_to_serial PTS (.clk(clk), .rst_n(rst_n), .parallel_in(tx_data),
    .load(tx_valid), .serial_out(MISO), .busy(PTS_busy));

    always @(cs,SS_n,MOSI) begin
        case(cs)
            IDLE: begin
                if(SS_n) begin
                    ns = IDLE;
                end
                else begin
                    ns = CHK_CMD;
                end
            end
            CHK_CMD: begin
                if(SS_n) begin
                    ns = IDLE;
                end
                else begin
                    if(MOSI) begin
                        if(addr_or_data) begin
                            ns = READ_DATA;
                        end
                        else begin
                            ns = READ_ADD;
                        end
                    end
                    else begin
                        ns = WRITE;
                    end
                end
            end
            WRITE: begin
                if(SS_n) begin
                    ns = IDLE;
                end
                else begin
                    ns = WRITE;
                end
            end
            READ_ADD: begin
                if(SS_n) begin
                    ns = IDLE;
                end
                else begin
                    ns = READ_ADD;
                end
            end
            READ_DATA: begin
                if(SS_n) begin
                    ns = IDLE;
                end
                else begin
                    ns = READ_DATA;
                end
            end
            default : ns = IDLE;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cs <= IDLE;
        end
        else begin
            cs <= ns;
        end
    end

    always @(posedge clk) begin
        if(cs == IDLE || cs == CHK_CMD) begin
            STP_enable <= 0;
            rx_data<= {10{1'bz}};
            rx_valid <= 1'b0;
        end
        else if(cs == WRITE) begin
            STP_enable <= 1;
            if(STP_Done) begin
                rx_valid <= 1;
                rx_data <= STP_out;
                STP_enable <= 0;
            end
        end
        else if(cs == READ_ADD) begin
            STP_enable <= 1;
            if(STP_Done) begin
                rx_valid <= 1;
                rx_data <= STP_out;
                addr_or_data <= 1;
                STP_enable <= 0;
            end
        end
        else if (cs == READ_DATA) begin
            STP_enable <= 1;
            if(STP_Done) begin
                rx_valid <= 1;
                rx_data<= STP_out;
                addr_or_data <= 0;
                STP_enable <= 0;
            end
        end
        else begin
            STP_enable <= 0;
            rx_data<= {10{1'bz}};
            rx_valid <= 1'b0;
        end
    end
endmodule