module draw_point (
    vga_if.in point_in,
    vga_if.out point_out,
    input logic clk,
    input logic rst,
    input logic [9:0] point_x, point_y
);

import vga_pkg::*;

/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;

/**
 * Internal logic
 */

always_ff @(posedge clk) begin : rect_ff_blk
    if (rst) begin
        point_out.vcount <= '0;
        point_out.vsync <= '0;
        point_out.vblnk <= '0;
        point_out.hcount <= '0;
        point_out.hsync <= '0;
        point_out.hblnk <= '0;
        point_out.rgb <= '0;
    end else begin
        point_out.vcount <= point_in.vcount;
        point_out.vsync <= point_in.vsync;
        point_out.vblnk <= point_in.vblnk;
        point_out.hcount <= point_in.hcount;
        point_out.hsync <= point_in.hsync;
        point_out.hblnk <= point_in.hblnk;
        point_out.rgb <= rgb_nxt;
    end
end

always_comb begin
    if (point_in.hcount >= point_x - POINT_SIZE + 1 && point_in.hcount <= point_x + POINT_SIZE && point_in.vcount >= point_y - POINT_SIZE + 1 && point_in.vcount <= point_y + POINT_SIZE) begin
        rgb_nxt = POINT_COLOR;
    end else begin 
        rgb_nxt = point_in.rgb;
    end
end

endmodule