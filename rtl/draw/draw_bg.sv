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
<<<<<<< HEAD
    input logic [14:0][31:0] position_x,
    input logic [14:0][31:0] position_y,
    vga_if.in vga_inbg,
    vga_if.out vga_outbg
=======
    vga_tim.in bg_in,
    vga_if.out bg_out
>>>>>>> multiplayer
);
 import vga_pkg::*;


 /**
  * Local variables and signals
  */

 logic [11:0] rgb_nxt;

<<<<<<< HEAD

=======
>>>>>>> multiplayer
 /**
  * Internal logic
  */

  always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
<<<<<<< HEAD
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
=======
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
>>>>>>> multiplayer
    end
end


 always_comb begin : bg_comb_blk
<<<<<<< HEAD
     if (vga_inbg.vblnk || vga_inbg.hblnk) begin             // Blanking region:
         rgb_nxt = 12'h0_0_0;                    // - make it it black.
     end else begin                              // Active region:
         if (vga_inbg.vcount == NULL)                     // - top edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.vcount == NULL + 5 && vga_inbg.hcount > NULL +5 && vga_inbg.hcount < HOR_PIXELS - 5) // -- second blue top line.
             rgb_nxt = BLUE;
         else if (vga_inbg.vcount == VER_PIXELS - 1)   // - bottom edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.vcount == VER_PIXELS - 5 && vga_inbg.hcount > NULL +5 && vga_inbg.hcount < HOR_PIXELS - 5) // -- second blue bottom line.
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount == NULL)                // - left edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.hcount == NULL + 5 && vga_inbg.vcount > NULL +5 && vga_inbg.vcount < VER_PIXELS - 5) // -- second blue left line.
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount == HOR_PIXELS - 1)   // - right edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.hcount == HOR_PIXELS - 5 && vga_inbg.vcount > NULL +5 && vga_inbg.vcount < VER_PIXELS - 5) // -- second blue right line.
             rgb_nxt = BLUE;
             // --middle obstacle
         else if (vga_inbg.hcount > NULL + 460 && vga_inbg.hcount < NULL + 465  && vga_inbg.vcount > NULL + 348 && vga_inbg.vcount < NULL + 420) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 560 && vga_inbg.hcount < NULL + 565  && vga_inbg.vcount > NULL + 348 && vga_inbg.vcount < NULL + 420) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 460 && vga_inbg.hcount < NULL + 565  && vga_inbg.vcount > NULL + 348 && vga_inbg.vcount < NULL + 353) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 460 && vga_inbg.hcount < NULL + 565  && vga_inbg.vcount > NULL + 415 && vga_inbg.vcount < NULL + 420) 
             rgb_nxt = BLUE;
             // -- left top corner
         else if (vga_inbg.hcount > NULL + 60 && vga_inbg.hcount < NULL + 65  && vga_inbg.vcount > NULL + 55 && vga_inbg.vcount < NULL + 100) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 60 && vga_inbg.hcount < NULL + 165  && vga_inbg.vcount > NULL + 55 && vga_inbg.vcount < NULL + 60) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 60 && vga_inbg.hcount < NULL + 165  && vga_inbg.vcount > NULL + 95 && vga_inbg.vcount < NULL + 100) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 160 && vga_inbg.hcount < NULL + 165  && vga_inbg.vcount > NULL + 55 && vga_inbg.vcount < NULL + 100) 
             rgb_nxt = BLUE;
             // -- right top corner
         else if (vga_inbg.hcount > NULL + 859 && vga_inbg.hcount < NULL + 964  && vga_inbg.vcount > NULL + 55 && vga_inbg.vcount < NULL + 60) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 859 && vga_inbg.hcount < NULL + 964  && vga_inbg.vcount > NULL + 95 && vga_inbg.vcount < NULL + 100) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 859 && vga_inbg.hcount < NULL + 864  && vga_inbg.vcount > NULL + 55 && vga_inbg.vcount < NULL + 100) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 959 && vga_inbg.hcount < NULL + 964  && vga_inbg.vcount > NULL + 55 && vga_inbg.vcount < NULL + 100) 
             rgb_nxt = BLUE;
             // -- left bottom corner
         else if (vga_inbg.hcount > NULL + 60 && vga_inbg.hcount < NULL + 165  && vga_inbg.vcount > NULL + 708 && vga_inbg.vcount < NULL + 713) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 60 && vga_inbg.hcount < NULL + 165  && vga_inbg.vcount > NULL + 668 && vga_inbg.vcount < NULL + 673)
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 60 && vga_inbg.hcount < NULL + 65  && vga_inbg.vcount > NULL + 668 && vga_inbg.vcount < NULL + 713)
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 160 && vga_inbg.hcount < NULL + 165  && vga_inbg.vcount > NULL + 668 && vga_inbg.vcount < NULL + 713)
             rgb_nxt = BLUE;
             // -- right bottom corner
         else if (vga_inbg.hcount > NULL + 859 && vga_inbg.hcount < NULL + 964  && vga_inbg.vcount > NULL + 668 && vga_inbg.vcount < NULL + 673) 
             rgb_nxt = BLUE;    
         else if (vga_inbg.hcount > NULL + 859 && vga_inbg.hcount < NULL + 964  && vga_inbg.vcount > NULL + 708 && vga_inbg.vcount < NULL + 713) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 859 && vga_inbg.hcount < NULL + 864  && vga_inbg.vcount > NULL + 668 && vga_inbg.vcount < NULL + 713) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 959 && vga_inbg.hcount < NULL + 964  && vga_inbg.vcount > NULL + 668 && vga_inbg.vcount < NULL + 713) 
             rgb_nxt = BLUE;
             // -- middle top T
         else if (vga_inbg.hcount > NULL + 215 && vga_inbg.hcount < NULL + 809  && vga_inbg.vcount > NULL + 100 && vga_inbg.vcount < NULL + 105) 
             rgb_nxt = BLUE;    
         else if (vga_inbg.hcount > NULL + 215 && vga_inbg.hcount < NULL + 220  && vga_inbg.vcount > NULL + 100 && vga_inbg.vcount < NULL + 161) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 804 && vga_inbg.hcount < NULL + 809  && vga_inbg.vcount > NULL + 100 && vga_inbg.vcount < NULL + 161) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 215 && vga_inbg.hcount < NULL + 482  && vga_inbg.vcount > NULL + 156 && vga_inbg.vcount < NULL + 161) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 537 && vga_inbg.hcount < NULL + 809  && vga_inbg.vcount > NULL + 156 && vga_inbg.vcount < NULL + 161) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 477 && vga_inbg.hcount < NULL + 482  && vga_inbg.vcount > NULL + 156 && vga_inbg.vcount < NULL + 298) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 537 && vga_inbg.hcount < NULL + 542  && vga_inbg.vcount > NULL + 156 && vga_inbg.vcount < NULL + 298) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 477 && vga_inbg.hcount < NULL + 542  && vga_inbg.vcount > NULL + 293 && vga_inbg.vcount < NULL + 298) 
             rgb_nxt = BLUE; 
             // -- middle bottom T
         else if (vga_inbg.hcount > NULL + 215 && vga_inbg.hcount < NULL + 482  && vga_inbg.vcount > NULL + 613 && vga_inbg.vcount < NULL + 618) 
             rgb_nxt = BLUE;    
         else if (vga_inbg.hcount > NULL + 215 && vga_inbg.hcount < NULL + 220  && vga_inbg.vcount > NULL + 613 && vga_inbg.vcount < NULL + 673) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 804 && vga_inbg.hcount < NULL + 809  && vga_inbg.vcount > NULL + 613 && vga_inbg.vcount < NULL + 673) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 215 && vga_inbg.hcount < NULL + 809  && vga_inbg.vcount > NULL + 668 && vga_inbg.vcount < NULL + 673) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 537 && vga_inbg.hcount < NULL + 809  && vga_inbg.vcount > NULL + 613 && vga_inbg.vcount < NULL + 618) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 477 && vga_inbg.hcount < NULL + 482  && vga_inbg.vcount > NULL + 476 && vga_inbg.vcount < NULL + 618) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 537 && vga_inbg.hcount < NULL + 542  && vga_inbg.vcount > NULL + 476 && vga_inbg.vcount < NULL + 618) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 477 && vga_inbg.hcount < NULL + 542  && vga_inbg.vcount > NULL + 476 && vga_inbg.vcount < NULL + 481) 
             rgb_nxt = BLUE; 
             // --middle obstacle
         else if (vga_inbg.hcount > NULL + 110 && vga_inbg.hcount < NULL + 410  && vga_inbg.vcount > NULL + 300 && vga_inbg.vcount < NULL + 305) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 110 && vga_inbg.hcount < NULL + 115  && vga_inbg.vcount > NULL + 300 && vga_inbg.vcount < NULL + 500) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 405 && vga_inbg.hcount < NULL + 410  && vga_inbg.vcount > NULL + 300 && vga_inbg.vcount < NULL + 500) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 110 && vga_inbg.hcount < NULL + 410  && vga_inbg.vcount > NULL + 495 && vga_inbg.vcount < NULL + 500) 
             rgb_nxt = BLUE;
             // --middle obstacle
         else if (vga_inbg.hcount > NULL + 609 && vga_inbg.hcount < NULL + 909  && vga_inbg.vcount > NULL + 300 && vga_inbg.vcount < NULL + 305) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 609 && vga_inbg.hcount < NULL + 614  && vga_inbg.vcount > NULL + 300 && vga_inbg.vcount < NULL + 500) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 904 && vga_inbg.hcount < NULL + 909  && vga_inbg.vcount > NULL + 300 && vga_inbg.vcount < NULL + 500) 
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount > NULL + 609 && vga_inbg.hcount < NULL + 909  && vga_inbg.vcount > NULL + 495 && vga_inbg.vcount < NULL + 500) 
             rgb_nxt = BLUE;
             //kropka
         else if (vga_inbg.hcount == 512  && vga_inbg.vcount == 384)
            rgb_nxt =  12'h0_f_f;
         else if ( position_x > 0 && position_y > 0  && vga_inbg.hcount == 30 && vga_inbg.vcount == 30)
            rgb_nxt =  12'h0_f_f;
         else                                    // The rest of active display pixels:
             rgb_nxt = 12'h0_0_0;                // - fill with black.
=======
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
>>>>>>> multiplayer
     end
 end

 endmodule