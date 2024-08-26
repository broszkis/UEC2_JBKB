`timescale 1 ns / 1 ps

 module second_player_won(
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


 /**
  * Internal logic
  */

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
     if (vga_inbg.vblnk || vga_inbg.hblnk) begin             // Blanking region:
         rgb_nxt = 12'h0_0_0;                    // - make it it black.
     end else begin                              // Active region:
         if (vga_inbg.vcount == NULL)                     // - top edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.vcount == NULL + 5 && vga_inbg.hcount > NULL +5 && vga_inbg.hcount < HOR_PIXELS - 5) // -- second blue top line.
             rgb_nxt = BLUE;
         else if (vga_inbg.vcount == VER_PIXELS - 1)   // - bottom edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.vcount == VER_PIXELS - 5 && vga_inbg.hcount > NULL +5 && vga_inbg.hcount < HOR_PIXELS - 5) // -- second blue bottom line.
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount == NULL)                // - left edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.hcount == NULL + 5 && vga_inbg.vcount > NULL +5 && vga_inbg.vcount < VER_PIXELS - 5) // -- second blue left line.
             rgb_nxt = BLUE;
         else if (vga_inbg.hcount == HOR_PIXELS - 1)   // - right edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (vga_inbg.hcount == HOR_PIXELS - 5 && vga_inbg.vcount > NULL +5 && vga_inbg.vcount < VER_PIXELS - 5) // -- second blue right line.
             rgb_nxt = BLUE;
             //P
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 364 & vga_inbg.hcount > 262 & vga_inbg.hcount < 277)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 199 & vga_inbg.hcount > 262 & vga_inbg.hcount < 307)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 199 & vga_inbg.vcount < 256 & vga_inbg.hcount > 306 & vga_inbg.hcount < 322)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 256 & vga_inbg.vcount < 271 & vga_inbg.hcount > 262 & vga_inbg.hcount < 307)
              rgb_nxt = YELLOW;
             //L
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 364 & vga_inbg.hcount > 332 & vga_inbg.hcount < 347)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 334 & vga_inbg.vcount < 364 & vga_inbg.hcount > 332 & vga_inbg.hcount < 392)
              rgb_nxt = BLUE;
             //A
          else if (vga_inbg.vcount > 214 & vga_inbg.vcount < 364 & vga_inbg.hcount >  402 & vga_inbg.hcount < 417)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 214 & vga_inbg.vcount < 364 & vga_inbg.hcount >  447 & vga_inbg.hcount < 462)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 214 & vga_inbg.hcount >  417 & vga_inbg.hcount < 447)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 274 & vga_inbg.vcount < 304 & vga_inbg.hcount >  417 & vga_inbg.hcount < 447)
              rgb_nxt = BLUE;
             //Y
          else if (vga_inbg.vcount > 259 & vga_inbg.vcount < 364 & vga_inbg.hcount >  496 & vga_inbg.hcount < 508)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 244 & vga_inbg.vcount < 259 & vga_inbg.hcount >  484 & vga_inbg.hcount <  496)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 244 & vga_inbg.vcount < 259 & vga_inbg.hcount >  508 & vga_inbg.hcount <  520)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 244 & vga_inbg.hcount >  472 & vga_inbg.hcount <  484)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 244 & vga_inbg.hcount >  520 & vga_inbg.hcount <  532)
              rgb_nxt = BLUE;
             //E
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 364 & vga_inbg.hcount > 542 & vga_inbg.hcount < 557)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 199 & vga_inbg.hcount > 542 & vga_inbg.hcount < 602)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 268 & vga_inbg.vcount < 283 & vga_inbg.hcount > 542 & vga_inbg.hcount < 592)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 349 & vga_inbg.vcount < 364 & vga_inbg.hcount > 542 & vga_inbg.hcount < 602)
              rgb_nxt = BLUE;
             //R
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 364 & vga_inbg.hcount >  612 & vga_inbg.hcount < 627)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount < 199 & vga_inbg.hcount >  627 & vga_inbg.hcount < 657)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 199 & vga_inbg.vcount < 274 & vga_inbg.hcount >  657 & vga_inbg.hcount < 672)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 274 & vga_inbg.vcount < 299 & vga_inbg.hcount >  627 & vga_inbg.hcount < 657)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 299 & vga_inbg.vcount < 314 & vga_inbg.hcount >  647 & vga_inbg.hcount < 662)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 314 & vga_inbg.vcount < 364 & vga_inbg.hcount >  657 & vga_inbg.hcount < 672)
              rgb_nxt = BLUE;
              //2
          else if (vga_inbg.vcount > 184 & vga_inbg.vcount <199 & vga_inbg.hcount > 702 & vga_inbg.hcount < 762)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 199 & vga_inbg.vcount <244 & vga_inbg.hcount > 747 & vga_inbg.hcount < 762)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 244 & vga_inbg.vcount <259 & vga_inbg.hcount > 702 & vga_inbg.hcount < 762)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 304 & vga_inbg.vcount <319 & vga_inbg.hcount > 702 & vga_inbg.hcount < 717)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 319 & vga_inbg.vcount <364 & vga_inbg.hcount > 702 & vga_inbg.hcount < 762)
              rgb_nxt = BLUE;
            //W
              else if (vga_inbg.vcount > 404 & vga_inbg.vcount < 584 & vga_inbg.hcount > 402 & vga_inbg.hcount < 414)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 539 & vga_inbg.vcount < 554 & vga_inbg.hcount > 414 & vga_inbg.hcount < 426)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 509 & vga_inbg.vcount < 539 & vga_inbg.hcount > 426 & vga_inbg.hcount < 438)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 539 & vga_inbg.vcount < 554 & vga_inbg.hcount > 438 & vga_inbg.hcount < 450)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 404 & vga_inbg.vcount < 584 & vga_inbg.hcount > 450 & vga_inbg.hcount < 462)
              rgb_nxt = BLUE;
               //O
          else if (vga_inbg.vcount > 419 & vga_inbg.vcount < 569 & vga_inbg.hcount > 472 & vga_inbg.hcount < 487)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 404 & vga_inbg.vcount < 419 & vga_inbg.hcount > 487 & vga_inbg.hcount < 517)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 419 & vga_inbg.vcount < 569 & vga_inbg.hcount > 517 & vga_inbg.hcount < 532)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 569 & vga_inbg.vcount < 584 & vga_inbg.hcount > 487 & vga_inbg.hcount < 517)
              rgb_nxt = BLUE;
              //N
          else if (vga_inbg.vcount > 404 & vga_inbg.vcount < 584 & vga_inbg.hcount > 542 & vga_inbg.hcount < 552)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 434 & vga_inbg.vcount < 449 & vga_inbg.hcount > 552 & vga_inbg.hcount < 562)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 449 & vga_inbg.vcount < 464 & vga_inbg.hcount > 562 & vga_inbg.hcount < 572)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 464 & vga_inbg.vcount < 479 & vga_inbg.hcount > 572 & vga_inbg.hcount < 582)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 479 & vga_inbg.vcount < 494 & vga_inbg.hcount > 582 & vga_inbg.hcount < 592)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 404 & vga_inbg.vcount < 584 & vga_inbg.hcount > 592 & vga_inbg.hcount < 602)
              rgb_nxt = BLUE;
          else                                    // The rest of active display pixels:
             rgb_nxt = BLACK;                // - fill with black.

     end

    end
 endmodule