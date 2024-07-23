/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic clk100MHz, 
    input  logic rst,
    input logic RsTx,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);


/**
 * Local variables and signals
 */

// VGA signals from timing
 vga_if vga_timing();

 // VGA signals from background
 vga_if vga_bg();
 
 wire rectangle;
 wire [11:0] xpos;
 wire [11:0] ypos;
 wire [11:0] xpos_nxt;
 wire [11:0] ypos_nxt;

/**
 * Signals assignments
 */

 assign vs = vga_bg.vsync;
 assign hs = vga_bg.hsync;
 assign {r,g,b} = vga_bg.rgb;
 

/**
 * Submodules instances
 */

 vga_timing u_vga_timing (
    .clk,
    .rst,
    .vga_out (vga_timing)
);

draw_bg u_draw_bg (
    .clk,
    .rst,
    .vga_outbg( vga_bg ),
    .vga_inbg( vga_timing ),
    .rectangle_nxt(rectangle)
);


spawn u_spawn(
    .clk,
    .rectangle,
    .rst,
    .rx(RsTx)
);

endmodule
