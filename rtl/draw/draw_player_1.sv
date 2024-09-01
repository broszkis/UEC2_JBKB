module draw_player_1 (
    vga_if.in p1_in,
    vga_if.out p1_out,
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
    xpos = 32;
    ypos = 32;
end

/**
 * Internal logic
 */

always_ff @(posedge clk) begin : rect_ff_blk
    if (rst) begin
        p1_out.vcount <= '0;
        p1_out.vsync <= '0;
        p1_out.vblnk <= '0;
        p1_out.hcount <= '0;
        p1_out.hsync <= '0;
        p1_out.hblnk <= '0;
        p1_out.rgb <= '0;
        xpos <= 32;
        ypos <= 32;
    end else begin
        p1_out.vcount <= p1_in.vcount;
        p1_out.vsync <= p1_in.vsync;
        p1_out.vblnk <= p1_in.vblnk;
        p1_out.hcount <= p1_in.hcount;
        p1_out.hsync <= p1_in.hsync;
        p1_out.hblnk <= p1_in.hblnk;
        p1_out.rgb <= rgb_nxt;
        xpos <= xpos_nxt;
        ypos <= ypos_nxt;
    end
end

always_ff @(posedge clk) begin 
    if (rst) begin 
        counter <= '0;
    end
    else if (counter == 500000) begin 
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
            ypos_nxt = (ypos > PLAYER_SIZE) ? (ypos - 1) : ypos;
        end

        else if (move_down && !collision_down) begin
            ypos_nxt = (ypos + 1 < SCREEN_HEIGHT - PLAYER_SIZE) ? (ypos + 1) : ypos;
        end

        else if (move_right && !collision_right) begin
            xpos_nxt = (xpos + 1 < SCREEN_WIDTH - PLAYER_SIZE) ? (xpos + 1) : xpos;
        end

        else if (move_left && !collision_left) begin
            xpos_nxt = (xpos > PLAYER_SIZE) ? (xpos - 1) : xpos;
        end
    end
end

always_comb begin : rect_comb_blk
    if (p1_in.hcount >= xpos - PLAYER_SIZE + 1 && p1_in.hcount <= xpos + PLAYER_SIZE && p1_in.vcount >= ypos - PLAYER_SIZE + 1 && p1_in.vcount <= ypos + PLAYER_SIZE) begin
        rgb_nxt = RECT_COLOR;
    end else begin 
        rgb_nxt = p1_in.rgb;
    end
end

endmodule