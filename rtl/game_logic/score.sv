module score (
    input wire clk,
    input wire rst,
    input logic [3:0] points,
    output logic player1_won
);

logic player1_won_nxt;

always_ff @(posedge clk) begin
    if (rst) 
        player1_won <= 0;
    else 
        player1_won <= player1_won_nxt;
end

always_comb begin 
    if (points == 5)
        player1_won_nxt = 1;
    else
        player1_won_nxt = 0;
end

endmodule