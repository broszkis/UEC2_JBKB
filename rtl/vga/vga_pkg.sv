/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 * Modified by: Jan Bartnik
 * Description:
 * Package with vga related constants adjusted to 1024X768 resolution.
 */

package vga_pkg;

// Parameters for VGA Display 1024 x 768 @ 60fps using a 65 MHz clock;
localparam  NULL = 0;
localparam  HOR_PIXELS = 1024;
localparam  VER_PIXELS = 768;
localparam  HBLANK_START = 1024;
localparam  HBLANK_STOP = 1344;
localparam  HSYNC_START = 1048;
localparam  HSYNC_STOP = 1184;
localparam  VBLANK_START = 768;
localparam  VBLANK_STOP = 806;
localparam  VSYNC_START = 771;
localparam  VSYNC_STOP = 777;
localparam WIDTH = 48;
localparam LENGHT = 63;

// Add VGA timing parameters here and refer to them in other modules.

endpackage
