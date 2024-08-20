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
    input  logic rst,
    input  logic key_pressed,
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

  // VGA signals from drawing rectangle
 vga_if vga_rect();
 
 wire rectangle;
 wire [11:0] xpos;
 wire [11:0] ypos;
 wire [11:0] xpos_nxt;
 wire [11:0] ypos_nxt;

/**
 * Signals assignments
 */

 assign vs = vga_rect.vsync;
 assign hs = vga_rect.hsync;
 assign {r,g,b} = vga_rect.rgb;
 

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
    .vga_outbg(vga_bg),
    .vga_inbg(vga_timing)
);

draw_rect u_draw_rect (
    .clk,
    .rst,
    .rect_in(vga_bg),
    .rect_out(vga_rect),
    .key_pressed
);

/*
main_menu u_main_menu (
    .clk,
    .rst,
    .vga_inbg (vga_timing),
    .vga_outbg (vga_bg)
);
*/

endmodule
