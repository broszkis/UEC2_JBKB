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

vga_if wire_tim();
vga_if wire_screen();

/**
 * Signals assignments
 */


 assign vs = wire_screen.vsync;
 assign hs = wire_screen.hsync;
 assign {r,g,b} = wire_screen.rgb;
 

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
    .ss_in(wire_tim),
    .ss_out(wire_screen)
);

screen_control u_screen_control(
    .clk,
    .rst,
    .screen(screen),
    .keycode(keycode)
);


endmodule
