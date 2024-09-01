/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Package with vga related constants.
 */

package vga_pkg;

// Parameters for VGA Display 1024 x 768 @ 60fps using a 65 MHz clock;

localparam NULL = 0;
localparam HOR_PIXELS = 1024;
localparam VER_PIXELS = 768;
localparam HBLANK_START = 1024;
localparam HBLANK_STOP = 1344;
localparam HSYNC_START = 1048;
localparam HSYNC_STOP = 1184;
localparam VBLANK_START = 768;
localparam VBLANK_STOP = 806;
localparam VSYNC_START = 771;
localparam VSYNC_STOP = 777;

// Add VGA timing parameters here and refer to them in other modules.

localparam WIDTH = 48;
localparam LENGHT = 63;
localparam BLUE = 12'h0_0_f;
localparam YELLOW = 12'hf_f_0;
localparam BLACK = 12'h0_0_0;
localparam RECT_COLOR = 12'hf_f_f;
localparam POINT_COLOR = 12'h0_f_f;

localparam RECT_X = 60;
localparam RECT_Y = 60;
localparam RECT_HEIGHT = 30;
localparam RECT_WIDTH = 30;
localparam SCREEN_WIDTH = 1024;
localparam SCREEN_HEIGHT = 768;
localparam PLAYER_SIZE = 16;
localparam POINT_SIZE = 8;

localparam TERRAIN_NUM = 11;
localparam TERRAIN_LTX1 = 64;
localparam TERRAIN_LTX2 = 192;
localparam TERRAIN_LTY1 = 64;
localparam TERRAIN_LTY2 = 128;
localparam TERRAIN_RTX1 = 832;
localparam TERRAIN_RTX2 = 960;
localparam TERRAIN_RTY1 = 64;
localparam TERRAIN_RTY2 = 128;
localparam TERRAIN_LBX1 = 64;
localparam TERRAIN_LBX2 = 192;
localparam TERRAIN_LBY1 = 640;
localparam TERRAIN_LBY2 = 704;
localparam TERRAIN_RBX1 = 832;
localparam TERRAIN_RBX2 = 960;
localparam TERRAIN_RBY1 = 640;
localparam TERRAIN_RBY2 = 704;
localparam TERRAIN_MTTX1 = 256;
localparam TERRAIN_MTTX2 = 768;
localparam TEN           = 10;
localparam TERRAIN_MTTY1 = 128;
localparam TERRAIN_MTTY2 = 192;
localparam TERRAIN_MTSX1 = 480;
localparam TERRAIN_MTSX2 = 544;
localparam TERRAIN_MTSY1 = 192;
localparam TERRAIN_MTSY2 = 256;
localparam TERRAIN_MBTX1 = 256;
localparam TERRAIN_MBTX2 = 768;
localparam TERRAIN_MBTY1 = 576;
localparam TERRAIN_MBTY2 = 640;
localparam TERRAIN_MBSX1 = 480;
localparam TERRAIN_MBSX2 = 544;
localparam TERRAIN_MBSY1 = 512;
localparam TERRAIN_MBSY2 = 576;
localparam TERRAIN_MMX1 = 416;
localparam TERRAIN_MMX2 = 608;
localparam TERRAIN_MMY1 = 320;
localparam TERRAIN_MMY2 = 448;
localparam TERRAIN_MLX1 = 96;
localparam TERRAIN_MLX2 = 352;
localparam TERRAIN_MLY1 = 256;
localparam TERRAIN_MLY2 = 512;
localparam TERRAIN_MRX1 = 672;
localparam TERRAIN_MRX2 = 928;
localparam TERRAIN_MRY1 = 256;
localparam TERRAIN_MRY2 = 512;

typedef enum logic [1:0] {
    START = 2'b00,
    GAME = 2'b01, 
    PLAYER_1 = 2'b11, 
    PLAYER_2 = 2'b10
} state;

endpackage
