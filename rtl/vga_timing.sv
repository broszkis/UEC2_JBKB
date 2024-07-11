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
        hcount <= '0;
        vcount <= '0;
        hblnk <= 0;
        hsync <= 0;
        vblnk <= 0;
        vsync <= 0;
    end
    else begin
        hcount <= hcount_nxt;
        vcount <= vcount_nxt;
        hblnk <= hblnk_nxt;
        hsync <= hsync_nxt;
        vblnk <= vblnk_nxt;
        vsync <= vsync_nxt;     
    end
end

always_comb begin
    if (hcount == 1343) begin
            hcount_nxt = '0;
            if (vcount == 805)
                vcount_nxt = '0;
            else
                vcount_nxt = vcount + 1;
    end
    else begin
        hcount_nxt = hcount + 1;
        vcount_nxt = vcount;
    end

    hblnk_nxt = (hcount_nxt >= HBLANK_START && hcount_nxt <= HBLANK_STOP - 1);
    hsync_nxt = (hcount_nxt >= HSYNC_START && hcount_nxt <= HSYNC_STOP - 1);
    vblnk_nxt = (vcount_nxt >= VBLANK_START && vcount_nxt <= VBLANK_STOP - 1);
    vsync_nxt = (vcount_nxt >= VSYNC_START && vcount_nxt <= VSYNC_STOP - 1);
end

endmodule
 