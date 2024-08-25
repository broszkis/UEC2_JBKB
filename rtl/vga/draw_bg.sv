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
    vga_tim.in vga_inbg,
    vga_if.out vga_outbg
);
 import vga_pkg::*;


 /**
  * Local variables and signals
  */

 logic [11:0] rgb_nxt;


 /**
  * Internal logic
  */

  always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        vga_outbg.vcount <= '0;
        vga_outbg.vsync  <= '0;
        vga_outbg.vblnk  <= '0;
        vga_outbg.hcount <= '0;
        vga_outbg.hsync  <= '0;
        vga_outbg.hblnk  <= '0;
        vga_outbg.rgb    <= '0;
    end else begin
        vga_outbg.vcount <= vga_inbg.vcount;
        vga_outbg.vsync  <= vga_inbg.vsync;
        vga_outbg.vblnk  <= vga_inbg.vblnk;
        vga_outbg.hcount <= vga_inbg.hcount;
        vga_outbg.hsync  <= vga_inbg.hsync;
        vga_outbg.hblnk  <= vga_inbg.hblnk;
        vga_outbg.rgb    <= rgb_nxt;
    end
end


 always_comb begin : bg_comb_blk
     if (vga_inbg.vblnk || vga_inbg.hblnk) begin             // Blanking region:
         rgb_nxt = 12'h0_0_0;                    // - make it it black.
     end else begin                              // Active region:
         if (vga_inbg.vcount == NULL)                     // - top edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.vcount ==  5 && vga_inbg.hcount > 5 && vga_inbg.hcount < HOR_PIXELS - 5) // -- second blue top line.
             rgb_nxt = BLUE;
         else if (vga_inbg.vcount == VER_PIXELS - 1)   // - bottom edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.vcount == VER_PIXELS - 5 && vga_inbg.hcount > 5 && vga_inbg.hcount < HOR_PIXELS - 5) // -- second blue bottom line.
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount == NULL)                // - left edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.hcount ==  5 && vga_inbg.vcount > 5 && vga_inbg.vcount < VER_PIXELS - 5) // -- second blue left line.
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount == HOR_PIXELS - 1)   // - right edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.hcount == HOR_PIXELS - 5 && vga_inbg.vcount > 5 && vga_inbg.vcount < VER_PIXELS - 5) // -- second blue right line.
             rgb_nxt = BLUE;
             // -- left top corner
         else if (vga_inbg.hcount >  TERRAIN_LTX1 && vga_inbg.hcount <  TERRAIN_LTX1 + 5  && vga_inbg.vcount >  TERRAIN_LTY1 && vga_inbg.vcount <  TERRAIN_LTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_LTX1 && vga_inbg.hcount <  TERRAIN_LTX2  && vga_inbg.vcount >  TERRAIN_LTY1 && vga_inbg.vcount <  TERRAIN_LTY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_LTX1 && vga_inbg.hcount <  TERRAIN_LTX2  && vga_inbg.vcount >  TERRAIN_LTY2 - 5 && vga_inbg.vcount <  TERRAIN_LTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_LTX2 - 5 && vga_inbg.hcount <  TERRAIN_LTX2  && vga_inbg.vcount >  TERRAIN_LTY1 && vga_inbg.vcount <  TERRAIN_LTY2) 
             rgb_nxt = BLUE;
             // -- right top corner
         else if (vga_inbg.hcount >  TERRAIN_RTX1 && vga_inbg.hcount <  TERRAIN_RTX1 + 5  && vga_inbg.vcount >  TERRAIN_RTY1 && vga_inbg.vcount <  TERRAIN_RTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_RTX1 && vga_inbg.hcount <  TERRAIN_RTX2  && vga_inbg.vcount >  TERRAIN_RTY1 && vga_inbg.vcount <  TERRAIN_RTY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_RTX1 && vga_inbg.hcount <  TERRAIN_RTX2  && vga_inbg.vcount >  TERRAIN_RTY2 - 5 && vga_inbg.vcount <  TERRAIN_RTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_RTX2 - 5 && vga_inbg.hcount <  TERRAIN_RTX2  && vga_inbg.vcount >  TERRAIN_RTY1 && vga_inbg.vcount <  TERRAIN_RTY2) 
             rgb_nxt = BLUE;
             // -- left bottom corner
         else if (vga_inbg.hcount >  TERRAIN_LBX1 && vga_inbg.hcount <  TERRAIN_LBX1 + 5  && vga_inbg.vcount >  TERRAIN_LBY1 && vga_inbg.vcount <  TERRAIN_LBY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_LBX1 && vga_inbg.hcount <  TERRAIN_LBX2  && vga_inbg.vcount >  TERRAIN_LBY1 && vga_inbg.vcount <  TERRAIN_LBY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_LBX1 && vga_inbg.hcount <  TERRAIN_LBX2  && vga_inbg.vcount >  TERRAIN_LBY2 - 5 && vga_inbg.vcount <  TERRAIN_LBY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_LBX2 - 5 && vga_inbg.hcount <  TERRAIN_LBX2  && vga_inbg.vcount >  TERRAIN_LBY1 && vga_inbg.vcount <  TERRAIN_LBY2) 
             rgb_nxt = BLUE;
             // -- right bottom corner
         else if (vga_inbg.hcount >  TERRAIN_RBX1 && vga_inbg.hcount <  TERRAIN_RBX1 + 5  && vga_inbg.vcount >  TERRAIN_RBY1 && vga_inbg.vcount <  TERRAIN_RBY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_RBX1 && vga_inbg.hcount <  TERRAIN_RBX2  && vga_inbg.vcount >  TERRAIN_RBY1 && vga_inbg.vcount <  TERRAIN_RBY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_RBX1 && vga_inbg.hcount <  TERRAIN_RBX2  && vga_inbg.vcount >  TERRAIN_RBY2 - 5 && vga_inbg.vcount <  TERRAIN_RBY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_RBX2 - 5 && vga_inbg.hcount <  TERRAIN_RBX2  && vga_inbg.vcount >  TERRAIN_RBY1 && vga_inbg.vcount <  TERRAIN_RBY2) 
             rgb_nxt = BLUE;
             // -- middle top T
         else if (vga_inbg.hcount >  TERRAIN_MTTX1 && vga_inbg.hcount <  TERRAIN_MTTX1 + 5  && vga_inbg.vcount >  TERRAIN_MTTY1 && vga_inbg.vcount <  TERRAIN_MTTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MTTX1 && vga_inbg.hcount <  TERRAIN_MTTX2  && vga_inbg.vcount >  TERRAIN_MTTY1 && vga_inbg.vcount <  TERRAIN_MTTY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MTTX1 && vga_inbg.hcount <  TERRAIN_MTTX2  && vga_inbg.vcount >  TERRAIN_MTTY2 - 5 && vga_inbg.vcount <  TERRAIN_MTTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MTTX2 - 5 && vga_inbg.hcount <  TERRAIN_MTTX2  && vga_inbg.vcount >  TERRAIN_MTTY1 && vga_inbg.vcount <  TERRAIN_MTTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MTSX1 && vga_inbg.hcount <  TERRAIN_MTSX1 + 5  && vga_inbg.vcount >  TERRAIN_MTSY1 && vga_inbg.vcount <  TERRAIN_MTSY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MTSX1 && vga_inbg.hcount <  TERRAIN_MTSX2  && vga_inbg.vcount >  TERRAIN_MTSY1 && vga_inbg.vcount <  TERRAIN_MTSY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MTSX1 && vga_inbg.hcount <  TERRAIN_MTSX2  && vga_inbg.vcount >  TERRAIN_MTSY2 - 5 && vga_inbg.vcount <  TERRAIN_MTSY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MTSX2 - 5 && vga_inbg.hcount <  TERRAIN_MTSX2  && vga_inbg.vcount >  TERRAIN_MTSY1 && vga_inbg.vcount <  TERRAIN_MTSY2) 
             rgb_nxt = BLUE; 
             // -- middle bottom T
         else if (vga_inbg.hcount >  TERRAIN_MBTX1 && vga_inbg.hcount <  TERRAIN_MBTX1 + 5  && vga_inbg.vcount >  TERRAIN_MBTY1 && vga_inbg.vcount <  TERRAIN_MBTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MBTX1 && vga_inbg.hcount <  TERRAIN_MBTX2  && vga_inbg.vcount >  TERRAIN_MBTY1 && vga_inbg.vcount <  TERRAIN_MBTY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MBTX1 && vga_inbg.hcount <  TERRAIN_MBTX2  && vga_inbg.vcount >  TERRAIN_MBTY2 - 5 && vga_inbg.vcount <  TERRAIN_MBTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MBTX2 - 5 && vga_inbg.hcount <  TERRAIN_MBTX2  && vga_inbg.vcount >  TERRAIN_MBTY1 && vga_inbg.vcount <  TERRAIN_MBTY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MBSX1 && vga_inbg.hcount <  TERRAIN_MBSX1 + 5  && vga_inbg.vcount >  TERRAIN_MBSY1 && vga_inbg.vcount <  TERRAIN_MBSY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MBSX1 && vga_inbg.hcount <  TERRAIN_MBSX2  && vga_inbg.vcount >  TERRAIN_MBSY1 && vga_inbg.vcount <  TERRAIN_MBSY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MBSX1 && vga_inbg.hcount <  TERRAIN_MBSX2  && vga_inbg.vcount >  TERRAIN_MBSY2 - 5 && vga_inbg.vcount <  TERRAIN_MBSY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MBSX2 - 5 && vga_inbg.hcount <  TERRAIN_MBSX2  && vga_inbg.vcount >  TERRAIN_MBSY1 && vga_inbg.vcount <  TERRAIN_MBSY2) 
             rgb_nxt = BLUE;  
             // --middle obstacle
         else if (vga_inbg.hcount >  TERRAIN_MMX1 && vga_inbg.hcount <  TERRAIN_MMX1 + 5  && vga_inbg.vcount >  TERRAIN_MMY1 && vga_inbg.vcount <  TERRAIN_MMY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MMX1 && vga_inbg.hcount <  TERRAIN_MMX2  && vga_inbg.vcount >  TERRAIN_MMY1 && vga_inbg.vcount <  TERRAIN_MMY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MMX1 && vga_inbg.hcount <  TERRAIN_MMX2  && vga_inbg.vcount >  TERRAIN_MMY2 - 5 && vga_inbg.vcount <  TERRAIN_MMY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MMX2 - 5 && vga_inbg.hcount <  TERRAIN_MMX2  && vga_inbg.vcount >  TERRAIN_MMY1 && vga_inbg.vcount <  TERRAIN_MMY2) 
             rgb_nxt = BLUE; 
             // --middle obstacle
         else if (vga_inbg.hcount >  TERRAIN_MLX1 && vga_inbg.hcount <  TERRAIN_MLX1 + 5  && vga_inbg.vcount >  TERRAIN_MLY1 && vga_inbg.vcount <  TERRAIN_MLY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MLX1 && vga_inbg.hcount <  TERRAIN_MLX2  && vga_inbg.vcount >  TERRAIN_MLY1 && vga_inbg.vcount <  TERRAIN_MLY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MLX1 && vga_inbg.hcount <  TERRAIN_MLX2  && vga_inbg.vcount >  TERRAIN_MLY2 - 5 && vga_inbg.vcount <  TERRAIN_MLY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MLX2 - 5 && vga_inbg.hcount <  TERRAIN_MLX2  && vga_inbg.vcount >  TERRAIN_MLY1 && vga_inbg.vcount <  TERRAIN_MLY2) 
             rgb_nxt = BLUE;
             // --middle obstacle
         else if (vga_inbg.hcount >  TERRAIN_MRX1 && vga_inbg.hcount <  TERRAIN_MRX1 + 5  && vga_inbg.vcount >  TERRAIN_MRY1 && vga_inbg.vcount <  TERRAIN_MRY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MRX1 && vga_inbg.hcount <  TERRAIN_MRX2  && vga_inbg.vcount >  TERRAIN_MRY1 && vga_inbg.vcount <  TERRAIN_MRY1 + 5) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MRX1 && vga_inbg.hcount <  TERRAIN_MRX2  && vga_inbg.vcount >  TERRAIN_MRY2 - 5 && vga_inbg.vcount <  TERRAIN_MRY2) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount >  TERRAIN_MRX2 - 5 && vga_inbg.hcount <  TERRAIN_MRX2  && vga_inbg.vcount >  TERRAIN_MRY1 && vga_inbg.vcount <  TERRAIN_MRY2) 
             rgb_nxt = BLUE;
         else                                    // The rest of active display pixels:
             rgb_nxt = 12'h0_0_0;                // - fill with black.
     end
 end

 endmodule