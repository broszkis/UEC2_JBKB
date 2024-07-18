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
     input  logic rectangle,
 
     input  logic [10:0] vcount_in,
     input  logic        vsync_in,
     input  logic        vblnk_in,
     input  logic [10:0] hcount_in,
     input  logic        hsync_in,
     input  logic        hblnk_in,
 
     output logic [10:0] vcount_out,
     output logic        vsync_out,
     output logic        vblnk_out,
     output logic [10:0] hcount_out,
     output logic        hsync_out,
     output logic        hblnk_out,
 
     output logic [11:0] rgb_out
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
         vcount_out <= '0;
         vsync_out  <= '0;
         vblnk_out  <= '0;
         hcount_out <= '0;
         hsync_out  <= '0;
         hblnk_out  <= '0;
         rgb_out    <= '0;
     end else begin
         vcount_out <= vcount_in;
         vsync_out  <= vsync_in;
         vblnk_out  <= vblnk_in;
         hcount_out <= hcount_in;
         hsync_out  <= hsync_in;
         hblnk_out  <= hblnk_in;
         rgb_out    <= rgb_nxt;
     end
 end
 
 always_comb begin : bg_comb_blk
     if (vblnk_in || hblnk_in) begin             // Blanking region:
         rgb_nxt = 12'h0_0_0;                    // - make it it black.
     end else begin                              // Active region:
         if (vcount_in == NULL)                     // - top edge:
             rgb_nxt = 12'h0_0_f;                // - - make a blue line.
         else if (vcount_in == NULL + 5 && hcount_in > NULL +5 && hcount_in < HOR_PIXELS - 5) // -- second blue top line.   
             rgb_nxt = 12'h0_0_f; 
         else if (vcount_in == VER_PIXELS - 1)   // - bottom edge:
             rgb_nxt = 12'h0_0_f;                // - - make a blue line.
         else if (vcount_in == VER_PIXELS - 5 && hcount_in > NULL +5 && hcount_in < HOR_PIXELS - 5) // -- second blue bottom line.   
             rgb_nxt = 12'h0_0_f; 
         else if (hcount_in == NULL)                // - left edge:
             rgb_nxt = 12'h0_0_f;                // - - make a blue line.
         else if (hcount_in == NULL + 5 && vcount_in > NULL +5 && vcount_in < VER_PIXELS - 5) // -- second blue left line.   
             rgb_nxt = 12'h0_0_f;                
         else if (hcount_in == HOR_PIXELS - 1)   // - right edge:
             rgb_nxt = 12'h0_0_f;                // - - make a blue line.
         else if (hcount_in == HOR_PIXELS - 5 && vcount_in > NULL +5 && vcount_in < VER_PIXELS - 5) // -- second blue right line.   
             rgb_nxt = 12'h0_0_f;
         else if (hcount_in > NULL + 128 && hcount_in < NULL + 133  && vcount_in > NULL + 66 && vcount_in < NULL + 126) // --first wall 
             rgb_nxt = 12'h0_0_f;
         else if (hcount_in > NULL + 460 && hcount_in < NULL + 465  && vcount_in > NULL + 348 && vcount_in < NULL + 420) // --middle obstacle left
             rgb_nxt = 12'h0_0_f;
         else if (hcount_in > NULL + 560 && hcount_in < NULL + 565  && vcount_in > NULL + 348 && vcount_in < NULL + 420) // --middle obstacle right
             rgb_nxt = 12'h0_0_f;
         else if (hcount_in > NULL + 460 && hcount_in < NULL + 565  && vcount_in > NULL + 348 && vcount_in < NULL + 353) // --middle obstacle
             rgb_nxt = 12'h0_0_f;
         else if (hcount_in > NULL + 460 && hcount_in < NULL + 565  && vcount_in > NULL + 415 && vcount_in < NULL + 420) // --middle obstacle
             rgb_nxt = 12'h0_0_f;
         else if (hcount_in == 512  && vcount_in == 384)
            rgb_nxt =  12'h0_f_f;
         else if (hcount_in > 900 && hcount_in < 930  && vcount_in > 400 && vcount_in < 430 && rectangle == 1)
            rgb_nxt =  12'h0_f_f;
         else                                    // The rest of active display pixels:
             rgb_nxt = 12'h0_0_0;                // - fill with black.
     end
 end
 
 endmodule