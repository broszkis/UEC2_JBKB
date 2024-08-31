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
    input logic [15:0] keycode,
    input logic move_up,
    input logic move_down,
    input logic move_right,
    input logic move_left, 
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
vga_if wire_screen();
wire [3:0] points;
wire state screen;

/**
 * Signals assignments
 */


 assign vs = wire_screen.vsync;
 assign hs = wire_screen.hsync;
 assign {r,g,b} = wire_screen.rgb;

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
    .move_up,
    .move_down,
    .move_right,
    .move_left,
    .screen,
    .ss_in(wire_tim),
    .ss_out(wire_screen),
    .points
);

screen_control u_screen_control(
    .clk,
    .rst,
    .points,
    .screen,
    .keycode(keycode)
);

endmodule
