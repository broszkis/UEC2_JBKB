`timescale 1ns/1ps

import vga_pkg::*;

module screen_control (
    input logic  clk,
    input logic  rst,
    input logic [15:0] keycode, 
    output state screen
);

state current_screen, screen_nxt;

always_ff @(posedge clk) begin
    if (rst) begin
        current_screen <= START;
    end else begin
        current_screen <= screen_nxt;
    end
end

always_comb begin
    screen_nxt = current_screen; 
    
    case (current_screen)
        START: begin
            if (keycode[15:8] != 8'hf0) begin
                case (keycode[7:0])
                8'h5A: screen_nxt = GAME;
                endcase
            end
        end
endcase 
    end
assign mode = current_screen;

endmodule