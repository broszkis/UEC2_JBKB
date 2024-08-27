/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


 `timescale 1 ns / 1 ps

 module draw_bg (
    input  logic clk,
    input  logic rst,
    input  logic move_up, move_down, move_right, move_left,
    vga_if.in bg_in,
    vga_if.out bg_out
);
 import vga_pkg::*;


 /**
  * Local variables and signals
  */

 logic [11:0] rgb_nxt;

vga_if rect_in();
vga_if rect_out();
vga_if wire_bg();
vga_if wire_rect();


assign wire_bg.vcount = bg_in.vcount;
assign wire_bg.vsync  = bg_in.vsync;
assign wire_bg.vblnk  = bg_in.vblnk;
assign wire_bg.hcount = bg_in.hcount;
assign wire_bg.hsync  = bg_in.hsync;
assign wire_bg.hblnk  = bg_in.hblnk;
assign wire_bg.rgb    = bg_in.rgb;

 /**
  * Internal logic
  */

draw_rect u_draw_rect (
    .clk,
    .rst,
    .rect_in(wire_bg),
    .rect_out(wire_rect),
    .move_up, 
    .move_down, 
    .move_right, 
    .move_left
);
  always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        bg_out.vcount <= '0;
        bg_out.vsync  <= '0;
        bg_out.vblnk  <= '0;
        bg_out.hcount <= '0;
        bg_out.hsync  <= '0;
        bg_out.hblnk  <= '0;
        bg_out.rgb    <= '0;
    end else begin
        bg_out.vcount <= bg_in.vcount;
        bg_out.vsync  <= bg_in.vsync;
        bg_out.vblnk  <= bg_in.vblnk;
        bg_out.hcount <= bg_in.hcount;
        bg_out.hsync  <= bg_in.hsync;
        bg_out.hblnk  <= bg_in.hblnk;
        bg_out.rgb    <= rgb_nxt;
    end
end


 always_comb begin : bg_comb_blk
     if (bg_in.vblnk || bg_in.hblnk) begin             // Blanking region:
         rgb_nxt = 12'h0_0_0;                    // - make it it black.
     end else begin                              // Active region:
         if (bg_in.vcount == NULL)                     // - top edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (bg_in.vcount ==  5 && bg_in.hcount > 5 && bg_in.hcount < HOR_PIXELS - 5) // -- second blue top line.
             rgb_nxt = BLUE;
         else if (bg_in.vcount == VER_PIXELS - 1)   // - bottom edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (bg_in.vcount == VER_PIXELS - 5 && bg_in.hcount > 5 && bg_in.hcount < HOR_PIXELS - 5) // -- second blue bottom line.
             rgb_nxt = BLUE;
         else if (bg_in.hcount == NULL)                // - left edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (bg_in.hcount ==  5 && bg_in.vcount > 5 && bg_in.vcount < VER_PIXELS - 5) // -- second blue left line.
             rgb_nxt = BLUE;
         else if (bg_in.hcount == HOR_PIXELS - 1)   // - right edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (bg_in.hcount == HOR_PIXELS - 5 && bg_in.vcount > 5 && bg_in.vcount < VER_PIXELS - 5) // -- second blue right line.
             rgb_nxt = BLUE;
             // -- left top corner
         else if (bg_in.hcount >  TERRAIN_LTX1 && bg_in.hcount <  TERRAIN_LTX1 + 5  && bg_in.vcount >  TERRAIN_LTY1 && bg_in.vcount <  TERRAIN_LTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_LTX1 && bg_in.hcount <  TERRAIN_LTX2  && bg_in.vcount >  TERRAIN_LTY1 && bg_in.vcount <  TERRAIN_LTY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_LTX1 && bg_in.hcount <  TERRAIN_LTX2  && bg_in.vcount >  TERRAIN_LTY2 - 5 && bg_in.vcount <  TERRAIN_LTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_LTX2 - 5 && bg_in.hcount <  TERRAIN_LTX2  && bg_in.vcount >  TERRAIN_LTY1 && bg_in.vcount <  TERRAIN_LTY2) 
             rgb_nxt = BLUE;
             // -- right top corner
         else if (bg_in.hcount >  TERRAIN_RTX1 && bg_in.hcount <  TERRAIN_RTX1 + 5  && bg_in.vcount >  TERRAIN_RTY1 && bg_in.vcount <  TERRAIN_RTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_RTX1 && bg_in.hcount <  TERRAIN_RTX2  && bg_in.vcount >  TERRAIN_RTY1 && bg_in.vcount <  TERRAIN_RTY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_RTX1 && bg_in.hcount <  TERRAIN_RTX2  && bg_in.vcount >  TERRAIN_RTY2 - 5 && bg_in.vcount <  TERRAIN_RTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_RTX2 - 5 && bg_in.hcount <  TERRAIN_RTX2  && bg_in.vcount >  TERRAIN_RTY1 && bg_in.vcount <  TERRAIN_RTY2) 
             rgb_nxt = BLUE;
             // -- left bottom corner
         else if (bg_in.hcount >  TERRAIN_LBX1 && bg_in.hcount <  TERRAIN_LBX1 + 5  && bg_in.vcount >  TERRAIN_LBY1 && bg_in.vcount <  TERRAIN_LBY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_LBX1 && bg_in.hcount <  TERRAIN_LBX2  && bg_in.vcount >  TERRAIN_LBY1 && bg_in.vcount <  TERRAIN_LBY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_LBX1 && bg_in.hcount <  TERRAIN_LBX2  && bg_in.vcount >  TERRAIN_LBY2 - 5 && bg_in.vcount <  TERRAIN_LBY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_LBX2 - 5 && bg_in.hcount <  TERRAIN_LBX2  && bg_in.vcount >  TERRAIN_LBY1 && bg_in.vcount <  TERRAIN_LBY2) 
             rgb_nxt = BLUE;
             // -- right bottom corner
         else if (bg_in.hcount >  TERRAIN_RBX1 && bg_in.hcount <  TERRAIN_RBX1 + 5  && bg_in.vcount >  TERRAIN_RBY1 && bg_in.vcount <  TERRAIN_RBY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_RBX1 && bg_in.hcount <  TERRAIN_RBX2  && bg_in.vcount >  TERRAIN_RBY1 && bg_in.vcount <  TERRAIN_RBY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_RBX1 && bg_in.hcount <  TERRAIN_RBX2  && bg_in.vcount >  TERRAIN_RBY2 - 5 && bg_in.vcount <  TERRAIN_RBY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_RBX2 - 5 && bg_in.hcount <  TERRAIN_RBX2  && bg_in.vcount >  TERRAIN_RBY1 && bg_in.vcount <  TERRAIN_RBY2) 
             rgb_nxt = BLUE;
             // -- middle top T
         else if (bg_in.hcount >  TERRAIN_MTTX1 && bg_in.hcount <  TERRAIN_MTTX1 + 5  && bg_in.vcount >  TERRAIN_MTTY1 && bg_in.vcount <  TERRAIN_MTTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MTTX1 && bg_in.hcount <  TERRAIN_MTTX2  && bg_in.vcount >  TERRAIN_MTTY1 && bg_in.vcount <  TERRAIN_MTTY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MTTX1 && bg_in.hcount <  TERRAIN_MTTX2  && bg_in.vcount >  TERRAIN_MTTY2 - 5 && bg_in.vcount <  TERRAIN_MTTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MTTX2 - 5 && bg_in.hcount <  TERRAIN_MTTX2  && bg_in.vcount >  TERRAIN_MTTY1 && bg_in.vcount <  TERRAIN_MTTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MTSX1 && bg_in.hcount <  TERRAIN_MTSX1 + 5  && bg_in.vcount >  TERRAIN_MTSY1 && bg_in.vcount <  TERRAIN_MTSY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MTSX1 && bg_in.hcount <  TERRAIN_MTSX2  && bg_in.vcount >  TERRAIN_MTSY1 && bg_in.vcount <  TERRAIN_MTSY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MTSX1 && bg_in.hcount <  TERRAIN_MTSX2  && bg_in.vcount >  TERRAIN_MTSY2 - 5 && bg_in.vcount <  TERRAIN_MTSY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MTSX2 - 5 && bg_in.hcount <  TERRAIN_MTSX2  && bg_in.vcount >  TERRAIN_MTSY1 && bg_in.vcount <  TERRAIN_MTSY2) 
             rgb_nxt = BLUE; 
             // -- middle bottom T
         else if (bg_in.hcount >  TERRAIN_MBTX1 && bg_in.hcount <  TERRAIN_MBTX1 + 5  && bg_in.vcount >  TERRAIN_MBTY1 && bg_in.vcount <  TERRAIN_MBTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MBTX1 && bg_in.hcount <  TERRAIN_MBTX2  && bg_in.vcount >  TERRAIN_MBTY1 && bg_in.vcount <  TERRAIN_MBTY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MBTX1 && bg_in.hcount <  TERRAIN_MBTX2  && bg_in.vcount >  TERRAIN_MBTY2 - 5 && bg_in.vcount <  TERRAIN_MBTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MBTX2 - 5 && bg_in.hcount <  TERRAIN_MBTX2  && bg_in.vcount >  TERRAIN_MBTY1 && bg_in.vcount <  TERRAIN_MBTY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MBSX1 && bg_in.hcount <  TERRAIN_MBSX1 + 5  && bg_in.vcount >  TERRAIN_MBSY1 && bg_in.vcount <  TERRAIN_MBSY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MBSX1 && bg_in.hcount <  TERRAIN_MBSX2  && bg_in.vcount >  TERRAIN_MBSY1 && bg_in.vcount <  TERRAIN_MBSY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MBSX1 && bg_in.hcount <  TERRAIN_MBSX2  && bg_in.vcount >  TERRAIN_MBSY2 - 5 && bg_in.vcount <  TERRAIN_MBSY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MBSX2 - 5 && bg_in.hcount <  TERRAIN_MBSX2  && bg_in.vcount >  TERRAIN_MBSY1 && bg_in.vcount <  TERRAIN_MBSY2) 
             rgb_nxt = BLUE;  
             // --middle obstacle
         else if (bg_in.hcount >  TERRAIN_MMX1 && bg_in.hcount <  TERRAIN_MMX1 + 5  && bg_in.vcount >  TERRAIN_MMY1 && bg_in.vcount <  TERRAIN_MMY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MMX1 && bg_in.hcount <  TERRAIN_MMX2  && bg_in.vcount >  TERRAIN_MMY1 && bg_in.vcount <  TERRAIN_MMY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MMX1 && bg_in.hcount <  TERRAIN_MMX2  && bg_in.vcount >  TERRAIN_MMY2 - 5 && bg_in.vcount <  TERRAIN_MMY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MMX2 - 5 && bg_in.hcount <  TERRAIN_MMX2  && bg_in.vcount >  TERRAIN_MMY1 && bg_in.vcount <  TERRAIN_MMY2) 
             rgb_nxt = BLUE; 
             // --middle obstacle
         else if (bg_in.hcount >  TERRAIN_MLX1 && bg_in.hcount <  TERRAIN_MLX1 + 5  && bg_in.vcount >  TERRAIN_MLY1 && bg_in.vcount <  TERRAIN_MLY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MLX1 && bg_in.hcount <  TERRAIN_MLX2  && bg_in.vcount >  TERRAIN_MLY1 && bg_in.vcount <  TERRAIN_MLY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MLX1 && bg_in.hcount <  TERRAIN_MLX2  && bg_in.vcount >  TERRAIN_MLY2 - 5 && bg_in.vcount <  TERRAIN_MLY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MLX2 - 5 && bg_in.hcount <  TERRAIN_MLX2  && bg_in.vcount >  TERRAIN_MLY1 && bg_in.vcount <  TERRAIN_MLY2) 
             rgb_nxt = BLUE;
             // --middle obstacle
         else if (bg_in.hcount >  TERRAIN_MRX1 && bg_in.hcount <  TERRAIN_MRX1 + 5  && bg_in.vcount >  TERRAIN_MRY1 && bg_in.vcount <  TERRAIN_MRY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MRX1 && bg_in.hcount <  TERRAIN_MRX2  && bg_in.vcount >  TERRAIN_MRY1 && bg_in.vcount <  TERRAIN_MRY1 + 5) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MRX1 && bg_in.hcount <  TERRAIN_MRX2  && bg_in.vcount >  TERRAIN_MRY2 - 5 && bg_in.vcount <  TERRAIN_MRY2) 
             rgb_nxt = BLUE;
         else if (bg_in.hcount >  TERRAIN_MRX2 - 5 && bg_in.hcount <  TERRAIN_MRX2  && bg_in.vcount >  TERRAIN_MRY1 && bg_in.vcount <  TERRAIN_MRY2) 
             rgb_nxt = BLUE;
         else                                    // The rest of active display pixels:
            rgb_nxt = 12'h0_0_0;                // - fill with black.
     end
 end

 endmodule