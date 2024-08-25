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
    output wire Vsync,
    output wire Hsync,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output wire JA1
);


/**
 * Local variables and signals
 */

wire clk65MHz;
wire clk91MHz;
wire pclk_mirror;
wire [15:0] keycode;
wire move_up, move_down, move_right, move_left;

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
    .clk91MHz,
    .clk65MHz,
    .locked()
 );
 


top_keyboard u_top_keyboard(
    .clk(clk91MHz),
    .PS2Clk(PS2Clk),
    .PS2Data(PS2Data),
    .keycode
 );

controls u_controls(
    .clk(clk91MHz),
    .rst(btnC),
    .keycode,
    .move_up,
    .move_down,
    .move_right,
    .move_left
);

top_vga u_top_vga(
    .clk(clk65MHz),
    .rst(btnC),
    .r(vgaRed),
    .g(vgaGreen),
    .b(vgaBlue),
    .hs(Hsync),
<<<<<<< HEAD
    .vs(Vsync)
=======
    .vs(Vsync),
    .move_up,
    .move_down,
    .move_right,
    .move_left
>>>>>>> bf5e9b6510cdd95151311c199ac7331dabc0d0bf
);

endmodule
