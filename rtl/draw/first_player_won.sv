`timescale 1 ns / 1 ps

 module first_player_won (
    input  logic clk,
    input  logic rst,
    vga_if.in fp_in,
    vga_if.out fp_out
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
        fp_out.vcount <= '0;
        fp_out.vsync  <= '0;
        fp_out.vblnk  <= '0;
        fp_out.hcount <= '0;
        fp_out.hsync  <= '0;
        fp_out.hblnk  <= '0;
        fp_out.rgb    <= '0;
    end else begin
        fp_out.vcount <= fp_in.vcount;
        fp_out.vsync  <= fp_in.vsync;
        fp_out.vblnk  <= fp_in.vblnk;
        fp_out.hcount <= fp_in.hcount;
        fp_out.hsync  <= fp_in.hsync;
        fp_out.hblnk  <= fp_in.hblnk;
        fp_out.rgb    <= rgb_nxt;
    end
end


 always_comb begin : bg_comb_blk
     if (fp_in.vblnk || fp_in.hblnk) begin             // Blanking region:
         rgb_nxt = 12'h0_0_0;                    // - make it it black.
     end else begin                              // Active region:
         if (fp_in.vcount == NULL)                     // - top edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (fp_in.vcount == NULL + 5 && fp_in.hcount > NULL +5 && fp_in.hcount < HOR_PIXELS - 5) // -- second blue top line.
             rgb_nxt = BLUE;
         else if (fp_in.vcount == VER_PIXELS - 1)   // - bottom edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (fp_in.vcount == VER_PIXELS - 5 && fp_in.hcount > NULL +5 && fp_in.hcount < HOR_PIXELS - 5) // -- second blue bottom line.
             rgb_nxt = BLUE;
         else if (fp_in.hcount == NULL)                // - left edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (fp_in.hcount == NULL + 5 && fp_in.vcount > NULL +5 && fp_in.vcount < VER_PIXELS - 5) // -- second blue left line.
             rgb_nxt = BLUE;
         else if (fp_in.hcount == HOR_PIXELS - 1)   // - right edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (fp_in.hcount == HOR_PIXELS - 5 && fp_in.vcount > NULL +5 && fp_in.vcount < VER_PIXELS - 5) // -- second blue right line.
             rgb_nxt = BLUE;
             //P
          else if (fp_in.vcount > 184 & fp_in.vcount < 364 & fp_in.hcount > 262 & fp_in.hcount < 277)
              rgb_nxt = YELLOW;
          else if (fp_in.vcount > 184 & fp_in.vcount < 199 & fp_in.hcount > 262 & fp_in.hcount < 307)
              rgb_nxt = YELLOW;
          else if (fp_in.vcount > 199 & fp_in.vcount < 256 & fp_in.hcount > 306 & fp_in.hcount < 322)
              rgb_nxt = YELLOW;
          else if (fp_in.vcount > 256 & fp_in.vcount < 271 & fp_in.hcount > 262 & fp_in.hcount < 307)
              rgb_nxt = YELLOW;
             //L
          else if (fp_in.vcount > 184 & fp_in.vcount < 364 & fp_in.hcount > 332 & fp_in.hcount < 347)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 334 & fp_in.vcount < 364 & fp_in.hcount > 332 & fp_in.hcount < 392)
              rgb_nxt = BLUE;
             //A
          else if (fp_in.vcount > 214 & fp_in.vcount < 364 & fp_in.hcount >  402 & fp_in.hcount < 417)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 214 & fp_in.vcount < 364 & fp_in.hcount >  447 & fp_in.hcount < 462)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 184 & fp_in.vcount < 214 & fp_in.hcount >  417 & fp_in.hcount < 447)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 274 & fp_in.vcount < 304 & fp_in.hcount >  417 & fp_in.hcount < 447)
              rgb_nxt = BLUE;
             //Y
          else if (fp_in.vcount > 259 & fp_in.vcount < 364 & fp_in.hcount >  496 & fp_in.hcount < 508)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 244 & fp_in.vcount < 259 & fp_in.hcount >  484 & fp_in.hcount <  496)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 244 & fp_in.vcount < 259 & fp_in.hcount >  508 & fp_in.hcount <  520)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 184 & fp_in.vcount < 244 & fp_in.hcount >  472 & fp_in.hcount <  484)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 184 & fp_in.vcount < 244 & fp_in.hcount >  520 & fp_in.hcount <  532)
              rgb_nxt = BLUE;
             //E
          else if (fp_in.vcount > 184 & fp_in.vcount < 364 & fp_in.hcount > 542 & fp_in.hcount < 557)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 184 & fp_in.vcount < 199 & fp_in.hcount > 542 & fp_in.hcount < 602)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 268 & fp_in.vcount < 283 & fp_in.hcount > 542 & fp_in.hcount < 592)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 349 & fp_in.vcount < 364 & fp_in.hcount > 542 & fp_in.hcount < 602)
              rgb_nxt = BLUE;
             //R
          else if (fp_in.vcount > 184 & fp_in.vcount < 364 & fp_in.hcount >  612 & fp_in.hcount < 627)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 184 & fp_in.vcount < 199 & fp_in.hcount >  627 & fp_in.hcount < 657)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 199 & fp_in.vcount < 274 & fp_in.hcount >  657 & fp_in.hcount < 672)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 274 & fp_in.vcount < 299 & fp_in.hcount >  627 & fp_in.hcount < 657)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 299 & fp_in.vcount < 314 & fp_in.hcount >  647 & fp_in.hcount < 662)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 314 & fp_in.vcount < 364 & fp_in.hcount >  657 & fp_in.hcount < 672)
              rgb_nxt = BLUE;
              //1
          else if (fp_in.vcount > 184 & fp_in.vcount < 364 & fp_in.hcount >  732 & fp_in.hcount < 747)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 199 & fp_in.vcount < 214 & fp_in.hcount >  717 & fp_in.hcount < 732)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 214 & fp_in.vcount < 229 & fp_in.hcount >  702 & fp_in.hcount < 717)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 349 & fp_in.vcount < 364 & fp_in.hcount >  702 & fp_in.hcount < 762)
              rgb_nxt = BLUE;
            //W
          else if (fp_in.vcount > 404 & fp_in.vcount < 584 & fp_in.hcount > 402 & fp_in.hcount < 414)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 539 & fp_in.vcount < 554 & fp_in.hcount > 414 & fp_in.hcount < 426)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 509 & fp_in.vcount < 539 & fp_in.hcount > 426 & fp_in.hcount < 438)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 539 & fp_in.vcount < 554 & fp_in.hcount > 438 & fp_in.hcount < 450)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 404 & fp_in.vcount < 584 & fp_in.hcount > 450 & fp_in.hcount < 462)
              rgb_nxt = BLUE;
               //O
          else if (fp_in.vcount > 419 & fp_in.vcount < 569 & fp_in.hcount > 472 & fp_in.hcount < 487)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 404 & fp_in.vcount < 419 & fp_in.hcount > 487 & fp_in.hcount < 517)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 419 & fp_in.vcount < 569 & fp_in.hcount > 517 & fp_in.hcount < 532)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 569 & fp_in.vcount < 584 & fp_in.hcount > 487 & fp_in.hcount < 517)
              rgb_nxt = BLUE;
              //N
          else if (fp_in.vcount > 404 & fp_in.vcount < 584 & fp_in.hcount > 542 & fp_in.hcount < 552)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 434 & fp_in.vcount < 449 & fp_in.hcount > 552 & fp_in.hcount < 562)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 449 & fp_in.vcount < 464 & fp_in.hcount > 562 & fp_in.hcount < 572)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 464 & fp_in.vcount < 479 & fp_in.hcount > 572 & fp_in.hcount < 582)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 479 & fp_in.vcount < 494 & fp_in.hcount > 582 & fp_in.hcount < 592)
              rgb_nxt = BLUE;
          else if (fp_in.vcount > 404 & fp_in.vcount < 584 & fp_in.hcount > 592 & fp_in.hcount < 602)
              rgb_nxt = BLUE;
          else                                    // The rest of active display pixels:
             rgb_nxt = BLACK;                // - fill with black.

     end

    end
 endmodule