module random_generate (
    input logic clk,
    input logic rst,
    input logic [9:0] player_x,
    input logic [9:0] player_y,
    output logic [9:0] point_x,
    output logic [9:0] point_y,
    output logic point_active
);

    import vga_pkg::*;

    logic [9:0] point_x_nxt, point_y_nxt, point_x_temp, point_y_temp, point_x_temp_nxt, point_y_temp_nxt;

    initial begin 
        point_active = 1;
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            point_x <= '0;
            point_y <= '0;
            point_x_temp <= '0;

            point_y_temp <= '0;
        end else begin
            point_x <= point_x_nxt;
            point_y <= point_y_nxt;
            point_x_temp <= point_x_temp_nxt;

            point_y_temp <= point_y_temp_nxt;
        end
    end

    always_comb begin
        if (point_x_temp < 1024)
            point_x_temp_nxt = point_x_temp + 32;
        else
            point_x_temp_nxt = '0;
        if (point_y_temp < 768)
            point_y_temp_nxt = point_y_temp + 32;
        else
            point_y_temp_nxt = '0;
        if (point_x + POINT_SIZE >= player_x - PLAYER_SIZE + 1 && point_x - POINT_SIZE <= player_x + PLAYER_SIZE && point_y + POINT_SIZE >= player_y - PLAYER_SIZE + 1 && point_y + POINT_SIZE <= player_y + PLAYER_SIZE)
            point_active = 0;
        else
            point_active = 1;
        if (point_active == 0) begin
            point_x_nxt = point_x_temp;
            point_y_nxt = point_y_temp;
            point_active = 1;
        end else begin 
            point_x_nxt = point_x;
            point_y_nxt = point_y;
        end
    end

endmodule
