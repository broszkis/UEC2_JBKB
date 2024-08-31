`timescale 1ns/1ps

import vga_pkg::*;

module screen_control (
    input logic  clk,
    input logic  rst,
    input logic [3:0] points,
    input logic [15:0] keycode, 
    output state [1:0] current_screen
);

logic [1:0] screen_nxt;

always_ff @(posedge clk) begin
    if (rst) begin
        current_screen <= START;
    end else begin
        current_screen <= screen_nxt;
    end
end

always_comb begin
    case (current_screen)
        START: begin
            if ((keycode[15:8] != 8'hf0) && (keycode[7:0] == 8'h5A))
                    screen_nxt = GAME;
            end
        GAME: begin
            if (points >= 4'd5)
                screen_nxt = PLAYER_1;
            else
                screen_nxt = GAME;
        end
        PLAYER_1: begin
            if ((keycode[15:8] != 8'hf0) && (keycode[7:0] == 8'h5A))
                    screen_nxt = GAME;
        end
        default:
            screen_nxt = START;
    endcase
end

endmodule



