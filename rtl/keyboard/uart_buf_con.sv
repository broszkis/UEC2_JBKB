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
    output logic        tstart=0,
    input             tready,
    output logic [ 7:0] tbus=0
    );
    logic [31:0] sel=0;
    logic [31:0] pbuf=0;
    logic running=0;
    initial tstart <= 'b0;
    initial tbus <= 'b0;
    always_ff @(posedge clk)
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
    always_comb begin
        case (sel)
        4'h1: tbus = 8'd13;
        4'h2: tbus = 8'd10;
        4'h3: tbus = pbuf[7:0];
        4'h4: tbus = pbuf[15:8];
        4'h5: tbus = 8'd32;
        4'h6: tbus = pbuf[23:16];
        4'h7: tbus = pbuf[31:24];
        default: tbus = 8'd0;
        endcase
    end
endmodule
