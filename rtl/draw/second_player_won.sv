`timescale 1 ns / 1 ps

 module second_player_won(
    input  logic clk,
    input  logic rst,
    vga_if.in sp_in,
    vga_if.out sp_out
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
        sp_out.vcount <= '0;
        sp_out.vsync  <= '0;
        sp_out.vblnk  <= '0;
        sp_out.hcount <= '0;
        sp_out.hsync  <= '0;
        sp_out.hblnk  <= '0;
        sp_out.rgb    <= '0;
    end else begin
        sp_out.vcount <= sp_in.vcount;
        sp_out.vsync  <= sp_in.vsync;
        sp_out.vblnk  <= sp_in.vblnk;
        sp_out.hcount <= sp_in.hcount;
        sp_out.hsync  <= sp_in.hsync;
        sp_out.hblnk  <= sp_in.hblnk;
        sp_out.rgb    <= rgb_nxt;
    end
end


 always_comb begin : bg_comb_blk
     if (sp_in.vblnk || sp_in.hblnk) begin             // Blanking region:
         rgb_nxt = 12'h0_0_0;                    // - make it it black.
     end else begin                              // Active region:
         if (sp_in.vcount == NULL)                     // - top edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (sp_in.vcount == NULL + 5 && sp_in.hcount > NULL +5 && sp_in.hcount < HOR_PIXELS - 5) // -- second blue top line.
             rgb_nxt = BLUE;
         else if (sp_in.vcount == VER_PIXELS - 1)   // - bottom edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (sp_in.vcount == VER_PIXELS - 5 && sp_in.hcount > NULL +5 && sp_in.hcount < HOR_PIXELS - 5) // -- second blue bottom line.
             rgb_nxt = BLUE;
         else if (sp_in.hcount == NULL)                // - left edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (sp_in.hcount == NULL + 5 && sp_in.vcount > NULL +5 && sp_in.vcount < VER_PIXELS - 5) // -- second blue left line.
             rgb_nxt = BLUE;
         else if (sp_in.hcount == HOR_PIXELS - 1)   // - right edge:
             rgb_nxt = BLUE;                // - - make a blue line.
         else if (sp_in.hcount == HOR_PIXELS - 5 && sp_in.vcount > NULL +5 && sp_in.vcount < VER_PIXELS - 5) // -- second blue right line.
             rgb_nxt = BLUE;
             //P
          else if (sp_in.vcount > 184 & sp_in.vcount < 364 & sp_in.hcount > 262 & sp_in.hcount < 277)
              rgb_nxt = YELLOW;
          else if (sp_in.vcount > 184 & sp_in.vcount < 199 & sp_in.hcount > 262 & sp_in.hcount < 307)
              rgb_nxt = YELLOW;
          else if (sp_in.vcount > 199 & sp_in.vcount < 256 & sp_in.hcount > 306 & sp_in.hcount < 322)
              rgb_nxt = YELLOW;
          else if (sp_in.vcount > 256 & sp_in.vcount < 271 & sp_in.hcount > 262 & sp_in.hcount < 307)
              rgb_nxt = YELLOW;
             //L
          else if (sp_in.vcount > 184 & sp_in.vcount < 364 & sp_in.hcount > 332 & sp_in.hcount < 347)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 334 & sp_in.vcount < 364 & sp_in.hcount > 332 & sp_in.hcount < 392)
              rgb_nxt = BLUE;
             //A
          else if (sp_in.vcount > 214 & sp_in.vcount < 364 & sp_in.hcount >  402 & sp_in.hcount < 417)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 214 & sp_in.vcount < 364 & sp_in.hcount >  447 & sp_in.hcount < 462)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 184 & sp_in.vcount < 214 & sp_in.hcount >  417 & sp_in.hcount < 447)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 274 & sp_in.vcount < 304 & sp_in.hcount >  417 & sp_in.hcount < 447)
              rgb_nxt = BLUE;
             //Y
          else if (sp_in.vcount > 259 & sp_in.vcount < 364 & sp_in.hcount >  496 & sp_in.hcount < 508)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 244 & sp_in.vcount < 259 & sp_in.hcount >  484 & sp_in.hcount <  496)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 244 & sp_in.vcount < 259 & sp_in.hcount >  508 & sp_in.hcount <  520)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 184 & sp_in.vcount < 244 & sp_in.hcount >  472 & sp_in.hcount <  484)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 184 & sp_in.vcount < 244 & sp_in.hcount >  520 & sp_in.hcount <  532)
              rgb_nxt = BLUE;
             //E
          else if (sp_in.vcount > 184 & sp_in.vcount < 364 & sp_in.hcount > 542 & sp_in.hcount < 557)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 184 & sp_in.vcount < 199 & sp_in.hcount > 542 & sp_in.hcount < 602)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 268 & sp_in.vcount < 283 & sp_in.hcount > 542 & sp_in.hcount < 592)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 349 & sp_in.vcount < 364 & sp_in.hcount > 542 & sp_in.hcount < 602)
              rgb_nxt = BLUE;
             //R
          else if (sp_in.vcount > 184 & sp_in.vcount < 364 & sp_in.hcount >  612 & sp_in.hcount < 627)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 184 & sp_in.vcount < 199 & sp_in.hcount >  627 & sp_in.hcount < 657)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 199 & sp_in.vcount < 274 & sp_in.hcount >  657 & sp_in.hcount < 672)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 274 & sp_in.vcount < 299 & sp_in.hcount >  627 & sp_in.hcount < 657)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 299 & sp_in.vcount < 314 & sp_in.hcount >  647 & sp_in.hcount < 662)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 314 & sp_in.vcount < 364 & sp_in.hcount >  657 & sp_in.hcount < 672)
              rgb_nxt = BLUE;
              //2
          else if (sp_in.vcount > 184 & sp_in.vcount <199 & sp_in.hcount > 702 & sp_in.hcount < 762)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 199 & sp_in.vcount <244 & sp_in.hcount > 747 & sp_in.hcount < 762)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 244 & sp_in.vcount <259 & sp_in.hcount > 702 & sp_in.hcount < 762)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 304 & sp_in.vcount <319 & sp_in.hcount > 702 & sp_in.hcount < 717)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 319 & sp_in.vcount <364 & sp_in.hcount > 702 & sp_in.hcount < 762)
              rgb_nxt = BLUE;
            //W
              else if (sp_in.vcount > 404 & sp_in.vcount < 584 & sp_in.hcount > 402 & sp_in.hcount < 414)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 539 & sp_in.vcount < 554 & sp_in.hcount > 414 & sp_in.hcount < 426)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 509 & sp_in.vcount < 539 & sp_in.hcount > 426 & sp_in.hcount < 438)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 539 & sp_in.vcount < 554 & sp_in.hcount > 438 & sp_in.hcount < 450)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 404 & sp_in.vcount < 584 & sp_in.hcount > 450 & sp_in.hcount < 462)
              rgb_nxt = BLUE;
               //O
          else if (sp_in.vcount > 419 & sp_in.vcount < 569 & sp_in.hcount > 472 & sp_in.hcount < 487)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 404 & sp_in.vcount < 419 & sp_in.hcount > 487 & sp_in.hcount < 517)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 419 & sp_in.vcount < 569 & sp_in.hcount > 517 & sp_in.hcount < 532)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 569 & sp_in.vcount < 584 & sp_in.hcount > 487 & sp_in.hcount < 517)
              rgb_nxt = BLUE;
              //N
          else if (sp_in.vcount > 404 & sp_in.vcount < 584 & sp_in.hcount > 542 & sp_in.hcount < 552)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 434 & sp_in.vcount < 449 & sp_in.hcount > 552 & sp_in.hcount < 562)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 449 & sp_in.vcount < 464 & sp_in.hcount > 562 & sp_in.hcount < 572)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 464 & sp_in.vcount < 479 & sp_in.hcount > 572 & sp_in.hcount < 582)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 479 & sp_in.vcount < 494 & sp_in.hcount > 582 & sp_in.hcount < 592)
              rgb_nxt = BLUE;
          else if (sp_in.vcount > 404 & sp_in.vcount < 584 & sp_in.hcount > 592 & sp_in.hcount < 602)
              rgb_nxt = BLUE;
          else                                    // The rest of active display pixels:
             rgb_nxt = BLACK;                // - fill with black.

     end

    end
 endmodule