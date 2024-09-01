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
    
    input wire [15:0] keycode,

    input logic up_in,
    input logic down_in,
    input logic right_in,
    input logic left_in,
    output logic up_out,
    output logic down_out,
    output logic right_out,
    output logic left_out,

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
wire [4:0] points_1, points_2;
wire [1:0] screen;

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
    .move_up(up_in),
    .move_down(down_in),
    .move_right(right_in),
    .move_left(left_in),
    .move_up_2(up_out),
    .move_down_2(down_out),
    .move_right_2(right_out),
    .move_left_2(left_out),
    .screen,
    .keycode,
    .ss_in(wire_tim),
    .ss_out(wire_screen),
    .points_1,
    .points_2
);

screen_control u_screen_control(
    .clk,
    .rst,
    .points_1,
    .points_2,
    .screen(screen),
    .keycode(keycode)
);

disp_hex_mux u_disp_hex_mux (
    .clk,
    .reset(rst),
    .dp_in('1),
    .hex0(points_2[3:0]),
    .hex1({3'b0,points_2[4]}),
    .hex2(points_1[3:0]),
    .hex3({3'b0,points_1[4]}),
    .an(an),
    .sseg({dp,seg[0],seg[1],seg[2],seg[3],seg[4],seg[5],seg[6]})
);

endmodule
