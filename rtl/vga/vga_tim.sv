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