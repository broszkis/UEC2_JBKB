module hold (
    input  wire  clk,
    input  wire  rst,
    input logic[15:0] keycode,
    input logic move_up, move_down, move_right, move_left,
    output logic [15:0] keycode_ff,
    output logic move_up_ff, move_down_ff, move_right_ff, move_left_ff
);

always_ff @(posedge clk) begin
    if(rst) begin
        move_up_ff <= '0;
        move_down_ff <= '0;
        move_right_ff <= '0;
        move_left_ff <= '0;
        keycode_ff <= '0;
    end else begin
        move_up_ff <= move_up; 
        move_down_ff <= move_down; 
        move_right_ff <= move_right; 
        move_left_ff <= move_left; 
        keycode_ff <= keycode;
    end
end

endmodule