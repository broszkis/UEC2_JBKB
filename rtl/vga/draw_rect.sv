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
logic [10:0] xpos, ypos, xpos_nxt, ypos_nxt;
logic [19:0] counter;

initial begin 
    xpos = '0;
    ypos = '0;
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
    if (counter == '0) begin
        if (move_up) begin
            xpos_nxt = xpos;
            ypos_nxt = ypos - 1;
        end
        else if (move_down) begin
            xpos_nxt = xpos;
            ypos_nxt = ypos + 1;
        end
        else if (move_right) begin
            xpos_nxt = xpos + 1;
            ypos_nxt = ypos;
        end
        else if (move_left) begin
            xpos_nxt = xpos - 1;
            ypos_nxt = ypos;
        end
        else begin
            xpos_nxt = xpos;
            ypos_nxt = ypos;
        end
    end
    else begin
        xpos_nxt = xpos;
        ypos_nxt = ypos;
    end
end

always_comb begin : rect_comb_blk
    if (rect_in.hcount >= xpos - PLAYER_SIZE && rect_in.hcount <= xpos + PLAYER_SIZE && rect_in.vcount >= ypos - PLAYER_SIZE && rect_in.vcount <= ypos + PLAYER_SIZE)
        rgb_nxt = RECT_COLOR;
    else
        rgb_nxt = rect_in.rgb;
end

endmodule