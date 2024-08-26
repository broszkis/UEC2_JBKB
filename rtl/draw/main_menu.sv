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
         rgb_nxt = BLACK;                    // - make it it black.
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
          //2
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount <180 & vga_inbg.hcount > 320 & vga_inbg.hcount < 340)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 175  & vga_inbg.vcount <185 & vga_inbg.hcount >  315 & vga_inbg.hcount < 325)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 175 & vga_inbg.vcount <190 & vga_inbg.hcount >  335 & vga_inbg.hcount < 345)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 185 & vga_inbg.vcount <195 & vga_inbg.hcount >  330 & vga_inbg.hcount < 340)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 190 & vga_inbg.vcount <200 & vga_inbg.hcount >  325 & vga_inbg.hcount < 335)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 195 & vga_inbg.vcount <205 & vga_inbg.hcount >  320 & vga_inbg.hcount < 330)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 200 & vga_inbg.vcount <215 & vga_inbg.hcount >  315 & vga_inbg.hcount < 325)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 205 & vga_inbg.vcount <215 & vga_inbg.hcount > 315  & vga_inbg.hcount < 345)
              rgb_nxt = BLUE;
          //P
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount <215 & vga_inbg.hcount >  365 & vga_inbg.hcount < 375)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount <180 & vga_inbg.hcount >  365 & vga_inbg.hcount <  385)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 175 & vga_inbg.vcount <185 & vga_inbg.hcount >   380 & vga_inbg.hcount <  390)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 180 & vga_inbg.vcount <195 & vga_inbg.hcount >   385 & vga_inbg.hcount <  390)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 190 & vga_inbg.vcount <200 & vga_inbg.hcount >   380 & vga_inbg.hcount <  390)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 195 & vga_inbg.vcount <200 & vga_inbg.hcount >  365 & vga_inbg.hcount <  385)
              rgb_nxt = BLUE;
          //L
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount < 215 & vga_inbg.hcount >  400 & vga_inbg.hcount < 410)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 205 & vga_inbg.vcount < 215 & vga_inbg.hcount >  400 & vga_inbg.hcount <  425 )
              rgb_nxt = BLUE;
          //A
          else if (vga_inbg.vcount > 175 & vga_inbg.vcount < 215 & vga_inbg.hcount >  430 & vga_inbg.hcount < 440)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 175 & vga_inbg.vcount < 215 & vga_inbg.hcount >  445 & vga_inbg.hcount <  455)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount < 180 & vga_inbg.hcount >  435 & vga_inbg.hcount < 450)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 190 & vga_inbg.vcount < 200 & vga_inbg.hcount >  430 & vga_inbg.hcount <  455 )
              rgb_nxt = BLUE;
          //Y
          else if (vga_inbg.vcount > 185 & vga_inbg.vcount < 215 & vga_inbg.hcount >  470 & vga_inbg.hcount < 480)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 180 & vga_inbg.vcount < 190 & vga_inbg.hcount >  465 & vga_inbg.hcount <  475 )
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 180 & vga_inbg.vcount < 190 & vga_inbg.hcount >  475 & vga_inbg.hcount < 485)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount < 185 & vga_inbg.hcount >  460 & vga_inbg.hcount <  470 )
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount < 185 & vga_inbg.hcount >  480 & vga_inbg.hcount <  490)
              rgb_nxt = BLUE;
          //E
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount <215 & vga_inbg.hcount >  495 & vga_inbg.hcount < 505)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount <180 & vga_inbg.hcount >  495 & vga_inbg.hcount < 520)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 205 & vga_inbg.vcount <215 & vga_inbg.hcount >  495 & vga_inbg.hcount < 520)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 188 & vga_inbg.vcount <198 & vga_inbg.hcount >  495 & vga_inbg.hcount < 515)
              rgb_nxt = BLUE;
          //R
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount <215 & vga_inbg.hcount >  525 & vga_inbg.hcount < 535)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 170 & vga_inbg.vcount <180 & vga_inbg.hcount >  525 & vga_inbg.hcount < 540)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 175 & vga_inbg.vcount <185 & vga_inbg.hcount >  539 & vga_inbg.hcount < 549)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 180 & vga_inbg.vcount <195 & vga_inbg.hcount >  545 & vga_inbg.hcount < 554)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 190 & vga_inbg.vcount <202 & vga_inbg.hcount >  539 & vga_inbg.hcount < 549)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 195 & vga_inbg.vcount <205 & vga_inbg.hcount >  525 & vga_inbg.hcount < 540)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 200 & vga_inbg.vcount <210 & vga_inbg.hcount >  539 & vga_inbg.hcount < 549)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount > 205 & vga_inbg.vcount <215 & vga_inbg.hcount >  545 & vga_inbg.hcount < 554)
              rgb_nxt = BLUE;
          //GAME
          //G
          else if (vga_inbg.vcount >  170 & vga_inbg.vcount < 215 & vga_inbg.hcount > 574 & vga_inbg.hcount <584)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  170 & vga_inbg.vcount < 180 & vga_inbg.hcount > 574 & vga_inbg.hcount <604)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  205 & vga_inbg.vcount < 215 & vga_inbg.hcount > 574 & vga_inbg.hcount <599)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  190 & vga_inbg.vcount < 200 & vga_inbg.hcount > 589 & vga_inbg.hcount <604)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  190 & vga_inbg.vcount < 215 & vga_inbg.hcount > 596 & vga_inbg.hcount <604)
              rgb_nxt = BLUE;
          //A
          else if (vga_inbg.vcount >  175 & vga_inbg.vcount <  215 & vga_inbg.hcount > 609 & vga_inbg.hcount < 619)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  175 & vga_inbg.vcount <  215 & vga_inbg.hcount > 624 & vga_inbg.hcount < 634)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  170 & vga_inbg.vcount <  180 & vga_inbg.hcount > 614 & vga_inbg.hcount < 629)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  190 & vga_inbg.vcount <  200 & vga_inbg.hcount > 609 & vga_inbg.hcount < 634)
              rgb_nxt = BLUE;
          //M
          else if (vga_inbg.vcount >  170 & vga_inbg.vcount <  215 & vga_inbg.hcount > 639 & vga_inbg.hcount < 649)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  170 & vga_inbg.vcount <  215 & vga_inbg.hcount > 669 & vga_inbg.hcount < 679)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  180 & vga_inbg.vcount <  190 & vga_inbg.hcount > 648 & vga_inbg.hcount < 658)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  180 & vga_inbg.vcount <  190 & vga_inbg.hcount > 660 & vga_inbg.hcount < 670)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  189 & vga_inbg.vcount <  199 & vga_inbg.hcount > 654 & vga_inbg.hcount < 664)
              rgb_nxt = BLUE;
          //E
          else if (vga_inbg.vcount >  170 & vga_inbg.vcount < 215 & vga_inbg.hcount > 684 & vga_inbg.hcount < 694)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  170 & vga_inbg.vcount < 180 & vga_inbg.hcount > 684 & vga_inbg.hcount < 709)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  205 & vga_inbg.vcount < 215 & vga_inbg.hcount > 684 & vga_inbg.hcount < 709)
              rgb_nxt = BLUE;
          else if (vga_inbg.vcount >  188 & vga_inbg.vcount < 198 & vga_inbg.hcount > 684 & vga_inbg.hcount < 704)
              rgb_nxt = BLUE;
              //BASYSFIELD
          else if (vga_inbg.vcount > 50 & vga_inbg.vcount < 150 & vga_inbg.hcount > 255 & vga_inbg.hcount < 265)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 50 & vga_inbg.vcount < 60 & vga_inbg.hcount > 255 & vga_inbg.hcount < 295)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 140 & vga_inbg.vcount < 150 & vga_inbg.hcount > 255 & vga_inbg.hcount < 295)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 95 & vga_inbg.vcount < 105 & vga_inbg.hcount > 255 & vga_inbg.hcount < 295)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 59 & vga_inbg.vcount < 96 & vga_inbg.hcount > 294 & vga_inbg.hcount < 305)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 104 & vga_inbg.vcount < 141 & vga_inbg.hcount > 294 & vga_inbg.hcount < 305)
              rgb_nxt = YELLOW;
              //A
          else if (vga_inbg.vcount >  110 & vga_inbg.vcount <  150 & vga_inbg.hcount > 310 & vga_inbg.hcount < 320)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  110 & vga_inbg.vcount <  150 & vga_inbg.hcount > 350 & vga_inbg.hcount < 360)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount <  111 & vga_inbg.hcount > 315 & vga_inbg.hcount < 355)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  120 & vga_inbg.vcount <  130 & vga_inbg.hcount > 310 & vga_inbg.hcount < 360)
              rgb_nxt = YELLOW;
              //S
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount <  110 & vga_inbg.hcount > 375 & vga_inbg.hcount < 415)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  109 & vga_inbg.vcount <  122 & vga_inbg.hcount > 365 & vga_inbg.hcount < 375)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  120 & vga_inbg.vcount <  129 & vga_inbg.hcount > 375 & vga_inbg.hcount < 405)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  127 & vga_inbg.vcount <  140 & vga_inbg.hcount > 405 & vga_inbg.hcount < 415)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  139 & vga_inbg.vcount <  150 & vga_inbg.hcount > 365 & vga_inbg.hcount < 405)
              rgb_nxt = YELLOW;
              //Y
          else if (vga_inbg.vcount > 120 & vga_inbg.vcount < 150 & vga_inbg.hcount >  430 & vga_inbg.hcount < 445)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 115 & vga_inbg.vcount < 125 & vga_inbg.hcount >  425 & vga_inbg.hcount < 435)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 115 & vga_inbg.vcount < 125 & vga_inbg.hcount >  440 & vga_inbg.hcount < 450)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 100 & vga_inbg.vcount < 120 & vga_inbg.hcount >  420 & vga_inbg.hcount < 430)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 100 & vga_inbg.vcount < 120 & vga_inbg.hcount >  445 & vga_inbg.hcount < 455)
              rgb_nxt = YELLOW;
                 //S
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount <  110 & vga_inbg.hcount > 470 & vga_inbg.hcount < 510)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  109 & vga_inbg.vcount <  122 & vga_inbg.hcount > 460 & vga_inbg.hcount < 470)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  120 & vga_inbg.vcount <  129 & vga_inbg.hcount > 470 & vga_inbg.hcount < 500)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  127 & vga_inbg.vcount <  140 & vga_inbg.hcount > 500 & vga_inbg.hcount < 510)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  139 & vga_inbg.vcount <  150 & vga_inbg.hcount > 460 & vga_inbg.hcount < 500)
              rgb_nxt = YELLOW;
                 //F
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount <  150 & vga_inbg.hcount > 515 & vga_inbg.hcount < 525)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount <  110 & vga_inbg.hcount > 515 & vga_inbg.hcount < 550)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  120 & vga_inbg.vcount <  130 & vga_inbg.hcount > 515 & vga_inbg.hcount < 545)
              rgb_nxt = YELLOW;
                  //I
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount <  110 & vga_inbg.hcount > 555 & vga_inbg.hcount < 585)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount <  150 & vga_inbg.hcount > 565 & vga_inbg.hcount < 575)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  140 & vga_inbg.vcount <  150 & vga_inbg.hcount > 555 & vga_inbg.hcount < 585)
              rgb_nxt = YELLOW;
           //E
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount < 150 & vga_inbg.hcount > 590 & vga_inbg.hcount < 600)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount < 110 & vga_inbg.hcount > 590 & vga_inbg.hcount < 625)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  140 & vga_inbg.vcount < 150 & vga_inbg.hcount > 590 & vga_inbg.hcount < 625)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  120 & vga_inbg.vcount < 130 & vga_inbg.hcount > 590 & vga_inbg.hcount < 620)
              rgb_nxt = YELLOW;
              //L
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount < 150 & vga_inbg.hcount > 630 & vga_inbg.hcount < 640)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  140 & vga_inbg.vcount < 150 & vga_inbg.hcount > 630 & vga_inbg.hcount < 660)
              rgb_nxt = YELLOW;
              //D
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount < 150 & vga_inbg.hcount > 665 & vga_inbg.hcount < 675)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  100 & vga_inbg.vcount < 110 & vga_inbg.hcount > 665 & vga_inbg.hcount < 690)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  140 & vga_inbg.vcount < 150 & vga_inbg.hcount > 665 & vga_inbg.hcount < 690)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  109 & vga_inbg.vcount < 141 & vga_inbg.hcount > 689 & vga_inbg.hcount < 700)
              rgb_nxt = YELLOW;
              //PLAY
              //P
          else if (vga_inbg.vcount > 334 & vga_inbg.vcount < 434 & vga_inbg.hcount > 437 & vga_inbg.hcount < 447)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 334 & vga_inbg.vcount < 344 & vga_inbg.hcount > 437 & vga_inbg.hcount < 467)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 343 & vga_inbg.vcount < 385 & vga_inbg.hcount > 466 & vga_inbg.hcount < 477)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 384 & vga_inbg.vcount < 394 & vga_inbg.hcount > 437 & vga_inbg.hcount < 467)
              rgb_nxt = YELLOW;
              //L
          else if (vga_inbg.vcount > 334 & vga_inbg.vcount < 434 & vga_inbg.hcount > 482 & vga_inbg.hcount < 492)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 424 & vga_inbg.vcount < 434 & vga_inbg.hcount > 482 & vga_inbg.hcount < 517)
              rgb_nxt = YELLOW;
              //A
          else if (vga_inbg.vcount >  343 & vga_inbg.vcount <  434 & vga_inbg.hcount > 522 & vga_inbg.hcount < 532)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  343 & vga_inbg.vcount <  434 & vga_inbg.hcount > 552 & vga_inbg.hcount < 562)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  334 & vga_inbg.vcount <  345 & vga_inbg.hcount > 531 & vga_inbg.hcount < 553)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount >  373 & vga_inbg.vcount <  383 & vga_inbg.hcount > 522 & vga_inbg.hcount < 562)
              rgb_nxt = YELLOW;
              //Y
          else if (vga_inbg.vcount > 374 & vga_inbg.vcount < 434 & vga_inbg.hcount > 580 & vga_inbg.hcount < 590)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 364 & vga_inbg.vcount < 384 & vga_inbg.hcount >  572 & vga_inbg.hcount < 582)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 364 & vga_inbg.vcount < 384 & vga_inbg.hcount >  587 & vga_inbg.hcount < 597)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 334 & vga_inbg.vcount < 374 & vga_inbg.hcount >  567 & vga_inbg.hcount < 577)
              rgb_nxt = YELLOW;
          else if (vga_inbg.vcount > 334 & vga_inbg.vcount < 374 & vga_inbg.hcount >  592 & vga_inbg.hcount < 602)
              rgb_nxt = YELLOW;
         else                                    // The rest of active display pixels:
              rgb_nxt = BLACK;                // - fill with black.
     end
 end
 
 
 endmodule