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

    input logic up_in,
    input logic down_in,
    input logic right_in,
    input logic left_in,

    output logic vs,
    output logic hs,
    
    output logic [6:0] seg,
    output logic dp,
    output logic [3:0] an,

    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);

/**
 * VGA interface wiring
 */

vga_tim wire_tim();
vga_if wire_screen();
wire [4:0] points;
wire [1:0] screen;
wire up, down, right, left;

/**
 * Signals assignments
 */

assign up = up_in;
assign down = down_in;
assign right = right_in;
assign left = left_in;

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
    .move_up(up),
    .move_down(down),
    .move_right(right),
    .move_left(left),
    .screen,
    .ss_in(wire_tim),
    .ss_out(wire_screen),
    .points
);

screen_control u_screen_control(
    .clk,
    .rst,
    .points,
    .screen(screen),
    .keycode(keycode)
);

disp_hex_mux u_disp_hex_mux (
    .clk,
    .reset(rst),
    .dp_in('1),
    .hex0(points[3:0]),
    .hex1(points[4]),
    .hex2('0),
    .hex3('0),
    .an(an),
    .sseg({dp,seg[0],seg[1],seg[2],seg[3],seg[4],seg[5],seg[6]})
);

endmodule
