/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background with random squares as collectible points.
 */

 `timescale 1 ns / 1 ps

 module testowy (
     input  logic clk,
     input  logic rst,
     vga_if.in vga_inbg,
     vga_if.out vga_outbg
 );
 import vga_pkg::*;
 
 /**
   * Local variables and signals
   */
 
 logic [11:0] rgb_nxt;
 logic [31:0] square_x, square_y;  // Pozycje kwadratów
 logic new_square;                 // Flaga do generowania nowego kwadratu
 logic [31:0] rand_counter;        // Licznik dla losowej pozycji
 
 /**
   * Internal logic
   */
 
 // Generator prostego losowego numeru (tu tylko inkrementacja dla prostoty)
 always_ff @(posedge clk or posedge rst) begin
     if (rst) begin
         rand_counter <= 0;
         square_x <= 0;
         square_y <= 0;
         new_square <= 1;  // Start od generowania pierwszego kwadratu
     end else begin
         rand_counter <= rand_counter + 1;
 
         if (new_square) begin
             // Generowanie losowej pozycji (z użyciem rand_counter)
             square_x <= (rand_counter % (HOR_PIXELS - 10));  // Pozycja x kwadratu
             square_y <= (rand_counter % (VER_PIXELS - 10));  // Pozycja y kwadratu
             new_square <= 0;  // Wyłącz flage nowego kwadratu po wygenerowaniu pozycji
         end
     end
 end
 
 always_ff @(posedge clk) begin : bg_ff_blk
     if (rst) begin
         vga_outbg.vcount <= '0;
         vga_outbg.vsync  <= '0;
         vga_outbg.vblnk  <= '0;
         vga_outbg.hcount <= '0;
         vga_outbg.hsync  <= '0;
         vga_outbg.hblnk  <= '0;
         vga_outbg.rgb    <= '0;
     end else begin
         vga_outbg.vcount <= vga_inbg.vcount;
         vga_outbg.vsync  <= vga_inbg.vsync;
         vga_outbg.vblnk  <= vga_inbg.vblnk;
         vga_outbg.hcount <= vga_inbg.hcount;
         vga_outbg.hsync  <= vga_inbg.hsync;
         vga_outbg.hblnk  <= vga_inbg.hblnk;
         vga_outbg.rgb    <= rgb_nxt;
     end
 end
 
 always_comb begin : bg_comb_blk
     if (vga_inbg.vblnk || vga_inbg.hblnk) begin  // Blanking region:
         rgb_nxt = 12'h0_0_0;                     // - make it black.
     end else begin                               // Active region:
         if (vga_inbg.hcount >= square_x && vga_inbg.hcount < square_x + 10 &&
             vga_inbg.vcount >= square_y && vga_inbg.vcount < square_y + 10) begin
             rgb_nxt = 12'hf_f_0;                 // - Draw the square (yellow color).
         end else begin
             rgb_nxt = 12'h0_0_0;                 // - Background color (black).
         end
     end
 end
 
 // Logika do wygenerowania nowego kwadratu po pewnym czasie lub po zdobyciu punktu
 // Możesz użyć tego fragmentu np. w połączeniu z licznikiem klatek lub detekcją kolizji
 logic [31:0] frame_counter;
logic [31:0] frame_threshold = 1000;  // Liczba klatek do wygenerowania nowego kwadratu

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        frame_counter <= 0;
        new_square <= 1;
    end else begin
        if (frame_counter >= frame_threshold) begin
            new_square <= 1;  // Generuj nowy kwadrat
            frame_counter <= 0;  // Resetuj licznik
        end else begin
            frame_counter <= frame_counter + 1;
            new_square <= 0;  // Kontynuuj odliczanie
        end
    end
end
 
 endmodule
 