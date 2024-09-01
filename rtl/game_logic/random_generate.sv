module random_generate (
    input logic clk,
    input logic rst,
    input logic [9:0] player1_x,
    input logic [9:0] player1_y,
    input logic [9:0] player2_x,
    input logic [9:0] player2_y,
    output logic [9:0] point_x,
    output logic [9:0] point_y,
    output logic [4:0] points_1, points_2
);

import vga_pkg::*;

wire collision_up, collision_down, collision_right, collision_left;
logic [9:0] point_x_nxt, point_y_nxt;
logic [9:0] point_x_temp, point_y_temp;
logic [4:0] points_1_nxt, points_2_nxt;;
logic [9:0] point_xpos[31] = '{32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 480, 512, 544, 576, 608, 640, 672, 704, 736, 768, 800, 832, 864, 896, 928, 960, 992}; 
logic [9:0] point_ypos[23] = '{32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 480, 512, 544, 576, 608, 640, 672, 704, 736};
logic [4:0] lfsr_x = 5'h1F; // 5-bit LFSR for x-axis
logic [4:0] lfsr_y = 5'h1B; // 5-bit LFSR for y-axis
logic point_collected; // Nowy sygnał wskazujący, że punkt został już zebrany
logic [13:0] ctr, ctr_2, ctr_nxt, ctr_2_nxt;

collision 
#(
    .SIZE(8)
) 
u_point_collision (
    .xpos(point_x_temp),
    .ypos(point_y_temp),
    .collision_up,
    .collision_down,
    .collision_right,
    .collision_left
);

initial begin
    point_collected = '0; // Inicjalizacja nowego sygnału
end

always_ff @(posedge clk) begin
    if (rst) begin
        point_x <= 512;
        point_y <= 64;
        points_1 <= '0;
        points_2 <= '0;
        lfsr_x <= 5'h1F;
        lfsr_y <= 5'h1A;
        ctr <= '0;
        ctr_2 <= '0;
        point_collected <= '0; // Resetowanie sygnału
    end else begin
        point_x <= point_x_nxt;
        point_y <= point_y_nxt;
        points_1 <= points_1_nxt;
        points_2 <= points_2_nxt;
        ctr <= ctr_nxt;
        ctr_2 <= ctr_2_nxt;
        lfsr_x <= {lfsr_x[3:0], lfsr_x[4] ^ lfsr_x[3]};
        lfsr_y <= {lfsr_y[3:0], lfsr_y[4] ^ lfsr_y[3]};
        point_collected <= (point_x_nxt == point_x_temp) && (point_y_nxt == point_y_temp); // Aktualizacja sygnału na podstawie tego, czy punkt został zebrany
    end
end

always_comb begin
    point_x_temp = point_xpos[lfsr_x % 32];
    point_y_temp = point_ypos[lfsr_y % 24];
    // Sprawdzamy czy gracz wszedl w punkt
    if (((point_x + POINT_SIZE < player1_x - PLAYER_SIZE) || (point_x - POINT_SIZE > player1_x + PLAYER_SIZE) || 
     (point_y + POINT_SIZE < player1_y - PLAYER_SIZE) || (point_y - POINT_SIZE > player1_y + PLAYER_SIZE)) && 
    ((point_x + POINT_SIZE < player2_x - PLAYER_SIZE) || (point_x - POINT_SIZE > player2_x + PLAYER_SIZE) || 
     (point_y + POINT_SIZE < player2_y - PLAYER_SIZE) || (point_y - POINT_SIZE > player2_y + PLAYER_SIZE))) begin
        point_x_nxt = point_x;
        point_y_nxt = point_y;
    end else begin
        // Sprawdzamy czy nowo wygenerowany punkt nie koliduje z terenem / pojawia sie na wspolrzednych startowych graczy
        if ((!(collision_up || collision_down || collision_right || collision_left)) && (!((point_x_temp == 32 && point_y_temp == 32) || (point_x_temp == 992 && point_y_temp == 736)))) begin
            point_x_nxt = point_x_temp;
            point_y_nxt = point_y_temp;
        end else begin 
            point_x_nxt = point_x;
            point_y_nxt = point_y;
        end
    end
end

always_comb begin 
    if ((!((point_x + POINT_SIZE < player1_x - PLAYER_SIZE) || (point_x - POINT_SIZE > player1_x + PLAYER_SIZE) || (point_y + POINT_SIZE < player1_y - PLAYER_SIZE) || (point_y - POINT_SIZE > player1_y + PLAYER_SIZE))) && (!point_collected) && ctr >= 10000) begin
        points_1_nxt = points_1 + 1;
        ctr_nxt = '0;
    end else if(ctr >= 10_000) begin
        points_1_nxt = points_1;
        ctr_nxt = ctr;
    end
    else begin
        points_1_nxt = points_1;
        ctr_nxt = ctr + 1;
    end
    if ((!((point_x + POINT_SIZE < player2_x - PLAYER_SIZE) || (point_x - POINT_SIZE > player2_x + PLAYER_SIZE) || (point_y + POINT_SIZE < player2_y - PLAYER_SIZE) || (point_y - POINT_SIZE > player2_y + PLAYER_SIZE))) && (!point_collected) && ctr_2 >= 10000) begin
        points_2_nxt = points_2 + 1;
        ctr_2_nxt = '0;
    end else if(ctr_2 >= 10_000) begin
        points_2_nxt = points_2;
        ctr_2_nxt = ctr_2;
    end
    else begin
        points_2_nxt = points_2;
        ctr_2_nxt = ctr_2 + 1;
    end
end

endmodule
