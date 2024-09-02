/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Ksawery Broszkiewicz, Jan Bartnik
 *
 * Description:
 * 
 */
`timescale 1 ns / 1 ps

module draw_player_2 (
    vga_if.in p2_in,
    vga_if.out p2_out,
    input logic clk,
    input logic rst,
    input logic move_up, move_down, move_right, move_left,
    output logic [9:0] xpos, ypos
);

import vga_pkg::*;

/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;
logic [9:0] xpos_nxt, ypos_nxt;
logic [19:0] counter;
wire collision_up, collision_down, collision_right, collision_left;


/*
 * Submodules
*/

collision u_collision (
    .xpos,
    .ypos,
    .collision_up,
    .collision_down,
    .collision_right,
    .collision_left
);

initial begin 
    xpos = 992;
    ypos = 736;
end

/**
 * Internal logic
 */

always_ff @(posedge clk) begin : rect_ff_blk
    if (rst) begin
        p2_out.vcount <= '0;
        p2_out.vsync <= '0;
        p2_out.vblnk <= '0;
        p2_out.hcount <= '0;
        p2_out.hsync <= '0;
        p2_out.hblnk <= '0;
        p2_out.rgb <= '0;
        xpos <= 32;
        ypos <= 32;
    end else begin
        p2_out.vcount <= p2_in.vcount;
        p2_out.vsync <= p2_in.vsync;
        p2_out.vblnk <= p2_in.vblnk;
        p2_out.hcount <= p2_in.hcount;
        p2_out.hsync <= p2_in.hsync;
        p2_out.hblnk <= p2_in.hblnk;
        p2_out.rgb <= rgb_nxt;
        xpos <= xpos_nxt;
        ypos <= ypos_nxt;
    end
end

always_ff @(posedge clk) begin 
    if (rst) begin 
        counter <= '0;
    end
    else if (counter == 300000) begin 
        counter <= '0;
    end
    else begin 
        counter <= counter + 1;
    end
end

always_comb begin

    xpos_nxt = xpos;
    ypos_nxt = ypos;

    if (counter == 0) begin

        xpos_nxt = xpos;
        ypos_nxt = ypos;

        if (move_up && !collision_up) begin
            ypos_nxt = (ypos > PLAYER_SIZE + BORDER) ? (ypos - 1) : ypos;
        end

        else if (move_down && !collision_down) begin
            ypos_nxt = (ypos + 1 < SCREEN_HEIGHT - BORDER - PLAYER_SIZE) ? (ypos + 1) : ypos;
        end

        else if (move_right && !collision_right) begin
            xpos_nxt = (xpos + 1 < SCREEN_WIDTH - BORDER - PLAYER_SIZE) ? (xpos + 1) : xpos;
        end

        else if (move_left && !collision_left) begin
            xpos_nxt = (xpos > PLAYER_SIZE + BORDER) ? (xpos - 1) : xpos;
        end
    end
end

always_comb begin : rect_comb_blk
    if (p2_in.hcount >= xpos - PLAYER_SIZE + 1 && p2_in.hcount <= xpos + PLAYER_SIZE && p2_in.vcount >= ypos - PLAYER_SIZE + 1 && p2_in.vcount <= ypos + PLAYER_SIZE) begin
        rgb_nxt = YELLOW;
    end else begin 
        rgb_nxt = p2_in.rgb;
    end
end

endmodule