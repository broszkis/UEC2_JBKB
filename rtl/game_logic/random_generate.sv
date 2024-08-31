module random_generate (
    input logic clk,
    input logic rst,
    input logic [9:0] player_x,
    input logic [9:0] player_y,
    output logic [9:0] point_x,
    output logic [9:0] point_y
);

    import vga_pkg::*;

    wire collision_up, collision_down, collision_right, collision_left;

    logic [9:0] point_x_nxt, point_y_nxt;
    logic [9:0] point_x_temp, point_y_temp;

    logic [9:0] point_xpos[31] = '{32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 480, 512, 544, 576, 608, 640, 672, 704, 736, 768, 800, 832, 864, 896, 928, 960, 992}; 
    logic [9:0] point_ypos[23] = '{32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 480, 512, 544, 576, 608, 640, 672, 704, 736};

    // Linear Feedback Shift Register (LFSR) for generating random indices
    logic [4:0] lfsr_x = 5'd1; // 5-bit LFSR for x-axis
    logic [4:0] lfsr_y = 5'd1; // 5-bit LFSR for y-axis

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
        point_x = 512;
        point_y = 64;
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            point_x <= '0;
            point_y <= '0;
            lfsr_x <= 5'd1;
            lfsr_y <= 5'd1;
        end else begin
            point_x <= point_x_nxt;
            point_y <= point_y_nxt;
            lfsr_x <= {lfsr_x[3:0], lfsr_x[4] ^ lfsr_x[3]}; // Update LFSR for x
            lfsr_y <= {lfsr_y[3:0], lfsr_y[4] ^ lfsr_y[3]}; // Update LFSR for y
        end
    end

    always_comb begin
        point_x_temp = point_xpos[lfsr_x % 32];
        point_y_temp = point_ypos[lfsr_y % 24];
        point_x_nxt = point_x;
        point_y_nxt = point_y;
        // Sprawdzamy czy gracz wszedl w punkt
        if (((point_x + POINT_SIZE < player_x - PLAYER_SIZE) || (point_x - POINT_SIZE > player_x + PLAYER_SIZE)) || ((point_y + POINT_SIZE < player_y - PLAYER_SIZE) || (point_y - POINT_SIZE > player_y + PLAYER_SIZE))) begin
            point_x_nxt = point_x;
            point_y_nxt = point_y;
        end else begin
        // Sprawdzamy czy nowo wygenerowany punkt nie koliduje z terenem / pojawia sie na wspolrzednych startowych graczy
        if ((!(collision_up || collision_down || collision_right || collision_left)) && (!((point_x_temp == 32 && point_y_temp == 32) || (point_x_temp == 992 && point_y_temp == 736)))) begin
            point_x_nxt = point_x_temp;
            point_y_nxt = point_y_temp;
        end else begin 
            point_x_nxt = point_x_nxt;
            point_y_nxt = point_y_nxt;
        end
        end
    end

endmodule
