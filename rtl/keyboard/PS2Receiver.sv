`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Thomas Kappenman
// 
// Create Date: 03/03/2015 09:33:36 PM
// Design Name: PS2Receiver
// Module Name: PS2Receiver
// Project Name: Nexys4DDR Keyboard Demo
// Target Devices: Nexys4DDR
// Tool Versions: 
// Description: 
//     PS2 Receiver module used to shift in keycodes from a keyboard plugged into 
//     the PS2 port.
// 
// Dependencies: 
//     debouncer module
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PS2Receiver(
    input logic clk,
    input logic rst,
    input logic kclk,
    input logic kdata,
    output logic [15:0] keycode,
    output logic oflag
);

    // Debounced signals
    logic kclkf, kdataf;
    // Current and previous data
    logic [7:0] datacur = 8'b0;
    logic [7:0] dataprev = 8'b0;
    // Bit counter
    logic [3:0] cnt = 4'b0;
    // Flag to indicate new data
    logic flag = 1'b0;
    // Previous flag state
    logic pflag;

    // Debouncer instances for kclk and kdata
    debouncer #(
        .COUNT_MAX(19),
        .COUNT_WIDTH(5)
    ) db_clk (
        .clk(clk),
        .I(kclk),
        .O(kclkf)
    );

    debouncer #(
       .COUNT_MAX(19),
       .COUNT_WIDTH(5)
    ) db_data (
        .clk(clk),
        .I(kdata),
        .O(kdataf)
    );

    // Main state machine for processing incoming data
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin 
            keycode <= 16'b0;
            datacur <= 8'b0;
            oflag <= 1'b0;
            dataprev <= 8'b0;
            pflag <= 1'b0;
        end else begin
            if (flag && !pflag) begin
                keycode <= {dataprev, datacur};
                oflag <= 1'b1;
                dataprev <= datacur;
            end else begin
                oflag <= 1'b0;
            end
            pflag <= flag;
        end
    end

    // Shift in data on falling edge of debounced clock (kclkf)
    always_ff @(negedge kclkf) begin
        case (cnt)
            4'h0: ; // Start bit
            4'h1: datacur[0] <= kdataf;
            4'h2: datacur[1] <= kdataf;
            4'h3: datacur[2] <= kdataf;
            4'h4: datacur[3] <= kdataf;
            4'h5: datacur[4] <= kdataf;
            4'h6: datacur[5] <= kdataf;
            4'h7: datacur[6] <= kdataf;
            4'h8: datacur[7] <= kdataf;
            4'h9: flag <= 1'b1; // Parity bit (ignored)
            4'hA: flag <= 1'b0; // Stop bit (ignored)
        endcase

        if (cnt <= 4'h9) begin
            cnt <= cnt + 1;
        end else if (cnt == 4'hA) begin
            cnt <= 4'h0;
        end
    end

endmodule
