/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic rst,
<<<<<<< HEAD
=======
    input  logic move_up, move_down, move_right, move_left,
>>>>>>> bf5e9b6510cdd95151311c199ac7331dabc0d0bf
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);

/**
 * VGA interface wiring
 */

<<<<<<< HEAD
vga_if wire_tim();
vga_if wire_bg();
vga_if wire_rect();
=======
// VGA signals from timing
 vga_tim vga_timing();

 // VGA signals from background
 vga_if vga_bg();

  // VGA signals from drawing rectangle
 vga_if vga_rect();
 
 wire rectangle;
 wire [11:0] xpos;
 wire [11:0] ypos;
 wire [11:0] xpos_nxt;
 wire [11:0] ypos_nxt;
>>>>>>> bf5e9b6510cdd95151311c199ac7331dabc0d0bf

/**
 * Signals assignments
 */

<<<<<<< HEAD
 assign vs = wire_bg.vsync;
 assign hs = wire_bg.hsync;
 assign {r,g,b} = wire_bg.rgb;

=======
 assign vs = vga_rect.vsync;
 assign hs = vga_rect.hsync;
 assign {r,g,b} = vga_rect.rgb;
 
>>>>>>> bf5e9b6510cdd95151311c199ac7331dabc0d0bf

/**
 * Submodules instances
 */

vga_timing u_vga_timing (
    .clk,
    .rst,
    .tim_out(wire_tim)
);

draw_bg u_draw_bg (
    .clk,
    .rst,
<<<<<<< HEAD
    .bg_in(wire_tim),
    .bg_out(wire_bg)
);

/*
draw_rect u_draw_rect (
    .clk,
    .rst,
    .rect_in(wire_bg),
    .rect_out(wire_rect)
);
*/
endmodule
=======
    .vga_outbg(vga_bg),
    .vga_inbg(vga_timing)
);

draw_rect u_draw_rect (
    .clk,
    .rst,
    .rect_in(vga_bg),
    .rect_out(vga_rect),
    .move_up, 
    .move_down, 
    .move_right, 
    .move_left
);

/*
main_menu u_main_menu (
    .clk,
    .rst,
    .vga_inbg (vga_timing),
    .vga_outbg (vga_bg)
);
*/

endmodule
>>>>>>> bf5e9b6510cdd95151311c199ac7331dabc0d0bf
