module spawn (
    input logic clk,
    input logic rst,
    input logic rx,
    output logic rectangle
);

logic rectangle_nxt;

always_ff@ (posedge clk) begin 
    if (rst) begin 
        rectangle <= '0;
    end
    else begin 
        rectangle <= rectangle_nxt;
    end
end

always_comb begin 
    if (rx == 97) begin
        rectangle_nxt = 1;
end
else begin
    rectangle_nxt = 0;
    end
end
endmodule