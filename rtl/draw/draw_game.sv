 /**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Ksawery Broszkiewicz, Jan Bartnik
 *
 * Description:
 * 
 */
`timescale 1 ns / 1 ps

 module draw_game (
    input  logic clk,
    input  logic rst,
    input logic move_up, move_down, move_right, move_left,
    output logic [4:0] points,
    vga_tim.in game_in,
    vga_if.out game_out
);
 import vga_pkg::*;

vga_if wire_bg();
vga_if wire_rect();

 draw_bg u_draw_bg (
    .clk,
    .rst,
    .bg_in(game_in),
    .bg_out(wire_bg)
 );

 draw_rect u_draw_rect (
    .clk,
    .rst,
    .rect_in(wire_bg),
    .rect_out(wire_rect),
    .move_up,
    .move_down,
    .move_right,
    .move_left,
    .points
 );

 /**
  * Internal logic
  */

  always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        game_out.vcount <= '0;
        game_out.vsync  <= '0;
        game_out.vblnk  <= '0;
        game_out.hcount <= '0;
        game_out.hsync  <= '0;
        game_out.hblnk  <= '0;
        game_out.rgb    <= '0;
    end else begin
        game_out.vcount <= wire_rect.vcount;
        game_out.vsync  <= wire_rect.vsync;
        game_out.vblnk  <= wire_rect.vblnk;
        game_out.hcount <= wire_rect.hcount;
        game_out.hsync  <= wire_rect.hsync;
        game_out.hblnk  <= wire_rect.hblnk;
        game_out.rgb    <= wire_rect.rgb;
    end
end

 endmodule