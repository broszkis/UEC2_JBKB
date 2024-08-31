import vga_pkg::*;

module screen_selector(
    input logic clk, rst,
    input logic move_up, move_down, move_right, move_left,
    input state screen,
    vga_tim.in ss_in,
    vga_if.out ss_out
);

vga_if vga_nxt();
vga_if vga_start();
vga_if vga_game();
vga_if vga_player_1();
vga_if vga_player_2();

main_menu u_main_menu(
    .clk(clk),
    .rst(rst),
    .mm_in(ss_in),
    .mm_out(vga_start)
);

draw_game u_draw_game(
    .clk(clk),
    .rst(rst),
    .game_in(ss_in),
    .game_out(vga_game),
    .move_up,
    .move_down,
    .move_right,
    .move_left
);

first_player_won u_first_player_won(
    .clk(clk),
    .rst(rst),
    .fp_in(ss_in),
    .fp_out(vga_player_1)
);

second_player_won u_second_player_won(
    .clk(clk),
    .rst(rst),
    .sp_in(ss_in),
    .sp_out(vga_player_2)
);

always_ff@(posedge clk) begin
    if(rst) begin
        ss_out.hcount <= '0;
        ss_out.hblnk  <= '0;
        ss_out.hsync  <= '0;
        ss_out.vblnk  <= '0;
        ss_out.vcount <= '0;
        ss_out.vsync  <= '0;
        ss_out.rgb    <= '0;
    end else begin
        ss_out.hcount <= vga_nxt.hcount;
        ss_out.hblnk  <= vga_nxt.hblnk;
        ss_out.hsync  <= vga_nxt.hsync;
        ss_out.rgb    <= vga_nxt.rgb;
        ss_out.vblnk  <= vga_nxt.vblnk;
        ss_out.vcount <= vga_nxt.vcount;
        ss_out.vsync  <= vga_nxt.vsync;
    end
end

always_comb begin

    case (screen)
        START: begin
        vga_nxt.hblnk  = vga_start.hblnk;
        vga_nxt.hcount = vga_start.hcount;
        vga_nxt.hsync  = vga_start.hsync;
        vga_nxt.rgb    = vga_start.rgb;
        vga_nxt.vblnk  = vga_start.hblnk;
        vga_nxt.vcount = vga_start.vcount;
        vga_nxt.vsync  = vga_start.vsync;
        end

        GAME: begin
        vga_nxt.hblnk  = vga_game.hblnk;
        vga_nxt.hcount = vga_game.hcount;
        vga_nxt.hsync  = vga_game.hsync;
        vga_nxt.rgb    = vga_game.rgb;
        vga_nxt.vblnk  = vga_game.hblnk;
        vga_nxt.vcount = vga_game.vcount;
        vga_nxt.vsync  = vga_game.vsync;
        end

        PLAYER_1: begin
        vga_nxt.hblnk  = vga_player_1.hblnk;
        vga_nxt.hcount = vga_player_1.hcount;
        vga_nxt.hsync  = vga_player_1.hsync;
        vga_nxt.rgb    = vga_player_1.rgb;
        vga_nxt.vblnk  = vga_player_1.hblnk;
        vga_nxt.vcount = vga_player_1.vcount;
        vga_nxt.vsync  = vga_player_1.vsync;
        end

        PLAYER_2: begin
        vga_nxt.hblnk  = vga_player_2.hblnk;
        vga_nxt.hcount = vga_player_2.hcount;
        vga_nxt.hsync  = vga_player_2.hsync;
        vga_nxt.rgb    = vga_player_2.rgb;
        vga_nxt.vblnk  = vga_player_2.hblnk;
        vga_nxt.vcount = vga_player_2.vcount;
        vga_nxt.vsync  = vga_player_2.vsync;
        end

        default: begin
        vga_nxt.hcount  = ss_in.hcount;
        vga_nxt.vcount  = ss_in.vcount;
        vga_nxt.hblnk   = ss_in.hblnk;
        vga_nxt.vblnk   = ss_in.vblnk;
        vga_nxt.hsync   = ss_in.hsync;
        vga_nxt.vsync   = ss_in.vsync;
        end
    endcase
end
endmodule
