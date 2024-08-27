`timescale 1 ns / 1 ps

 module first_player_won (
    input  logic clk,
    input  logic rst,
    vga_if.in bg_in,
    vga_if.out bg_out
);
 import vga_pkg::*;


 /**
  * Local variables and signals
  */

 logic [11:0] rgb_nxt;


 /**
  * Internal logic
  */

  always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        bg_out.vcount <= '0;
        bg_out.vsync  <= '0;
        bg_out.vblnk  <= '0;
        bg_out.hcount <= '0;
        bg_out.hsync  <= '0;
        bg_out.hblnk  <= '0;
        bg_out.rgb    <= '0;
    end else begin
        bg_out.vcount <= bg_in.vcount;
        bg_out.vsync  <= bg_in.vsync;
        bg_out.vblnk  <= bg_in.vblnk;
        bg_out.hcount <= bg_in.hcount;
        bg_out.hsync  <= bg_in.hsync;
        bg_out.hblnk  <= bg_in.hblnk;
        bg_out.rgb    <= rgb_nxt;
    end
end


 always_comb begin : bg_comb_blk
     if (bg_in.vblnk || bg_in.hblnk) begin             // Blanking region:
         rgb_nxt = 12'h0_0_0;                    // - make it it black.
     end else begin                              // Active region:
         if (bg_in.vcount == NULL)                     // - top edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (bg_in.vcount == NULL + 5 && bg_in.hcount > NULL +5 && bg_in.hcount < HOR_PIXELS - 5) // -- second blue top line.
             rgb_nxt = BLUE;
         else if (bg_in.vcount == VER_PIXELS - 1)   // - bottom edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (bg_in.vcount == VER_PIXELS - 5 && bg_in.hcount > NULL +5 && bg_in.hcount < HOR_PIXELS - 5) // -- second blue bottom line.
             rgb_nxt = BLUE;
         else if (bg_in.hcount == NULL)                // - left edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (bg_in.hcount == NULL + 5 && bg_in.vcount > NULL +5 && bg_in.vcount < VER_PIXELS - 5) // -- second blue left line.
             rgb_nxt = BLUE;
         else if (bg_in.hcount == HOR_PIXELS - 1)   // - right edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (bg_in.hcount == HOR_PIXELS - 5 && bg_in.vcount > NULL +5 && bg_in.vcount < VER_PIXELS - 5) // -- second blue right line.
             rgb_nxt = BLUE;
             //P
          else if (bg_in.vcount > 184 & bg_in.vcount < 364 & bg_in.hcount > 262 & bg_in.hcount < 277)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 184 & bg_in.vcount < 199 & bg_in.hcount > 262 & bg_in.hcount < 307)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 199 & bg_in.vcount < 256 & bg_in.hcount > 306 & bg_in.hcount < 322)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 256 & bg_in.vcount < 271 & bg_in.hcount > 262 & bg_in.hcount < 307)
              rgb_nxt = YELLOW;
             //L
          else if (bg_in.vcount > 184 & bg_in.vcount < 364 & bg_in.hcount > 332 & bg_in.hcount < 347)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 334 & bg_in.vcount < 364 & bg_in.hcount > 332 & bg_in.hcount < 392)
              rgb_nxt = BLUE;
             //A
          else if (bg_in.vcount > 214 & bg_in.vcount < 364 & bg_in.hcount >  402 & bg_in.hcount < 417)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 214 & bg_in.vcount < 364 & bg_in.hcount >  447 & bg_in.hcount < 462)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 184 & bg_in.vcount < 214 & bg_in.hcount >  417 & bg_in.hcount < 447)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 274 & bg_in.vcount < 304 & bg_in.hcount >  417 & bg_in.hcount < 447)
              rgb_nxt = BLUE;
             //Y
          else if (bg_in.vcount > 259 & bg_in.vcount < 364 & bg_in.hcount >  496 & bg_in.hcount < 508)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 244 & bg_in.vcount < 259 & bg_in.hcount >  484 & bg_in.hcount <  496)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 244 & bg_in.vcount < 259 & bg_in.hcount >  508 & bg_in.hcount <  520)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 184 & bg_in.vcount < 244 & bg_in.hcount >  472 & bg_in.hcount <  484)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 184 & bg_in.vcount < 244 & bg_in.hcount >  520 & bg_in.hcount <  532)
              rgb_nxt = BLUE;
             //E
          else if (bg_in.vcount > 184 & bg_in.vcount < 364 & bg_in.hcount > 542 & bg_in.hcount < 557)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 184 & bg_in.vcount < 199 & bg_in.hcount > 542 & bg_in.hcount < 602)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 268 & bg_in.vcount < 283 & bg_in.hcount > 542 & bg_in.hcount < 592)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 349 & bg_in.vcount < 364 & bg_in.hcount > 542 & bg_in.hcount < 602)
              rgb_nxt = BLUE;
             //R
          else if (bg_in.vcount > 184 & bg_in.vcount < 364 & bg_in.hcount >  612 & bg_in.hcount < 627)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 184 & bg_in.vcount < 199 & bg_in.hcount >  627 & bg_in.hcount < 657)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 199 & bg_in.vcount < 274 & bg_in.hcount >  657 & bg_in.hcount < 672)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 274 & bg_in.vcount < 299 & bg_in.hcount >  627 & bg_in.hcount < 657)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 299 & bg_in.vcount < 314 & bg_in.hcount >  647 & bg_in.hcount < 662)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 314 & bg_in.vcount < 364 & bg_in.hcount >  657 & bg_in.hcount < 672)
              rgb_nxt = BLUE;
              //1
          else if (bg_in.vcount > 184 & bg_in.vcount < 364 & bg_in.hcount >  732 & bg_in.hcount < 747)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 199 & bg_in.vcount < 214 & bg_in.hcount >  717 & bg_in.hcount < 732)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 214 & bg_in.vcount < 229 & bg_in.hcount >  702 & bg_in.hcount < 717)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 349 & bg_in.vcount < 364 & bg_in.hcount >  702 & bg_in.hcount < 762)
              rgb_nxt = BLUE;
            //W
          else if (bg_in.vcount > 404 & bg_in.vcount < 584 & bg_in.hcount > 402 & bg_in.hcount < 414)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 539 & bg_in.vcount < 554 & bg_in.hcount > 414 & bg_in.hcount < 426)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 509 & bg_in.vcount < 539 & bg_in.hcount > 426 & bg_in.hcount < 438)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 539 & bg_in.vcount < 554 & bg_in.hcount > 438 & bg_in.hcount < 450)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 404 & bg_in.vcount < 584 & bg_in.hcount > 450 & bg_in.hcount < 462)
              rgb_nxt = BLUE;
               //O
          else if (bg_in.vcount > 419 & bg_in.vcount < 569 & bg_in.hcount > 472 & bg_in.hcount < 487)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 404 & bg_in.vcount < 419 & bg_in.hcount > 487 & bg_in.hcount < 517)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 419 & bg_in.vcount < 569 & bg_in.hcount > 517 & bg_in.hcount < 532)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 569 & bg_in.vcount < 584 & bg_in.hcount > 487 & bg_in.hcount < 517)
              rgb_nxt = BLUE;
              //N
          else if (bg_in.vcount > 404 & bg_in.vcount < 584 & bg_in.hcount > 542 & bg_in.hcount < 552)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 434 & bg_in.vcount < 449 & bg_in.hcount > 552 & bg_in.hcount < 562)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 449 & bg_in.vcount < 464 & bg_in.hcount > 562 & bg_in.hcount < 572)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 464 & bg_in.vcount < 479 & bg_in.hcount > 572 & bg_in.hcount < 582)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 479 & bg_in.vcount < 494 & bg_in.hcount > 582 & bg_in.hcount < 592)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 404 & bg_in.vcount < 584 & bg_in.hcount > 592 & bg_in.hcount < 602)
              rgb_nxt = BLUE;
          else                                    // The rest of active display pixels:
             rgb_nxt = BLACK;                // - fill with black.

     end

    end
 endmodule