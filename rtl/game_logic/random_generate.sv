module random_generate (
    input  logic clk,
    input  logic rst,
    vga_if.in bg_in,
    vga_if.out bg_out
);
    import vga_pkg::*;

    // Rozmiar mapy i komórek
    localparam CELL_SIZE  = 32;
    localparam CELLS_X    = 32;
    localparam CELLS_Y    = 24;

    // Kolory
    localparam COLOR_SQUARE = 12'h0_f_f; // Kolor kwadratu
    localparam COLOR_BG     = 12'h0_0_0; // Kolor tła (czarny)

    // Tablice dla pozycji kwadratów
    logic [11:0] square_positions_x[0:CELLS_X-1];
    logic [11:0] square_positions_y[0:CELLS_Y-1];

    // Kolor wyjściowy
    logic [11:0] rgb_nxt;

    // Inicjalizacja pozycji kwadratów
    initial begin
        integer i, j;
        for (i = 0; i < CELLS_X; i = i + 1) begin
            for (j = 0; j < CELLS_Y; j = j + 1) begin
                square_positions_x[i*CELLS_Y + j] = i * CELL_SIZE;
                square_positions_y[i*CELLS_Y + j] = j * CELL_SIZE;
            end
        end
    end

    always_ff @(posedge clk) begin : bg_ff_blk
        if (rst) begin
            bg_out.vcount <= '0;
            bg_out.vsync  <= '0;
            bg_out.vblnk  <= '0;
            bg_out.hcount <= '0;
            bg_out.hsync  <= '0;
            bg_out.hblnk  <= '0;
            bg_out.rgb    <= COLOR_BG;
        end else begin
            bg_out.vcount <= bg_in.vcount;
            bg_out.vsync  <= bg_in.vsync;
            bg_out.vblnk  <= bg_in.vblnk;
            bg_out.hcount <= bg_in.hcount;
            bg_out.hsync  <= bg_in.hsync;
            bg_out.hblnk  <= bg_in.hblnk;
            bg_out.rgb    <= rgb_nxt;
        end
    end

    always_comb begin : bg_comb_blk
        if (bg_in.vblnk || bg_in.hblnk) begin
            rgb_nxt = COLOR_BG;
        end else begin
            rgb_nxt = COLOR_BG; // Domyślnie kolor tła
            rgb_nxt = COLOR_BG; // Początkowo ustaw kolor tła
            for (int i = 0; i < CELLS_X*CELLS_Y; i = i + 1) begin
                // Sprawdzamy, czy aktualny piksel należy do kwadratu
                if ((bg_in.hcount >= square_positions_x[i] &&
                     bg_in.hcount < square_positions_x[i] + CELL_SIZE) &&
                    (bg_in.vcount >= square_positions_y[i] &&
                     bg_in.vcount < square_positions_y[i] + CELL_SIZE)) begin
                    rgb_nxt = COLOR_SQUARE;
                end
            end
        end
    end
endmodule
