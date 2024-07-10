/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Vga timing controller.
 */

 `timescale 1 ns / 1 ps

 module vga_timing (
     input  logic clk,
     input  logic rst,
     output logic [10:0] vcount,
     output logic vsync,
     output logic vblnk,
     output logic [10:0] hcount,
     output logic hsync,
     output logic hblnk
 );
 
 import vga_pkg::*;
 
 
 /**
  * Local variables and signals
  */
 
 // Add your signals and variables here.
  logic [10:0] hcount_nxt;
  logic [10:0] vcount_nxt;
  logic hblnk_nxt;
  logic vblnk_nxt;
  logic hsync_nxt;
  logic vsync_nxt;
 
 
 /**
  * Internal logic
  */
 always_ff@(posedge clk) begin
     if (rst) begin
         hcount <= 11'b0;
         vcount <= 11'b0;
         hblnk <= 1'b0;
         vblnk <= 1'b0;
         hsync <= 1'b0;
         vsync <= 1'b0;
     end
     else begin
         hcount <= hcount_nxt;
         vcount <= vcount_nxt;
         hblnk <= hblnk_nxt;
         vblnk <= vblnk_nxt;
         hsync <= hsync_nxt;
         vsync <= vsync_nxt;
     end
 end
 always_comb begin
     if (hcount == HBLANK_STOP - 1) begin
         if (vcount == VBLANK_STOP - 1) begin
             vcount_nxt=11'b0;
         end
         else begin
             vcount_nxt = vcount + 1;
         end
         hcount_nxt=11'b0;
     end
     else begin
         hcount_nxt = hcount + 1;
         vcount_nxt = vcount;
     end
 
     if (hcount_nxt >= HBLANK_START) begin
         hblnk_nxt = 1'b1;
     end
     else begin
         hblnk_nxt = 1'b0;
     end
 
     if((hcount_nxt >= HSYNC_START) && (hcount_nxt <= HSYNC_STOP)) begin
         hsync_nxt = 1'b1;
     end
     else begin
         hsync_nxt = 1'b0;
     end
     if (vcount_nxt > VBLANK_START) begin
         vblnk_nxt = 1'b1;
     end
     else begin
         vblnk_nxt = 1'b0;
     end
 
     if((vcount_nxt > VSYNC_START) && (vcount_nxt < VSYNC_STOP)) begin
         vsync_nxt = 1'b1;
     end
     else begin
         vsync_nxt = 1'b0;
     end
 end    
 
 
 endmodule