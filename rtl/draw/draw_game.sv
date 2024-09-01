`timescale 1 ns / 1 ps

module draw_game (
    input  logic clk,
    input  logic rst,
    input wire [15:0] keycode,
    input logic move_up, move_down, move_right, move_left,
    output logic move_up_2, move_down_2, move_right_2, move_left_2,
    output logic [4:0] points_1, points_2,
    vga_tim.in game_in,
    vga_if.out game_out
);
import vga_pkg::*;

vga_if wire_bg();
vga_if wire_point();
vga_if wire_p1();
vga_if wire_p2();

wire [9:0] p1x, p1y, p2x, p2y, point_x, point_y;

controls u_controls(
    .clk,
    .rst,
    .keycode,
    .move_up(move_up_2),
    .move_down(move_down_2),
    .move_right(move_right_2),
    .move_left(move_left_2)
);

draw_bg u_draw_bg (
   .clk,
   .rst,
   .bg_in(game_in),
   .bg_out(wire_bg)
);

draw_player_1 u_draw_player_1 (
   .clk,
   .rst,
   .p1_in(wire_bg),
   .p1_out(wire_p1),
   .xpos(p1x),
   .ypos(p1y),
   .move_up(move_up_2),
   .move_down(move_down_2),
   .move_right(move_right_2),
   .move_left(move_left_2)

);

draw_player_2 u_draw_player_2 (
   .clk,
   .rst,
   .p2_in(wire_p1),
   .p2_out(wire_p2),
   .xpos(p2x),
   .ypos(p2y),
   .move_up,
   .move_down,
   .move_right,
   .move_left
);

draw_point u_draw_point (
   .clk,
   .rst,
   .point_in(wire_p2),
   .point_out(wire_point),
   .point_x,
   .point_y
);

random_generate u_random_generate (
    .clk,   
    .rst,  
    .player1_x(p1x),
    .player1_y(p1y),
    .player2_x(p2x),
    .player2_y(p2y),
    .point_x,
    .point_y,
    .points_1,
    .points_2
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
        game_out.vcount <= wire_point.vcount;
        game_out.vsync  <= wire_point.vsync;
        game_out.vblnk  <= wire_point.vblnk;
        game_out.hcount <= wire_point.hcount;
        game_out.hsync  <= wire_point.hsync;
        game_out.hblnk  <= wire_point.hblnk;
        game_out.rgb    <= wire_point.rgb;
    end
end

 endmodule