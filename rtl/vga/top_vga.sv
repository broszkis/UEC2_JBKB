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
    input logic [7:0] din,
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

/**draw_bg u_draw_bg (
    .clk,
    .rst,
    .vga_outbg( vga_bg ),
    .vga_inbg( vga_timing ),
    .rectangle_nxt(rectangle)
);**/

main_menu u_main_menu (
    .clk,
    .rst,
    .vga_inbg (vga_timing),
    .vga_outbg (vga_bg)
);

draw_mouse u_draw_mouse(
.clk (clk),
.rst,
.xpos(xposnxt),
.ypos(yposnxt),
.vga_in (vga_rect),
.vga_out (vga_mouse)
);

wire left;

MouseCtl u_MouseCtl (
    .clk(clk100MHz),
    .rst,
    .left(left),
    .ps2_data(PS2Data),
    .ps2_clk(PS2Clk),

    .xpos(xpos),
    .ypos(ypos)
);
/**spawn u_spawn(
    .clk,
    .rectangle,
    .rst,
    .data(din)
);**/


endmodule
