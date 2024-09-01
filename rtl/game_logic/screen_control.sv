module screen_control (
    input  wire  clk,
    input  wire  rst,
    input  wire  [4:0] points,
    input  wire  [15:0] keycode,
    output logic [1:0] screen
);

enum logic [1:0] {
    START = 2'b00,
    GAME  = 2'b01,
    PLAYER_1 = 2'b11,
    PLAYER_2 = 2'b10
} state, state_nxt;

logic [1:0] screen_nxt;

always_ff @(posedge clk) begin
    if (rst) begin
        state <= START;
    end else begin
        state <= state_nxt;
    end
end
always_comb begin : state_comb_blk
    case(state)
        START: state_nxt = (keycode[15:8] != 8'hf0 && keycode[7:0] == 8'h5A) ? GAME : START;
        GAME: state_nxt = (points == 5) ? PLAYER_1 : GAME;
        PLAYER_1: state_nxt = (keycode[15:8] != 8'hf0 && keycode[7:0] == 8'h2D) ? START : PLAYER_1;
        PLAYER_2: state_nxt = (keycode[15:8] != 8'hf0 && keycode[7:0] == 8'h2D) ? START : PLAYER_1;
        default: state_nxt = START;
    endcase
end

always_ff @(posedge clk) begin
    if(rst) begin
        screen <= 2'b0;
    end
    else begin
        screen <= screen_nxt;
    end
end

always_comb begin : out_comb_blk
    case(state_nxt)
        START: screen_nxt = 2'b00;
        GAME: screen_nxt = 2'b01;
        PLAYER_1: screen_nxt = 2'b11;
        PLAYER_2: screen_nxt = 2'b10;
        default: screen_nxt = 2'b0;
    endcase
end

endmodule