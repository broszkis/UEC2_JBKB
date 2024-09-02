/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Ksawery Broszkiewicz, Jan Bartnik
 *
 * Description:
 * 
 */
`timescale 1 ns / 1 ps

module draw_point_2 (
    vga_if.in point_in,
    vga_if.out point_out,
    input logic clk,
    input logic rst,
    input logic [9:0] point_x_2, point_y_2
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
    if (point_in.hcount >= point_x_2 - POINT_SIZE + 1 && point_in.hcount <= point_x_2 + POINT_SIZE && point_in.vcount >= point_y_2 - POINT_SIZE + 1 && point_in.vcount <= point_y_2 + POINT_SIZE) begin
        rgb_nxt = MAGENTA;
    end else begin 
        rgb_nxt = point_in.rgb;
    end
end

endmodule