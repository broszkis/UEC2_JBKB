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
    vga_if.in bg_in,
    vga_if.out bg_out
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
             rgb_nxt = 12'h0_0_f;                // - - make a blue line.
         else if (bg_in.vcount == 5 && bg_in.hcount > 5 && bg_in.hcount < HOR_PIXELS - 5) // -- second blue top line.
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.vcount == VER_PIXELS - 1)   // - bottom edge:
             rgb_nxt = 12'h0_0_f;                // - - make a blue line.
         else if (bg_in.vcount == VER_PIXELS - 5 && bg_in.hcount > NULL +5 && bg_in.hcount < HOR_PIXELS - 5) // -- second blue bottom line.
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount == NULL)                // - left edge:
             rgb_nxt = 12'h0_0_f;                // - - make a blue line.
         else if (bg_in.hcount == 5 && bg_in.vcount > NULL +5 && bg_in.vcount < VER_PIXELS - 5) // -- second blue left line.
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount == HOR_PIXELS - 1)   // - right edge:
             rgb_nxt = 12'h0_0_f;                // - - make a blue line.
         else if (bg_in.hcount == HOR_PIXELS - 5 && bg_in.vcount > NULL +5 && bg_in.vcount < VER_PIXELS - 5) // -- second blue right line.
             rgb_nxt = 12'h0_0_f;
             // --middle obstacle
         else if (bg_in.hcount > 460 && bg_in.hcount < 465  && bg_in.vcount > 348 && bg_in.vcount < 420) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 560 && bg_in.hcount < 565  && bg_in.vcount > 348 && bg_in.vcount < 420) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 460 && bg_in.hcount < 565  && bg_in.vcount > 348 && bg_in.vcount < 353) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 460 && bg_in.hcount < 565  && bg_in.vcount > 415 && bg_in.vcount < 420) 
             rgb_nxt = 12'h0_0_f;
             // -- left top corner
         else if (bg_in.hcount > 60 && bg_in.hcount < 65  && bg_in.vcount > 55 && bg_in.vcount < 100) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 60 && bg_in.hcount < 165  && bg_in.vcount > 55 && bg_in.vcount < 60) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 60 && bg_in.hcount < 165  && bg_in.vcount > 95 && bg_in.vcount < 100) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 160 && bg_in.hcount < 165  && bg_in.vcount > 55 && bg_in.vcount < 100) 
             rgb_nxt = 12'h0_0_f;
             // -- right top corner
         else if (bg_in.hcount > 859 && bg_in.hcount < 964  && bg_in.vcount > 55 && bg_in.vcount < 60) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 859 && bg_in.hcount < 964  && bg_in.vcount > 95 && bg_in.vcount < 100) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 859 && bg_in.hcount < 864  && bg_in.vcount > 55 && bg_in.vcount < 100) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 959 && bg_in.hcount < 964  && bg_in.vcount > 55 && bg_in.vcount < 100) 
             rgb_nxt = 12'h0_0_f;
             // -- left bottom corner
         else if (bg_in.hcount > 60 && bg_in.hcount < 165  && bg_in.vcount > 708 && bg_in.vcount < 713) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 60 && bg_in.hcount < 165  && bg_in.vcount > 668 && bg_in.vcount < 673)
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 60 && bg_in.hcount < 65  && bg_in.vcount > 668 && bg_in.vcount < 713)
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 160 && bg_in.hcount < 165  && bg_in.vcount > 668 && bg_in.vcount < 713)
             rgb_nxt = 12'h0_0_f;
             // -- right bottom corner
         else if (bg_in.hcount > 859 && bg_in.hcount < 964  && bg_in.vcount > 668 && bg_in.vcount < 673) 
             rgb_nxt = 12'h0_0_f;    
         else if (bg_in.hcount > 859 && bg_in.hcount < 964  && bg_in.vcount > 708 && bg_in.vcount < 713) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 859 && bg_in.hcount < 864  && bg_in.vcount > 668 && bg_in.vcount < 713) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 959 && bg_in.hcount < 964  && bg_in.vcount > 668 && bg_in.vcount < 713) 
             rgb_nxt = 12'h0_0_f;
             // -- middle top T
         else if (bg_in.hcount > 215 && bg_in.hcount < 809  && bg_in.vcount > 100 && bg_in.vcount < 105) 
             rgb_nxt = 12'h0_0_f;    
         else if (bg_in.hcount > 215 && bg_in.hcount < 220  && bg_in.vcount > 100 && bg_in.vcount < 161) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 804 && bg_in.hcount < 809  && bg_in.vcount > 100 && bg_in.vcount < 161) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 215 && bg_in.hcount < 482  && bg_in.vcount > 156 && bg_in.vcount < 161) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 537 && bg_in.hcount < 809  && bg_in.vcount > 156 && bg_in.vcount < 161) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 477 && bg_in.hcount < 482  && bg_in.vcount > 156 && bg_in.vcount < 298) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 537 && bg_in.hcount < 542  && bg_in.vcount > 156 && bg_in.vcount < 298) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 477 && bg_in.hcount < 542  && bg_in.vcount > 293 && bg_in.vcount < 298) 
             rgb_nxt = 12'h0_0_f; 
             // -- middle bottom T
         else if (bg_in.hcount > 215 && bg_in.hcount < 482  && bg_in.vcount > 613 && bg_in.vcount < 618) 
             rgb_nxt = 12'h0_0_f;    
         else if (bg_in.hcount > 215 && bg_in.hcount < 220  && bg_in.vcount > 613 && bg_in.vcount < 673) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 804 && bg_in.hcount < 809  && bg_in.vcount > 613 && bg_in.vcount < 673) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 215 && bg_in.hcount < 809  && bg_in.vcount > 668 && bg_in.vcount < 673) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 537 && bg_in.hcount < 809  && bg_in.vcount > 613 && bg_in.vcount < 618) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 477 && bg_in.hcount < 482  && bg_in.vcount > 476 && bg_in.vcount < 618) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 537 && bg_in.hcount < 542  && bg_in.vcount > 476 && bg_in.vcount < 618) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 477 && bg_in.hcount < 542  && bg_in.vcount > 476 && bg_in.vcount < 481) 
             rgb_nxt = 12'h0_0_f; 
             // --middle obstacle
         else if (bg_in.hcount > 110 && bg_in.hcount < 410  && bg_in.vcount > 300 && bg_in.vcount < 305) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 110 && bg_in.hcount < 115  && bg_in.vcount > 300 && bg_in.vcount < 500) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 405 && bg_in.hcount < 410  && bg_in.vcount > 300 && bg_in.vcount < 500) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 110 && bg_in.hcount < 410  && bg_in.vcount > 495 && bg_in.vcount < 500) 
             rgb_nxt = 12'h0_0_f;
             // --middle obstacle
         else if (bg_in.hcount > 609 && bg_in.hcount < 909  && bg_in.vcount > 300 && bg_in.vcount < 305) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 609 && bg_in.hcount < 614  && bg_in.vcount > 300 && bg_in.vcount < 500) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 904 && bg_in.hcount < 909  && bg_in.vcount > 300 && bg_in.vcount < 500) 
             rgb_nxt = 12'h0_0_f;
         else if (bg_in.hcount > 609 && bg_in.hcount < 909  && bg_in.vcount > 495 && bg_in.vcount < 500) 
             rgb_nxt = 12'h0_0_f;
             //kropka
         else if (bg_in.hcount == 512  && bg_in.vcount == 384)
            rgb_nxt =  12'h0_f_f;
             // postac xd
         else                                    // The rest of active display pixels:
            rgb_nxt = 12'h8_8_8;                // - fill with black.
     end
 end

 endmodule