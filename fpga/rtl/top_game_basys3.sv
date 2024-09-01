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
 * Top level synthesizable module including the project top and all the FPGA-referred modules.
 */

`timescale 1 ns / 1 ps

module top_game_basys3 (
    input  wire clk,
    input  wire btnC,
    
    input wire PS2Clk,
    input wire PS2Data,
   
    output wire [6:0] seg,
    output wire [3:0] an,
    output wire dp,

    output wire Vsync,
    output wire Hsync,
    
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,

    input wire JC1, JC2, JC3, JC4,
    output wire JC7, JC8, JC9, JC10,

    output wire JA1
);


/**
 * Local variables and signals
 */

wire clk65MHz;
wire clk97MHz;
wire pclk_mirror;
logic [15:0] keycode;

(* KEEP = "TRUE" *)
(* ASYNC_REG = "TRUE" *)
logic [7:0] safe_start = 0;
// For details on synthesis attributes used above, see AMD Xilinx UG 901:
// https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes


/**
 * Signals assignments
 */


 assign JA1 = pclk_mirror;

/**
 * FPGA submodules placement
 */

ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(clk65MHz),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
);

/**
 *  Project functional top module
 */

clk_wiz_0_clk_wiz u_clk_wiz_0_clk_wiz(
    .clk,
    .clk97MHz,
    .clk65MHz,
    .locked()
 );
 


top_keyboard u_top_keyboard(
    .clk(clk97MHz),
    .PS2Clk(PS2Clk),
    .PS2Data(PS2Data),
    .keycode
 );

/*
hold u_hold (
    .clk(clk65MHz),
    .rst(btnC),
    .move_up,
    .move_down,
    .move_right,
    .move_left,
    .keycode,
    .move_up_ff,
    .move_down_ff,
    .move_right_ff,
    .move_left_ff,
    .keycode_ff
);
*/
top_vga u_top_vga(
    .clk(clk65MHz),
    .rst(btnC),
    .r(vgaRed),
    .g(vgaGreen),
    .b(vgaBlue),
    .hs(Hsync),
    .vs(Vsync),
    .seg(),
    .dp,
    .an,
    .up_in(JC1),
    .down_in(JC2),
    .right_in(JC3),
    .left_in(JC4),
    .up_out(JC7),
    .down_out(JC8),
    .right_out(JC9),
    .left_out(JC10),
    .keycode
);

assign seg = u_top_vga.seg[6:0];

endmodule
