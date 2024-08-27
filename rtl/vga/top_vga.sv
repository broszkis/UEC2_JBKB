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
    input logic move_up, move_down, move_right, move_left,
    input logic [15:0] keycode,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);

/**
 * VGA interface wiring
 */

vga_tim wire_tim();
vga_tim tim_out();
vga_if wire_bg();
vga_if wire_rect();
vga_if bg_in();
vga_if bg_out();

/**
 * Signals assignments
 */


 assign vs = wire_rect.vsync;
 assign hs = wire_rect.hsync;
 assign {r,g,b} = wire_rect.rgb;
 

state screen;


/**
 * Submodules instances
 */

vga_timing u_vga_timing (
    .clk,
    .rst,
    .tim_out(wire_tim)
);

screen_selector u_screen_selector(
    .clk,
    .rst,
    .screen(screen),
    .bg_in,
    .bg_out
);

screen_control u_screen_control(
    .clk,
    .rst,
    .screen(screen),
    .keycode(keycode)
);


endmodule
