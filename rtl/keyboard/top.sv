`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc 
// Engineer: Arthur Brown
// 
// Create Date: 07/27/2016 02:04:01 PM
// Design Name: Basys3 Keyboard Demo
// Module Name: top
// Project Name: Keyboard
// Target Devices: Basys3
// Tool Versions: 2016.X
// Description: 
//     Receives input from USB-HID in the form of a PS/2, displays keyboard key presses and releases over USB-UART.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//     Known issue, when multiple buttons are pressed and one is released, the scan code of the one still held down is sometimes re-sent.
//////////////////////////////////////////////////////////////////////////////////

module top(
    input         clk,
    input         PS2Data,
    input         PS2Clk,
    output        tx
);

    // Internal signals
    wire          tready;
    wire          ready;
    wire          tstart;
    reg           start = 0;
    reg           CLK50MHZ = 0;
    wire [31:0]   tbuf;
    reg  [15:0]   keycodev = 0;
    wire [15:0]   keycode;
    wire [7:0]    tbus;
    reg  [2:0]    bcount = 0;
    wire          flag;
    reg           cn = 0;
    
    // Generate 50MHz clock from input clock
    always @(posedge clk) begin
        CLK50MHZ <= ~CLK50MHZ;
    end
    
    // PS/2 Receiver instance
    PS2Receiver ps2_receiver (
        .clk(CLK50MHZ),
        .rst(1'b0),  // Reset signal can be added if required
        .kclk(PS2Clk),
        .kdata(PS2Data),
        .keycode(keycode),
        .oflag(flag)
    );
    
    // Logic to handle keycode processing
    always @(*) begin
        if (keycode[7:0] == 8'hF0) begin
            cn = 1'b0;
            bcount = 3'd0;
        end else if (keycode[15:8] == 8'hF0) begin
            cn = keycode != keycodev;
            bcount = 3'd5;
        end else begin
            cn = (keycode[7:0] != keycodev[7:0]) || (keycodev[15:8] == 8'hF0);
            bcount = 3'd2;
        end
    end

    // Logic to start UART transmission when a new keycode is received
    always @(posedge clk) begin
        if (flag && cn) begin
            start <= 1'b1;
            keycodev <= keycode;
        end else begin
            start <= 1'b0;
        end
    end
            
    // Binary to ASCII conversion
    bin2ascii #(
        .NBYTES(2)
    ) ascii_converter (
        .I(keycodev),
        .O(tbuf)
    );
    
    // UART buffer controller instance
    uart_buf_con uart_buffer (
        .clk    (clk),
        .bcount (bcount),
        .tbuf   (tbuf),  
        .start  (start), 
        .ready  (ready), 
        .tstart (tstart),
        .tready (tready),
        .tbus   (tbus)
    );
    
    // UART transmitter instance
    uart_tx uart_transmitter (
        .clk    (clk),
        .start  (tstart),
        .tbus   (tbus),
        .tx     (tx),
        .ready  (tready)
    );
    
endmodule