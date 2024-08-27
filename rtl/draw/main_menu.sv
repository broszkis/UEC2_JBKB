/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


 `timescale 1 ns / 1 ps

 module main_menu(
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
         rgb_nxt = BLACK;                    // - make it it black.
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
          //2
          else if (bg_in.vcount > 170 & bg_in.vcount <180 & bg_in.hcount > 320 & bg_in.hcount < 340)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 175  & bg_in.vcount <185 & bg_in.hcount >  315 & bg_in.hcount < 325)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 175 & bg_in.vcount <190 & bg_in.hcount >  335 & bg_in.hcount < 345)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 185 & bg_in.vcount <195 & bg_in.hcount >  330 & bg_in.hcount < 340)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 190 & bg_in.vcount <200 & bg_in.hcount >  325 & bg_in.hcount < 335)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 195 & bg_in.vcount <205 & bg_in.hcount >  320 & bg_in.hcount < 330)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 200 & bg_in.vcount <215 & bg_in.hcount >  315 & bg_in.hcount < 325)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 205 & bg_in.vcount <215 & bg_in.hcount > 315  & bg_in.hcount < 345)
              rgb_nxt = BLUE;
          //P
          else if (bg_in.vcount > 170 & bg_in.vcount <215 & bg_in.hcount >  365 & bg_in.hcount < 375)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 170 & bg_in.vcount <180 & bg_in.hcount >  365 & bg_in.hcount <  385)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 175 & bg_in.vcount <185 & bg_in.hcount >   380 & bg_in.hcount <  390)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 180 & bg_in.vcount <195 & bg_in.hcount >   385 & bg_in.hcount <  390)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 190 & bg_in.vcount <200 & bg_in.hcount >   380 & bg_in.hcount <  390)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 195 & bg_in.vcount <200 & bg_in.hcount >  365 & bg_in.hcount <  385)
              rgb_nxt = BLUE;
          //L
          else if (bg_in.vcount > 170 & bg_in.vcount < 215 & bg_in.hcount >  400 & bg_in.hcount < 410)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 205 & bg_in.vcount < 215 & bg_in.hcount >  400 & bg_in.hcount <  425 )
              rgb_nxt = BLUE;
          //A
          else if (bg_in.vcount > 175 & bg_in.vcount < 215 & bg_in.hcount >  430 & bg_in.hcount < 440)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 175 & bg_in.vcount < 215 & bg_in.hcount >  445 & bg_in.hcount <  455)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 170 & bg_in.vcount < 180 & bg_in.hcount >  435 & bg_in.hcount < 450)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 190 & bg_in.vcount < 200 & bg_in.hcount >  430 & bg_in.hcount <  455 )
              rgb_nxt = BLUE;
          //Y
          else if (bg_in.vcount > 185 & bg_in.vcount < 215 & bg_in.hcount >  470 & bg_in.hcount < 480)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 180 & bg_in.vcount < 190 & bg_in.hcount >  465 & bg_in.hcount <  475 )
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 180 & bg_in.vcount < 190 & bg_in.hcount >  475 & bg_in.hcount < 485)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 170 & bg_in.vcount < 185 & bg_in.hcount >  460 & bg_in.hcount <  470 )
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 170 & bg_in.vcount < 185 & bg_in.hcount >  480 & bg_in.hcount <  490)
              rgb_nxt = BLUE;
          //E
          else if (bg_in.vcount > 170 & bg_in.vcount <215 & bg_in.hcount >  495 & bg_in.hcount < 505)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 170 & bg_in.vcount <180 & bg_in.hcount >  495 & bg_in.hcount < 520)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 205 & bg_in.vcount <215 & bg_in.hcount >  495 & bg_in.hcount < 520)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 188 & bg_in.vcount <198 & bg_in.hcount >  495 & bg_in.hcount < 515)
              rgb_nxt = BLUE;
          //R
          else if (bg_in.vcount > 170 & bg_in.vcount <215 & bg_in.hcount >  525 & bg_in.hcount < 535)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 170 & bg_in.vcount <180 & bg_in.hcount >  525 & bg_in.hcount < 540)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 175 & bg_in.vcount <185 & bg_in.hcount >  539 & bg_in.hcount < 549)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 180 & bg_in.vcount <195 & bg_in.hcount >  545 & bg_in.hcount < 554)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 190 & bg_in.vcount <202 & bg_in.hcount >  539 & bg_in.hcount < 549)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 195 & bg_in.vcount <205 & bg_in.hcount >  525 & bg_in.hcount < 540)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 200 & bg_in.vcount <210 & bg_in.hcount >  539 & bg_in.hcount < 549)
              rgb_nxt = BLUE;
          else if (bg_in.vcount > 205 & bg_in.vcount <215 & bg_in.hcount >  545 & bg_in.hcount < 554)
              rgb_nxt = BLUE;
          //GAME
          //G
          else if (bg_in.vcount >  170 & bg_in.vcount < 215 & bg_in.hcount > 574 & bg_in.hcount <584)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  170 & bg_in.vcount < 180 & bg_in.hcount > 574 & bg_in.hcount <604)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  205 & bg_in.vcount < 215 & bg_in.hcount > 574 & bg_in.hcount <599)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  190 & bg_in.vcount < 200 & bg_in.hcount > 589 & bg_in.hcount <604)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  190 & bg_in.vcount < 215 & bg_in.hcount > 596 & bg_in.hcount <604)
              rgb_nxt = BLUE;
          //A
          else if (bg_in.vcount >  175 & bg_in.vcount <  215 & bg_in.hcount > 609 & bg_in.hcount < 619)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  175 & bg_in.vcount <  215 & bg_in.hcount > 624 & bg_in.hcount < 634)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  170 & bg_in.vcount <  180 & bg_in.hcount > 614 & bg_in.hcount < 629)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  190 & bg_in.vcount <  200 & bg_in.hcount > 609 & bg_in.hcount < 634)
              rgb_nxt = BLUE;
          //M
          else if (bg_in.vcount >  170 & bg_in.vcount <  215 & bg_in.hcount > 639 & bg_in.hcount < 649)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  170 & bg_in.vcount <  215 & bg_in.hcount > 669 & bg_in.hcount < 679)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  180 & bg_in.vcount <  190 & bg_in.hcount > 648 & bg_in.hcount < 658)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  180 & bg_in.vcount <  190 & bg_in.hcount > 660 & bg_in.hcount < 670)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  189 & bg_in.vcount <  199 & bg_in.hcount > 654 & bg_in.hcount < 664)
              rgb_nxt = BLUE;
          //E
          else if (bg_in.vcount >  170 & bg_in.vcount < 215 & bg_in.hcount > 684 & bg_in.hcount < 694)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  170 & bg_in.vcount < 180 & bg_in.hcount > 684 & bg_in.hcount < 709)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  205 & bg_in.vcount < 215 & bg_in.hcount > 684 & bg_in.hcount < 709)
              rgb_nxt = BLUE;
          else if (bg_in.vcount >  188 & bg_in.vcount < 198 & bg_in.hcount > 684 & bg_in.hcount < 704)
              rgb_nxt = BLUE;
              //BASYSFIELD
          else if (bg_in.vcount > 50 & bg_in.vcount < 150 & bg_in.hcount > 255 & bg_in.hcount < 265)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 50 & bg_in.vcount < 60 & bg_in.hcount > 255 & bg_in.hcount < 295)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 140 & bg_in.vcount < 150 & bg_in.hcount > 255 & bg_in.hcount < 295)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 95 & bg_in.vcount < 105 & bg_in.hcount > 255 & bg_in.hcount < 295)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 59 & bg_in.vcount < 96 & bg_in.hcount > 294 & bg_in.hcount < 305)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 104 & bg_in.vcount < 141 & bg_in.hcount > 294 & bg_in.hcount < 305)
              rgb_nxt = YELLOW;
              //A
          else if (bg_in.vcount >  110 & bg_in.vcount <  150 & bg_in.hcount > 310 & bg_in.hcount < 320)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  110 & bg_in.vcount <  150 & bg_in.hcount > 350 & bg_in.hcount < 360)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  100 & bg_in.vcount <  111 & bg_in.hcount > 315 & bg_in.hcount < 355)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  120 & bg_in.vcount <  130 & bg_in.hcount > 310 & bg_in.hcount < 360)
              rgb_nxt = YELLOW;
              //S
          else if (bg_in.vcount >  100 & bg_in.vcount <  110 & bg_in.hcount > 375 & bg_in.hcount < 415)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  109 & bg_in.vcount <  122 & bg_in.hcount > 365 & bg_in.hcount < 375)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  120 & bg_in.vcount <  129 & bg_in.hcount > 375 & bg_in.hcount < 405)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  127 & bg_in.vcount <  140 & bg_in.hcount > 405 & bg_in.hcount < 415)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  139 & bg_in.vcount <  150 & bg_in.hcount > 365 & bg_in.hcount < 405)
              rgb_nxt = YELLOW;
              //Y
          else if (bg_in.vcount > 120 & bg_in.vcount < 150 & bg_in.hcount >  430 & bg_in.hcount < 445)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 115 & bg_in.vcount < 125 & bg_in.hcount >  425 & bg_in.hcount < 435)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 115 & bg_in.vcount < 125 & bg_in.hcount >  440 & bg_in.hcount < 450)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 100 & bg_in.vcount < 120 & bg_in.hcount >  420 & bg_in.hcount < 430)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 100 & bg_in.vcount < 120 & bg_in.hcount >  445 & bg_in.hcount < 455)
              rgb_nxt = YELLOW;
                 //S
          else if (bg_in.vcount >  100 & bg_in.vcount <  110 & bg_in.hcount > 470 & bg_in.hcount < 510)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  109 & bg_in.vcount <  122 & bg_in.hcount > 460 & bg_in.hcount < 470)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  120 & bg_in.vcount <  129 & bg_in.hcount > 470 & bg_in.hcount < 500)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  127 & bg_in.vcount <  140 & bg_in.hcount > 500 & bg_in.hcount < 510)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  139 & bg_in.vcount <  150 & bg_in.hcount > 460 & bg_in.hcount < 500)
              rgb_nxt = YELLOW;
                 //F
          else if (bg_in.vcount >  100 & bg_in.vcount <  150 & bg_in.hcount > 515 & bg_in.hcount < 525)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  100 & bg_in.vcount <  110 & bg_in.hcount > 515 & bg_in.hcount < 550)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  120 & bg_in.vcount <  130 & bg_in.hcount > 515 & bg_in.hcount < 545)
              rgb_nxt = YELLOW;
                  //I
          else if (bg_in.vcount >  100 & bg_in.vcount <  110 & bg_in.hcount > 555 & bg_in.hcount < 585)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  100 & bg_in.vcount <  150 & bg_in.hcount > 565 & bg_in.hcount < 575)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  140 & bg_in.vcount <  150 & bg_in.hcount > 555 & bg_in.hcount < 585)
              rgb_nxt = YELLOW;
           //E
          else if (bg_in.vcount >  100 & bg_in.vcount < 150 & bg_in.hcount > 590 & bg_in.hcount < 600)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  100 & bg_in.vcount < 110 & bg_in.hcount > 590 & bg_in.hcount < 625)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  140 & bg_in.vcount < 150 & bg_in.hcount > 590 & bg_in.hcount < 625)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  120 & bg_in.vcount < 130 & bg_in.hcount > 590 & bg_in.hcount < 620)
              rgb_nxt = YELLOW;
              //L
          else if (bg_in.vcount >  100 & bg_in.vcount < 150 & bg_in.hcount > 630 & bg_in.hcount < 640)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  140 & bg_in.vcount < 150 & bg_in.hcount > 630 & bg_in.hcount < 660)
              rgb_nxt = YELLOW;
              //D
          else if (bg_in.vcount >  100 & bg_in.vcount < 150 & bg_in.hcount > 665 & bg_in.hcount < 675)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  100 & bg_in.vcount < 110 & bg_in.hcount > 665 & bg_in.hcount < 690)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  140 & bg_in.vcount < 150 & bg_in.hcount > 665 & bg_in.hcount < 690)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  109 & bg_in.vcount < 141 & bg_in.hcount > 689 & bg_in.hcount < 700)
              rgb_nxt = YELLOW;
              //PLAY
              //P
          else if (bg_in.vcount > 334 & bg_in.vcount < 434 & bg_in.hcount > 437 & bg_in.hcount < 447)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 334 & bg_in.vcount < 344 & bg_in.hcount > 437 & bg_in.hcount < 467)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 343 & bg_in.vcount < 385 & bg_in.hcount > 466 & bg_in.hcount < 477)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 384 & bg_in.vcount < 394 & bg_in.hcount > 437 & bg_in.hcount < 467)
              rgb_nxt = YELLOW;
              //L
          else if (bg_in.vcount > 334 & bg_in.vcount < 434 & bg_in.hcount > 482 & bg_in.hcount < 492)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 424 & bg_in.vcount < 434 & bg_in.hcount > 482 & bg_in.hcount < 517)
              rgb_nxt = YELLOW;
              //A
          else if (bg_in.vcount >  343 & bg_in.vcount <  434 & bg_in.hcount > 522 & bg_in.hcount < 532)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  343 & bg_in.vcount <  434 & bg_in.hcount > 552 & bg_in.hcount < 562)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  334 & bg_in.vcount <  345 & bg_in.hcount > 531 & bg_in.hcount < 553)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount >  373 & bg_in.vcount <  383 & bg_in.hcount > 522 & bg_in.hcount < 562)
              rgb_nxt = YELLOW;
              //Y
          else if (bg_in.vcount > 374 & bg_in.vcount < 434 & bg_in.hcount > 580 & bg_in.hcount < 590)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 364 & bg_in.vcount < 384 & bg_in.hcount >  572 & bg_in.hcount < 582)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 364 & bg_in.vcount < 384 & bg_in.hcount >  587 & bg_in.hcount < 597)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 334 & bg_in.vcount < 374 & bg_in.hcount >  567 & bg_in.hcount < 577)
              rgb_nxt = YELLOW;
          else if (bg_in.vcount > 334 & bg_in.vcount < 374 & bg_in.hcount >  592 & bg_in.hcount < 602)
              rgb_nxt = YELLOW;
         else                                    // The rest of active display pixels:
              rgb_nxt = BLACK;                // - fill with black.
     end
 end
 
 
 endmodule