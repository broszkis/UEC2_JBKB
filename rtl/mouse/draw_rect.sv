module draw_rect (
    vga_if.in vga_in,
    vga_if.out vga_out,
    input  logic clk,
    input  logic rst,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos,
    input  logic [11:0] rgb_pixel,
    output logic [11:0] pixel_addr

);

logic [11:0] rgb_nxt;
logic [11:0] pixel_addr_nxt;

import vga_pkg::*;


always_ff @(posedge clk) begin
    if (rst) begin
        vga_out.vcount <= '0;
        vga_out.vsync  <= '0;
        vga_out.vblnk  <= '0;
        vga_out.hcount <= '0;
        vga_out.hsync  <= '0;
        vga_out.hblnk  <= '0;
        vga_out.rgb    <= '0;
        pixel_addr     <= '0;
    end else begin
        vga_out.vcount <= vga_in.vcount;
        vga_out.vsync  <= vga_in.vsync;
        vga_out.vblnk  <= vga_in.vblnk;
        vga_out.hcount <= vga_in.hcount;
        vga_out.hsync  <= vga_in.hsync;
        vga_out.hblnk  <= vga_in.hblnk;
        vga_out.rgb    <= rgb_nxt;
        pixel_addr     <= pixel_addr_nxt;
    end
end

always_comb begin
    if (vga_in.vblnk || vga_in.hblnk) begin
        rgb_nxt = 12'h0_0_0;
    end else begin
        if (vga_in.hcount >= xpos  && vga_in.hcount <= xpos+WIDTH && vga_in.vcount >= ypos && vga_in.vcount <= ypos+LENGHT) begin
            rgb_nxt = rgb_pixel;
            pixel_addr_nxt = {6'(vga_in.vcount - ypos ), 6'(vga_in.hcount-xpos - 1)};
        end
        else begin
            pixel_addr_nxt = 0;
            rgb_nxt = vga_in.rgb;
        end

    end
end
endmodule