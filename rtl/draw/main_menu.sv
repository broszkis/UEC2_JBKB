/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Ksawery Broszkiewicz, Jan Bartnik
 *
 * Description:
 * 
 */
 `timescale 1 ns / 1 ps

 module main_menu(
     input  logic clk,
     input  logic rst,
     vga_tim.in mm_in,
     vga_if.out mm_out
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
         mm_out.vcount <= '0;
         mm_out.vsync  <= '0;
         mm_out.vblnk  <= '0;
         mm_out.hcount <= '0;
         mm_out.hsync  <= '0;
         mm_out.hblnk  <= '0;
         mm_out.rgb    <= '0;
     end else begin
         mm_out.vcount <= mm_in.vcount;
         mm_out.vsync  <= mm_in.vsync;
         mm_out.vblnk  <= mm_in.vblnk;
         mm_out.hcount <= mm_in.hcount;
         mm_out.hsync  <= mm_in.hsync;
         mm_out.hblnk  <= mm_in.hblnk;
         mm_out.rgb    <= rgb_nxt;
     end
 end
 
 always_comb begin : bg_comb_blk
     if (mm_in.vblnk || mm_in.hblnk) begin             // Blanking region:
         rgb_nxt = BLACK;                    // - make it it black.
     end else begin                              // Active region:
         if (mm_in.vcount == NULL)                     // - top edge:
              rgb_nxt = BLUE;                // - - make a blue line.
          else if (mm_in.vcount == NULL + 5 && mm_in.hcount > NULL +5 && mm_in.hcount < HOR_PIXELS - 5) // -- second blue top line.
              rgb_nxt = BLUE;
          else if (mm_in.vcount == VER_PIXELS - 1)   // - bottom edge:
              rgb_nxt = BLUE;                // - - make a blue line.
          else if (mm_in.vcount == VER_PIXELS - 5 && mm_in.hcount > NULL +5 && mm_in.hcount < HOR_PIXELS - 5) // -- second blue bottom line.
              rgb_nxt = BLUE;
          else if (mm_in.hcount == NULL)                // - left edge:
              rgb_nxt = BLUE;                // - - make a blue line.
          else if (mm_in.hcount == NULL + 5 && mm_in.vcount > NULL +5 && mm_in.vcount < VER_PIXELS - 5) // -- second blue left line.
              rgb_nxt = BLUE;
          else if (mm_in.hcount == HOR_PIXELS - 1)   // - right edge:
              rgb_nxt = BLUE;                // - - make a blue line.
          else if (mm_in.hcount == HOR_PIXELS - 5 && mm_in.vcount > NULL +5 && mm_in.vcount < VER_PIXELS - 5) // -- second blue right line.
              rgb_nxt = BLUE;
          //2
          else if (mm_in.vcount > 170 & mm_in.vcount <180 & mm_in.hcount > 320 & mm_in.hcount < 340)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 175  & mm_in.vcount <185 & mm_in.hcount >  315 & mm_in.hcount < 325)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 175 & mm_in.vcount <190 & mm_in.hcount >  335 & mm_in.hcount < 345)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 185 & mm_in.vcount <195 & mm_in.hcount >  330 & mm_in.hcount < 340)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 190 & mm_in.vcount <200 & mm_in.hcount >  325 & mm_in.hcount < 335)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 195 & mm_in.vcount <205 & mm_in.hcount >  320 & mm_in.hcount < 330)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 200 & mm_in.vcount <215 & mm_in.hcount >  315 & mm_in.hcount < 325)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 205 & mm_in.vcount <215 & mm_in.hcount > 315  & mm_in.hcount < 345)
              rgb_nxt = BLUE;
          //P
          else if (mm_in.vcount > 170 & mm_in.vcount <215 & mm_in.hcount >  365 & mm_in.hcount < 375)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 170 & mm_in.vcount <180 & mm_in.hcount >  365 & mm_in.hcount <  385)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 175 & mm_in.vcount <185 & mm_in.hcount >   380 & mm_in.hcount <  390)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 180 & mm_in.vcount <195 & mm_in.hcount >   385 & mm_in.hcount <  390)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 190 & mm_in.vcount <200 & mm_in.hcount >   380 & mm_in.hcount <  390)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 195 & mm_in.vcount <200 & mm_in.hcount >  365 & mm_in.hcount <  385)
              rgb_nxt = BLUE;
          //L
          else if (mm_in.vcount > 170 & mm_in.vcount < 215 & mm_in.hcount >  400 & mm_in.hcount < 410)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 205 & mm_in.vcount < 215 & mm_in.hcount >  400 & mm_in.hcount <  425 )
              rgb_nxt = BLUE;
          //A
          else if (mm_in.vcount > 175 & mm_in.vcount < 215 & mm_in.hcount >  430 & mm_in.hcount < 440)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 175 & mm_in.vcount < 215 & mm_in.hcount >  445 & mm_in.hcount <  455)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 170 & mm_in.vcount < 180 & mm_in.hcount >  435 & mm_in.hcount < 450)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 190 & mm_in.vcount < 200 & mm_in.hcount >  430 & mm_in.hcount <  455 )
              rgb_nxt = BLUE;
          //Y
          else if (mm_in.vcount > 185 & mm_in.vcount < 215 & mm_in.hcount >  470 & mm_in.hcount < 480)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 180 & mm_in.vcount < 190 & mm_in.hcount >  465 & mm_in.hcount <  475 )
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 180 & mm_in.vcount < 190 & mm_in.hcount >  475 & mm_in.hcount < 485)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 170 & mm_in.vcount < 185 & mm_in.hcount >  460 & mm_in.hcount <  470 )
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 170 & mm_in.vcount < 185 & mm_in.hcount >  480 & mm_in.hcount <  490)
              rgb_nxt = BLUE;
          //E
          else if (mm_in.vcount > 170 & mm_in.vcount <215 & mm_in.hcount >  495 & mm_in.hcount < 505)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 170 & mm_in.vcount <180 & mm_in.hcount >  495 & mm_in.hcount < 520)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 205 & mm_in.vcount <215 & mm_in.hcount >  495 & mm_in.hcount < 520)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 188 & mm_in.vcount <198 & mm_in.hcount >  495 & mm_in.hcount < 515)
              rgb_nxt = BLUE;
          //R
          else if (mm_in.vcount > 170 & mm_in.vcount <215 & mm_in.hcount >  525 & mm_in.hcount < 535)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 170 & mm_in.vcount <180 & mm_in.hcount >  525 & mm_in.hcount < 540)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 175 & mm_in.vcount <185 & mm_in.hcount >  539 & mm_in.hcount < 549)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 180 & mm_in.vcount <195 & mm_in.hcount >  545 & mm_in.hcount < 554)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 190 & mm_in.vcount <202 & mm_in.hcount >  539 & mm_in.hcount < 549)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 195 & mm_in.vcount <205 & mm_in.hcount >  525 & mm_in.hcount < 540)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 200 & mm_in.vcount <210 & mm_in.hcount >  539 & mm_in.hcount < 549)
              rgb_nxt = BLUE;
          else if (mm_in.vcount > 205 & mm_in.vcount <215 & mm_in.hcount >  545 & mm_in.hcount < 554)
              rgb_nxt = BLUE;
          //GAME
          //G
          else if (mm_in.vcount >  170 & mm_in.vcount < 215 & mm_in.hcount > 574 & mm_in.hcount <584)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  170 & mm_in.vcount < 180 & mm_in.hcount > 574 & mm_in.hcount <604)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  205 & mm_in.vcount < 215 & mm_in.hcount > 574 & mm_in.hcount <599)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  190 & mm_in.vcount < 200 & mm_in.hcount > 589 & mm_in.hcount <604)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  190 & mm_in.vcount < 215 & mm_in.hcount > 596 & mm_in.hcount <604)
              rgb_nxt = BLUE;
          //A
          else if (mm_in.vcount >  175 & mm_in.vcount <  215 & mm_in.hcount > 609 & mm_in.hcount < 619)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  175 & mm_in.vcount <  215 & mm_in.hcount > 624 & mm_in.hcount < 634)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  170 & mm_in.vcount <  180 & mm_in.hcount > 614 & mm_in.hcount < 629)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  190 & mm_in.vcount <  200 & mm_in.hcount > 609 & mm_in.hcount < 634)
              rgb_nxt = BLUE;
          //M
          else if (mm_in.vcount >  170 & mm_in.vcount <  215 & mm_in.hcount > 639 & mm_in.hcount < 649)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  170 & mm_in.vcount <  215 & mm_in.hcount > 669 & mm_in.hcount < 679)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  180 & mm_in.vcount <  190 & mm_in.hcount > 648 & mm_in.hcount < 658)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  180 & mm_in.vcount <  190 & mm_in.hcount > 660 & mm_in.hcount < 670)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  189 & mm_in.vcount <  199 & mm_in.hcount > 654 & mm_in.hcount < 664)
              rgb_nxt = BLUE;
          //E
          else if (mm_in.vcount >  170 & mm_in.vcount < 215 & mm_in.hcount > 684 & mm_in.hcount < 694)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  170 & mm_in.vcount < 180 & mm_in.hcount > 684 & mm_in.hcount < 709)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  205 & mm_in.vcount < 215 & mm_in.hcount > 684 & mm_in.hcount < 709)
              rgb_nxt = BLUE;
          else if (mm_in.vcount >  188 & mm_in.vcount < 198 & mm_in.hcount > 684 & mm_in.hcount < 704)
              rgb_nxt = BLUE;
              //BASYSFIELD
              //B
          else if (mm_in.vcount > 50 & mm_in.vcount < 150 & mm_in.hcount > 290 & mm_in.hcount < 300)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 50 & mm_in.vcount < 60 & mm_in.hcount > 290 & mm_in.hcount < 330)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 140 & mm_in.vcount < 150 & mm_in.hcount > 290 & mm_in.hcount < 330)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 95 & mm_in.vcount < 105 & mm_in.hcount > 290 & mm_in.hcount < 330)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 59 & mm_in.vcount < 96 & mm_in.hcount > 329 & mm_in.hcount < 340)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 104 & mm_in.vcount < 141 & mm_in.hcount > 329 & mm_in.hcount < 340)
              rgb_nxt = YELLOW;
              //A
          else if (mm_in.vcount >  110 & mm_in.vcount <  150 & mm_in.hcount > 345 & mm_in.hcount < 355)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  110 & mm_in.vcount <  150 & mm_in.hcount > 385 & mm_in.hcount < 395)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  100 & mm_in.vcount <  111 & mm_in.hcount > 350 & mm_in.hcount < 390)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  120 & mm_in.vcount <  130 & mm_in.hcount > 345 & mm_in.hcount < 395)
              rgb_nxt = YELLOW;
              //S
          else if (mm_in.vcount >  100 & mm_in.vcount <  110 & mm_in.hcount > 410 & mm_in.hcount < 450)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  109 & mm_in.vcount <  122 & mm_in.hcount > 400 & mm_in.hcount < 410)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  120 & mm_in.vcount <  129 & mm_in.hcount > 410 & mm_in.hcount < 440)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  127 & mm_in.vcount <  140 & mm_in.hcount > 440 & mm_in.hcount < 450)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  139 & mm_in.vcount <  150 & mm_in.hcount > 400 & mm_in.hcount < 440)
              rgb_nxt = YELLOW;
              //Y
          else if (mm_in.vcount > 120 & mm_in.vcount < 150 & mm_in.hcount >  465 & mm_in.hcount < 480)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 115 & mm_in.vcount < 125 & mm_in.hcount >  460 & mm_in.hcount < 470)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 115 & mm_in.vcount < 125 & mm_in.hcount >  475 & mm_in.hcount < 485)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 100 & mm_in.vcount < 120 & mm_in.hcount >  455 & mm_in.hcount < 465)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 100 & mm_in.vcount < 120 & mm_in.hcount >  480 & mm_in.hcount < 490)
              rgb_nxt = YELLOW;
                 //S
          else if (mm_in.vcount >  100 & mm_in.vcount <  110 & mm_in.hcount > 505 & mm_in.hcount < 545)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  109 & mm_in.vcount <  122 & mm_in.hcount > 495 & mm_in.hcount < 505)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  120 & mm_in.vcount <  129 & mm_in.hcount > 505 & mm_in.hcount < 535)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  127 & mm_in.vcount <  140 & mm_in.hcount > 535 & mm_in.hcount < 545)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  139 & mm_in.vcount <  150 & mm_in.hcount > 495 & mm_in.hcount < 535)
              rgb_nxt = YELLOW;
                 //F
          else if (mm_in.vcount >  100 & mm_in.vcount <  150 & mm_in.hcount > 550 & mm_in.hcount < 560)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  100 & mm_in.vcount <  110 & mm_in.hcount > 550 & mm_in.hcount < 585)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  120 & mm_in.vcount <  130 & mm_in.hcount > 550 & mm_in.hcount < 580)
              rgb_nxt = YELLOW;
                  //I
          else if (mm_in.vcount >  100 & mm_in.vcount <  110 & mm_in.hcount > 590 & mm_in.hcount < 620)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  100 & mm_in.vcount <  150 & mm_in.hcount > 600 & mm_in.hcount < 610)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  140 & mm_in.vcount <  150 & mm_in.hcount > 590 & mm_in.hcount < 620)
              rgb_nxt = YELLOW;
           //E
          else if (mm_in.vcount >  100 & mm_in.vcount < 150 & mm_in.hcount > 625 & mm_in.hcount < 635)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  100 & mm_in.vcount < 110 & mm_in.hcount > 625 & mm_in.hcount < 660)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  140 & mm_in.vcount < 150 & mm_in.hcount > 625 & mm_in.hcount < 660)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  120 & mm_in.vcount < 130 & mm_in.hcount > 625 & mm_in.hcount < 655)
              rgb_nxt = YELLOW;
              //L
          else if (mm_in.vcount >  100 & mm_in.vcount < 150 & mm_in.hcount > 665 & mm_in.hcount < 675)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  140 & mm_in.vcount < 150 & mm_in.hcount > 665 & mm_in.hcount < 695)
              rgb_nxt = YELLOW;
              //D
          else if (mm_in.vcount >  100 & mm_in.vcount < 150 & mm_in.hcount > 700 & mm_in.hcount < 710)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  100 & mm_in.vcount < 110 & mm_in.hcount > 700 & mm_in.hcount < 725)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  140 & mm_in.vcount < 150 & mm_in.hcount > 700 & mm_in.hcount < 725)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  109 & mm_in.vcount < 141 & mm_in.hcount > 724 & mm_in.hcount < 735)
              rgb_nxt = YELLOW;
              //PLAY
              //P
          else if (mm_in.vcount > 334 & mm_in.vcount < 434 & mm_in.hcount > 437 & mm_in.hcount < 447)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 334 & mm_in.vcount < 344 & mm_in.hcount > 437 & mm_in.hcount < 467)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 343 & mm_in.vcount < 385 & mm_in.hcount > 466 & mm_in.hcount < 477)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 384 & mm_in.vcount < 394 & mm_in.hcount > 437 & mm_in.hcount < 467)
              rgb_nxt = YELLOW;
              //L
          else if (mm_in.vcount > 334 & mm_in.vcount < 434 & mm_in.hcount > 482 & mm_in.hcount < 492)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 424 & mm_in.vcount < 434 & mm_in.hcount > 482 & mm_in.hcount < 517)
              rgb_nxt = YELLOW;
              //A
          else if (mm_in.vcount >  343 & mm_in.vcount <  434 & mm_in.hcount > 522 & mm_in.hcount < 532)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  343 & mm_in.vcount <  434 & mm_in.hcount > 552 & mm_in.hcount < 562)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  334 & mm_in.vcount <  345 & mm_in.hcount > 531 & mm_in.hcount < 553)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount >  373 & mm_in.vcount <  383 & mm_in.hcount > 522 & mm_in.hcount < 562)
              rgb_nxt = YELLOW;
              //Y
          else if (mm_in.vcount > 374 & mm_in.vcount < 434 & mm_in.hcount > 580 & mm_in.hcount < 590)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 364 & mm_in.vcount < 384 & mm_in.hcount >  572 & mm_in.hcount < 582)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 364 & mm_in.vcount < 384 & mm_in.hcount >  587 & mm_in.hcount < 597)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 334 & mm_in.vcount < 374 & mm_in.hcount >  567 & mm_in.hcount < 577)
              rgb_nxt = YELLOW;
          else if (mm_in.vcount > 334 & mm_in.vcount < 374 & mm_in.hcount >  592 & mm_in.hcount < 602)
              rgb_nxt = YELLOW;
         else                                    // The rest of active display pixels:
              rgb_nxt = BLACK;                // - fill with black.
     end
 end
 
 
 endmodule