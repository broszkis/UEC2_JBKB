module screen_selector(
    input logic clk, rst, start, stop, first, second,
    vga_if.in screen_in,
    vga_if.out screen_out
);

enum logic [1:0] {START, GAME, PLAYER_1, PLAYER_2} state;

vga_if vga_nxt();
vga_if vga_start();
vga_if vga_game();
vga_if vga_player_1();
vga_if vga_player_2();

vga_if vga_timing();
vga_if vga_bg();

draw_bg u_draw_bg(
    .clk,
    .rst,
    .vga_inbg(vga_timing),
    .vga_outbg(vga_bg)
);

main_menu u_main_menu(
    .clk,
    .rst,
    .vga_inbg(vga_bg),
    .vga_outbg(vga_start)
);

always_ff@(posedge clk) begin
    if(rst) begin
        screen_out.hcount <= '0;
        screen_out.hblnk  <= '0;
        screen_out.hsync  <= '0;
        screen_out.rgb    <= '0;
        screen_out.vblnk  <= '0;
        screen_out.vcount <= '0;
        screen_out.vsync  <= '0;
    end else
        screen_out.hcount <= vga_nxt.hcount;
        screen_out.hblnk  <= vga_nxt.hblnk;
        screen_out.hsync  <= vga_nxt.hsync;
        screen_out.rgb    <= vga_nxt.rgb;
        screen_out.vblnk  <= vga_nxt.vblnk;
        screen_out.vcount <= vga_nxt.vcount;
        screen_out.vsync  <= vga_nxt.vsync;
end

always_comb begin

    case (state)
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
        vga_player_1.hblnk  = vga_player_2.hblnk;
        vga_player_1.hcount = vga_player_2.hcount;
        vga_player_1.hsync  = vga_player_2.hsync;
        vga_player_1.rgb    = vga_player_2.rgb;
        vga_player_1.vblnk  = vga_player_2.hblnk;
        vga_player_1.vcount = vga_player_2.vcount;
        vga_player_1.vsync  = vga_player_2.vsync;
        end
        default: begin
            vga_nxt.hcount  = screen_in.hcount;
            vga_nxt.vcount  = screen_in.vcount;
            vga_nxt.hblnk   = screen_in.hblnk;
            vga_nxt.vblnk   = screen_in.vblnk;
            vga_nxt.hsync   = screen_in.hsync;
            vga_nxt.vsync   = screen_in.vsync;
        end
    endcase
end
endmodule