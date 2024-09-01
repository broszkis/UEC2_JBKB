module controls (
    input logic clk,
    input logic rst,
    input logic [15:0] keycode,
    output logic move_right,
    output logic move_left,
    output logic move_up,
    output logic move_down
);

logic [13:0] ctr, ctr_nxt;
logic mvu_nxt, mvd_nxt, mvr_nxt, mvl_nxt;

initial begin
    ctr = 10000;
end

always_ff @(posedge clk) begin 
    if (rst) begin
        move_right <= '0;
        move_left <= '0;
        move_up <= '0;
        move_down <= '0;  
        ctr <= '0;  
    end
    else begin
        move_right <= mvr_nxt;
        move_left <= mvl_nxt;
        move_up <= mvu_nxt;
        move_down <= mvd_nxt;
        ctr <= ctr_nxt;  
    end
end

always_comb begin 
    mvr_nxt = move_right;
    mvl_nxt = move_left;
    mvu_nxt = move_up;
    mvd_nxt = move_down;

    if (keycode[15:8] != 8'hf0 && ctr >= 10000) begin
        ctr_nxt = '0;
        case (keycode[7:0])
            8'h1D: mvu_nxt = 1;
            8'h1B: mvd_nxt = 1;
            8'h23: mvr_nxt = 1;
            8'h1C: mvl_nxt = 1;
        endcase
    end
    else if(ctr >= 10_000) begin
        ctr_nxt = ctr;
        case (keycode[7:0])
            8'h1D: mvu_nxt = 0;
            8'h1B: mvd_nxt = 0;
            8'h23: mvr_nxt = 0;
            8'h1C: mvl_nxt = 0;
        endcase
    end
    else begin
        ctr_nxt = ctr + 1;
    end
end

endmodule