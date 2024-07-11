/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Testbench for vga_timing module.
 */

 `timescale 1 ns / 1 ps

 module vga_timing_tb;
 
 import vga_pkg::*;
 
 
 /**
  *  Local parameters
  */
 
 localparam CLK_PERIOD = 15.385s;     // 65 MHz
 
 
 /**
  * Local variables and signals
  */
 
 logic clk;
 logic rst;
 
 wire [10:0] vcount, hcount;
 wire        vsync,  hsync;
 wire        vblnk,  hblnk;
 
 
 /**
  * Clock generation
  */
 
 initial begin
     clk = 1'b0;
     forever #(CLK_PERIOD/2) clk = ~clk;
 end
 
 
 /**
  * Reset generation
  */
 
 initial begin
                        rst = 1'b0;
     #(1.25*CLK_PERIOD) rst = 1'b1;
                        rst = 1'b1;
     #(2.00*CLK_PERIOD) rst = 1'b0;
     afterreset();
 end
 
 
 /**
  * Dut placement
  */
 
 vga_timing dut(
     .clk,
     .rst,
     .vcount,
     .vsync,
     .vblnk,
     .hcount,
     .hsync,
     .hblnk
 );
 
 /**
  * Tasks and functions
  */
 task afterreset();
     begin
         assert (hcount == 0 && vcount == 0);
     end
 endtask
  // Here you can declare tasks with immediate assertions (assert).
 
 
 /**
  * Assertions
  */
 assert property (@(posedge clk) (rst == 1 |-> ##1(hcount >= 0 && hcount <= HBLANK_STOP)));
 assert property (@(posedge clk) (rst == 1 |-> ##1(vcount >= 0 && vcount <= VBLANK_STOP)));
 assert property (@(posedge clk) (rst == 1 |-> ##1((hblnk == 1 && hcount >= HBLANK_START && hcount <= HBLANK_STOP) || (hblnk == 0 && hcount >= 0 && hcount <= HBLANK_START))));
 assert property (@(posedge clk) (rst == 1 |-> ##1((hsync == 1 && hcount >= HSYNC_START && hsync <= HSYNC_STOP) || (hsync == 0 && (hcount >= 0 && hcount <= HSYNC_START) || (hcount >= HSYNC_STOP && hcount <= HBLANK_STOP)))));
 assert property (@(posedge clk) (rst == 1 |-> ##1((vblnk == 1 && hcount >= VBLANK_START && vcount <= VBLANK_STOP) || (vblnk == 0 && vcount >= 0 && vcount <= VBLANK_START))));
 assert property (@(posedge clk) (rst == 1 |-> ##1((vsync == 1 && vcount >= VSYNC_START && vsync <= VSYNC_STOP) || (vsync == 0 && (vcount >= 0 && vcount <= VSYNC_START) || (vcount >= VSYNC_STOP && vcount <= VBLANK_STOP)))));
 // Here you can declare concurrent assertions (assert property).
 
 
 /**
  * Main test
  */
 
 initial begin
     @(posedge rst);
     @(negedge rst);
 
     wait (vsync == 1'b0);
     @(negedge vsync)
     @(negedge vsync)
 
     $finish;
 end
 
 endmodule