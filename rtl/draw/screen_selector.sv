import vga_pkg::*;

module screen_selector(
    input logic clk, rst,
    input state screen,
    vga_if.in bg_in,
    vga_if.out bg_out
);

vga_if vga_nxt();
vga_if vga_start();
vga_if vga_game();
vga_if vga_player_1();
vga_if vga_player_2();

main_menu u_main_menu(
    .clk(clk),
    .rst(rst),
    .bg_in(vga_nxt),
    .bg_out(vga_start)
);

draw_bg u_draw_bg(
    .clk(clk),
    .rst(rst),
    .bg_in(vga_start),
    .bg_out(vga_game)
);

first_player_won u_first_player_won(
    .clk(clk),
    .rst(rst),
    .bg_in(vga_game),
    .bg_out(vga_player_1)
);

second_player_won u_second_player_won(
    .clk(clk),
    .rst(rst),
    .bg_in(vga_game),
    .bg_out(vga_player_2)
);

always_ff@(posedge clk) begin
    if(rst) begin
        bg_out.hcount <= '0;
        bg_out.hblnk  <= '0;
        bg_out.hsync  <= '0;
        bg_out.rgb    <= '0;
        bg_out.vblnk  <= '0;
        bg_out.vcount <= '0;
        bg_out.vsync  <= '0;
    end else
        bg_out.hcount <= vga_nxt.hcount;
        bg_out.hblnk  <= vga_nxt.hblnk;
        bg_out.hsync  <= vga_nxt.hsync;
        bg_out.rgb    <= vga_nxt.rgb;
        bg_out.vblnk  <= vga_nxt.vblnk;
        bg_out.vcount <= vga_nxt.vcount;
        bg_out.vsync  <= vga_nxt.vsync;
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
        vga_start.hblnk  = vga_game.hblnk;
        vga_start.hcount = vga_game.hcount;
        vga_start.hsync  = vga_game.hsync;
        vga_start.rgb    = vga_game.rgb;
        vga_start.vblnk  = vga_game.hblnk;
        vga_start.vcount = vga_game.vcount;
        vga_start.vsync  = vga_game.vsync;
        end

        PLAYER_1: begin
        vga_game.hblnk  = vga_player_1.hblnk;
        vga_game.hcount = vga_player_1.hcount;
        vga_game.hsync  = vga_player_1.hsync;
        vga_game.rgb    = vga_player_1.rgb;
        vga_game.vblnk  = vga_player_1.hblnk;
        vga_game.vcount = vga_player_1.vcount;
        vga_game.vsync  = vga_player_1.vsync;
        end

        PLAYER_2: begin
        vga_game.hblnk  = vga_player_2.hblnk;
        vga_game.hcount = vga_player_2.hcount;
        vga_game.hsync  = vga_player_2.hsync;
        vga_game.rgb    = vga_player_2.rgb;
        vga_game.vblnk  = vga_player_2.hblnk;
        vga_game.vcount = vga_player_2.vcount;
        vga_game.vsync  = vga_player_2.vsync;
        end
        default: begin
            vga_nxt.hcount  = bg_in.hcount;
            vga_nxt.vcount  = bg_in.vcount;
            vga_nxt.hblnk   = bg_in.hblnk;
            vga_nxt.vblnk   = bg_in.vblnk;
            vga_nxt.hsync   = bg_in.hsync;
            vga_nxt.vsync   = bg_in.vsync;
        end
    endcase
end
endmodule
