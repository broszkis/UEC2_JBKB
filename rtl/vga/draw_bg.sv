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
    vga_if.in vga_inbg,
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
             // postac xd
         else                                    // The rest of active display pixels:
             rgb_nxt = 12'h0_0_0;                // - fill with black.
     end
 end

 endmodule