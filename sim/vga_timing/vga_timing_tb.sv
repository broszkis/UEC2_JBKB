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
 
 localparam CLK_PERIOD = 15.385;     // 65 MHz
 
 
 /**
  * Local variables and signals
  */
 
 logic clk;
 logic rst;

 vga_if wire_tim();
 
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
     .tim_out(wire_tim)
 );
 
 /**
  * Tasks and functions
  */
 task afterreset();
     begin
         assert (wire_tim.hcount == 0 && wire_tim.vcount == 0);
     end
 endtask
  // Here you can declare tasks with immediate assertions (assert).
 
 
 /**
  * Assertions
  */
 assert property (@(posedge clk) (rst == 1 |-> ##1(wire_tim.hcount >= 0 && wire_tim.hcount <= HBLANK_STOP)));
 assert property (@(posedge clk) (rst == 1 |-> ##1(wire_tim.vcount >= 0 && wire_tim.vcount <= VBLANK_STOP)));
 assert property (@(posedge clk) (rst == 1 |-> ##1((wire_tim.hblnk == 1 && wire_tim.hcount >= HBLANK_START && wire_tim.hcount <= HBLANK_STOP) || (wire_tim.hblnk == 0 && wire_tim.hcount >= 0 && wire_tim.hcount <= HBLANK_START))));
 assert property (@(posedge clk) (rst == 1 |-> ##1((wire_tim.hsync == 1 && wire_tim.hcount >= HSYNC_START && wire_tim.hsync <= HSYNC_STOP) || (wire_tim.hsync == 0 && (wire_tim.hcount >= 0 && wire_tim.hcount <= HSYNC_START) || (wire_tim.hcount >= HSYNC_STOP && wire_tim.hcount <= HBLANK_STOP)))));
 assert property (@(posedge clk) (rst == 1 |-> ##1((wire_tim.vblnk == 1 && wire_tim.hcount >= VBLANK_START && wire_tim.vcount <= VBLANK_STOP) || (wire_tim.vblnk == 0 && wire_tim.vcount >= 0 && wire_tim.vcount <= VBLANK_START))));
 assert property (@(posedge clk) (rst == 1 |-> ##1((wire_tim.vsync == 1 && wire_tim.vcount >= VSYNC_START && wire_tim.vsync <= VSYNC_STOP) || (wire_tim.vsync == 0 && (wire_tim.vcount >= 0 && wire_tim.vcount <= VSYNC_START) || (wire_tim.vcount >= VSYNC_STOP && wire_tim.vcount <= VBLANK_STOP)))));
 // Here you can declare concurrent assertions (assert property).
 
 
 /**
  * Main test
  */
 
 initial begin
     @(posedge rst);
     @(negedge rst);
 
     wait (wire_tim.vsync == 1'b0);
     @(negedge wire_tim.vsync)
     @(negedge wire_tim.vsync)
 
     $finish;
 end
 
 endmodule