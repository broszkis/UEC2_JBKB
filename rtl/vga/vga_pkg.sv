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
localparam BLUE = 12'h0_0_f;
localparam YELLOW = 12'hf_f_0;
localparam BLACK = 12'h0_0_0;
localparam RECT_COLOR = 12'hf_f_f;
localparam RECT_X = 60;
localparam RECT_Y = 60;
localparam RECT_HEIGHT = 30;
localparam RECT_WIDTH = 30;
localparam PLAYER_SIZE = 15;

// Add VGA timing parameters here and refer to them in other modules.

endpackage
