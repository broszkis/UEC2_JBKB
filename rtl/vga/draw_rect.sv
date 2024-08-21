module draw_rect (
    vga_if.in rect_in,
    vga_if.out rect_out,
    input logic clk,
    input logic rst,
    input logic key_pressed
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
        rect_out.vcount <= '0;
        rect_out.vsync <= '0;
        rect_out.vblnk <= '0;
        rect_out.hcount <= '0;
        rect_out.hsync <= '0;
        rect_out.hblnk <= '0;
        rect_out.rgb <= '0;
    end else begin
        rect_out.vcount <= rect_in.vcount;
        rect_out.vsync <= rect_in.vsync;
        rect_out.vblnk <= rect_in.vblnk;
        rect_out.hcount <= rect_in.hcount;
        rect_out.hsync <= rect_in.hsync;
        rect_out.hblnk <= rect_in.hblnk;
        rect_out.rgb <= rgb_nxt;
    end
end

always_comb begin : rect_comb_blk
    if (rect_in.hcount >= RECT_X && rect_in.hcount <= RECT_X + RECT_WIDTH -1 && rect_in.vcount >= RECT_Y && rect_in.vcount <= RECT_Y + RECT_HEIGHT - 1 && key_pressed == 1)
        rgb_nxt = RECT_COLOR;
    else
        rgb_nxt = rect_in.rgb;
end

endmodule