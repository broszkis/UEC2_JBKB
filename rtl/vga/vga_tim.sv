/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Ksawery Broszkiewicz, Jan Bartnik
 *
 * Description:
 * 
 */
`timescale 1 ns / 1 ps

interface vga_tim;
     logic [10:0] vcount;
     logic        vsync;
     logic        vblnk;
     logic [10:0] hcount;
     logic        hsync;
     logic        hblnk;

     modport in (input vcount, vsync, vblnk, hcount, hsync, hblnk);

     modport out (output vcount, vsync, vblnk, hcount, hsync, hblnk);



endinterface