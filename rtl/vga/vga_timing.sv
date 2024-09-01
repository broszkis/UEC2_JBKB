/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Ksawery Broszkiewicz, Jan Bartnik
 *
 * Description:
 * 
 */

 `timescale 1 ns / 1 ps

 module vga_timing (
    vga_tim.out tim_out,
    input logic clk,
    input logic rst
 );
 
 import vga_pkg::*;
 
 /**
  * Local variables and signals
  */

  logic [10:0] hcount_nxt;
  logic [10:0] vcount_nxt;
  logic hblnk_nxt;
  logic vblnk_nxt;
  logic hsync_nxt;
  logic vsync_nxt;

 /**
  * Internal logic
  */

 always_ff @(posedge clk) begin
    if (rst) begin 
        tim_out.hcount <= '0;
        tim_out.vcount <= '0;
        tim_out.hblnk <= 0;
        tim_out.hsync <= 0;
        tim_out.vblnk <= 0;
        tim_out.vsync <= 0;
    end
    else begin
        tim_out.hcount <= hcount_nxt;
        tim_out.vcount <= vcount_nxt;
        tim_out.hblnk <= hblnk_nxt;
        tim_out.hsync <= hsync_nxt;
        tim_out.vblnk <= vblnk_nxt;
        tim_out.vsync <= vsync_nxt;     
    end
end

always_comb begin
    if (tim_out.hcount == HBLANK_STOP - 1) begin
            hcount_nxt = '0;
            if (tim_out.vcount == VBLANK_STOP - 1)
                vcount_nxt = '0;
            else
                vcount_nxt = tim_out.vcount + 1;
    end
    else begin
        hcount_nxt = tim_out.hcount + 1;
        vcount_nxt = tim_out.vcount;
    end

    hblnk_nxt = (hcount_nxt >= HBLANK_START && hcount_nxt <= HBLANK_STOP - 1);
    hsync_nxt = (hcount_nxt >= HSYNC_START && hcount_nxt <= HSYNC_STOP - 1);
    vblnk_nxt = (vcount_nxt >= VBLANK_START  && vcount_nxt <= VBLANK_STOP - 1);
    vsync_nxt = (vcount_nxt >= VSYNC_START && vcount_nxt <= VSYNC_STOP - 1);
end

endmodule
 