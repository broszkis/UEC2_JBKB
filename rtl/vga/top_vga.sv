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
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b,
    inout logic PS2Clk,
    inout logic PS2Data,
    input logic clk100MHz

);


/**
 * Local variables and signals
 */

// VGA signals from timing
 vga_if vga_timing();

 // VGA signals from background
 vga_if vga_bg();
 
 // VGA signals from rectangle
 vga_if vga_rect();
 
 // VGA signals from mouse
 vga_if vga_mouse();

 wire [11:0] xpos;
 wire [11:0] ypos;
 wire [11:0] xposnxt;
 wire [11:0] yposnxt;
 wire [11:0] xposnxt1;
 wire [11:0] yposnxt1;
 wire [11:0] rgb_wire;
 wire [11:0] address_wire;

//logic rx_empty;
//logic ruart; 
//logic [3:0] hex0, hex1, hex2, hex3;
//logic [7:0] rdata;

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
    .vga_inbg( vga_timing )
);

wire left;
logic middle;
logic new_event;
logic right;
logic setmax_x;
logic setmax_y;
logic setx;
logic sety;
logic value;
logic zpos;

MouseCtl u_MouseCtl (
    .clk(clk100MHz),
    .rst,
    .left(left),
    .ps2_data(PS2Data),
    .ps2_clk(PS2Clk),

    .xpos(xpos),
    .ypos(ypos),
    .middle,
    .new_event,
    .right,
    .setmax_x,
    .setmax_y,
    .setx,
    .sety,
    .value,
    .zpos
);


endmodule
