module draw_mouse (
    vga_if.in vga_in,
    vga_if.out vga_out,
    input  logic clk,
    input  logic rst,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos

);

MouseDisplay inst(
  .blank(vga_in.vblnk || vga_in.hblnk),
  .enable_mouse_display_out(),
  .hcount(vga_in.hcount),
  .pixel_clk(clk),
  .rgb_in(vga_in.rgb),
  .rgb_out(vga_out.rgb),
  .vcount(vga_in.vcount),
  .xpos(xpos),
  .ypos(ypos)
);

always_ff @(posedge clk) begin
    if (rst) begin
        vga_out.vsync  <= '0;
        vga_out.hsync  <= '0;
    end else begin
        vga_out.vsync  <= vga_in.vsync;
        vga_out.hsync  <= vga_in.hsync;
    end
end

endmodule