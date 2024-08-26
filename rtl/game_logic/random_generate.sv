module random_generate (
    input  logic clk,
    input  logic rst,
    vga_if.in vga_inbg,
    vga_if.out vga_outbg
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
            vga_outbg.vcount <= '0;
            vga_outbg.vsync  <= '0;
            vga_outbg.vblnk  <= '0;
            vga_outbg.hcount <= '0;
            vga_outbg.hsync  <= '0;
            vga_outbg.hblnk  <= '0;
            vga_outbg.rgb    <= COLOR_BG;
        end else begin
            vga_outbg.vcount <= vga_inbg.vcount;
            vga_outbg.vsync  <= vga_inbg.vsync;
            vga_outbg.vblnk  <= vga_inbg.vblnk;
            vga_outbg.hcount <= vga_inbg.hcount;
            vga_outbg.hsync  <= vga_inbg.hsync;
            vga_outbg.hblnk  <= vga_inbg.hblnk;
            vga_outbg.rgb    <= rgb_nxt;
        end
    end

    always_comb begin : bg_comb_blk
        if (vga_inbg.vblnk || vga_inbg.hblnk) begin
            rgb_nxt = COLOR_BG;
        end else begin
            rgb_nxt = COLOR_BG; // Domyślnie kolor tła
            rgb_nxt = COLOR_BG; // Początkowo ustaw kolor tła
            for (int i = 0; i < CELLS_X*CELLS_Y; i = i + 1) begin
                // Sprawdzamy, czy aktualny piksel należy do kwadratu
                if ((vga_inbg.hcount >= square_positions_x[i] &&
                     vga_inbg.hcount < square_positions_x[i] + CELL_SIZE) &&
                    (vga_inbg.vcount >= square_positions_y[i] &&
                     vga_inbg.vcount < square_positions_y[i] + CELL_SIZE)) begin
                    rgb_nxt = COLOR_SQUARE;
                end
            end
        end
    end
endmodule
