module screen_selector(
    input logic clk, rst, start, stop, first, second
);

enum logic [1:0] {START, GAME, PLAYER_1, PLAYER_2} state;

always_ff@(posedge clk) begin
    if(rst) begin
        state <= START;
    end else
        case (state)
            START: state <= start ? GAME : START;
            GAME : state <= first ? PLAYER_1 : GAME;
            GAME : state <= second ? PLAYER_2 : GAME;
            PLAYER_1 : state <= stop ? GAME : PLAYER_1;
            PLAYER_2 : state <= stop ? GAME : PLAYER_2; 
        endcase 
end

endmodule