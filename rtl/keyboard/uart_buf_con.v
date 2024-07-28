`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc
// Engineer: Arthur Brown
// 
// Create Date: 07/27/2016 03:53:30 PM
// Design Name: 
// Module Name: uart_buf_con
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//  
//////////////////////////////////////////////////////////////////////////////////


module uart_buf_con(
    input             clk,
    input      [ 2:0] bcount,
    input      [31:0] tbuf,
    input             start,
    output            ready,
    output reg        tstart,
    input             tready,
    output reg [ 7:0] tbus
    );
    reg [2:0] sel=0;
    reg [31:0] pbuf=0;
    reg running=0;
    initial tstart <= 'b0;
    initial tbus <= 'b0;
    always@(posedge clk)
        if (tready == 1'b1) begin
            if (running == 1'b1) begin
                if (sel == 4'd1) begin
                    running <= 1'b0;
                    sel <= bcount + 2'd2;
                end else begin
                    sel <= sel - 1'b1;
                    tstart <= 1'b1;
                    running <= 1'b1;
                end
            end else begin
                if (bcount != 2'b0) begin
                    pbuf <= tbuf;
                    tstart <= start;
                    running <= start;
                    sel <= bcount + 2'd2;
                end
            end
        end else
            tstart <= 1'b0;
    assign ready = ~running;
    always@(sel, pbuf)
        case (sel)
        3'd1: tbus = 8'd13;
        3'd2: tbus = 8'd10;
        3'd3: tbus = pbuf[7:0];
        3'd4: tbus = pbuf[15:8];
        3'd5: tbus = 8'd32;
        3'd6: tbus = pbuf[23:16];
        3'd7: tbus = pbuf[31:24];
        default: tbus = 8'd0;
        endcase
endmodule
