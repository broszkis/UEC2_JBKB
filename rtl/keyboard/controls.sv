module controls (
    input logic clk,
    input logic rst,
    input logic [15:0] keycode,
    output logic move_right,
    output logic move_left,
    output logic move_up,
    output logic move_down
);

logic mvu_nxt, mvd_nxt, mvr_nxt, mvl_nxt;

always_ff @(posedge clk) begin 
    if (rst) begin
        move_right <= '0;
        move_left <= '0;
        move_up <= '0;
        move_down <= '0;    
    end
    else begin
        move_right <= mvr_nxt;
        move_left <= mvl_nxt;
        move_up <= mvu_nxt;
        move_down <= mvd_nxt;
    end
end

always_comb begin 
    if (keycode[15:8] == 8'hf0) begin 
        if (keycode[7:0] == 8'h1D) begin 
            mvr_nxt = 0;
            mvl_nxt = 0;
            mvu_nxt = move_up;
            mvd_nxt = 0;
        end
        else if (keycode[7:0] == 8'h1B) begin 
            mvr_nxt = 0;
            mvl_nxt = 0;
            mvu_nxt = 0;
            mvd_nxt = move_down;
        end
        else if (keycode[7:0] == 8'h23) begin 
            mvr_nxt = move_right;
            mvl_nxt = 0;
            mvu_nxt = 0;
            mvd_nxt = 0;
        end
        else if (keycode[7:0] == 8'h1D) begin 
            mvr_nxt = 0;
            mvl_nxt = move_left;
            mvu_nxt = 0;
            mvd_nxt = 0;
        end
        else begin 
            mvr_nxt = move_right;
            mvl_nxt = move_left;
            mvu_nxt = move_up;
            mvd_nxt = move_down;
        end
    end
    
    else begin
        if (keycode[7:0] == 8'h1D) begin 
            mvr_nxt = move_right;
            mvl_nxt = move_left;
            mvu_nxt = 1;
            mvd_nxt = move_down;
        end
        else if (keycode[7:0] == 8'h1B) begin 
            mvr_nxt = move_right;
            mvl_nxt = move_left;
            mvu_nxt = move_up;
            mvd_nxt = 1;
        end
        else if (keycode[7:0] == 8'h23) begin 
            mvr_nxt = 1;
            mvl_nxt = move_left;
            mvu_nxt = move_up;
            mvd_nxt = move_down;
        end
        else if (keycode[7:0] == 8'h1D) begin 
            mvr_nxt = move_right;
            mvl_nxt = 1;
            mvu_nxt = move_up;
            mvd_nxt = move_down;
        end
        else begin 
            mvr_nxt = move_right;
            mvl_nxt = move_left;
            mvu_nxt = move_up;
            mvd_nxt = move_down;
        end
    end
end

endmodule