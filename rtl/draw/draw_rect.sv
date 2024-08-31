module draw_rect (
    vga_if.in rect_in,
    vga_if.out rect_out,
    input logic clk,
    input logic rst,
    input logic move_up, move_down, move_right, move_left
);

import vga_pkg::*;

/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;
logic [9:0] xpos, ypos, xpos_nxt, ypos_nxt, point_x, point_y;
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

random_generate u_random_generate (
    .clk,
    .rst,
    .player_x(xpos),
    .player_y(ypos),
    .point_x,
    .point_y
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
        rect_out.vcount <= '0;
        rect_out.vsync <= '0;
        rect_out.vblnk <= '0;
        rect_out.hcount <= '0;
        rect_out.hsync <= '0;
        rect_out.hblnk <= '0;
        rect_out.rgb <= '0;
        xpos <= '0;
        ypos <= '0;
    end else begin
        rect_out.vcount <= rect_in.vcount;
        rect_out.vsync <= rect_in.vsync;
        rect_out.vblnk <= rect_in.vblnk;
        rect_out.hcount <= rect_in.hcount;
        rect_out.hsync <= rect_in.hsync;
        rect_out.hblnk <= rect_in.hblnk;
        rect_out.rgb <= rgb_nxt;
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
    if (rect_in.hcount >= xpos - PLAYER_SIZE + 1 && rect_in.hcount <= xpos + PLAYER_SIZE && rect_in.vcount >= ypos - PLAYER_SIZE + 1 && rect_in.vcount <= ypos + PLAYER_SIZE)
        rgb_nxt = RECT_COLOR;
    else if (rect_in.hcount >= point_x - POINT_SIZE + 1 && rect_in.hcount <= point_x + POINT_SIZE && rect_in.vcount >= point_y - POINT_SIZE + 1 && rect_in.vcount <= point_y + POINT_SIZE)
        rgb_nxt = POINT_COLOR;
    else
        rgb_nxt = rect_in.rgb;
end

endmodule