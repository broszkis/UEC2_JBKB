module lsfr (
    input logic clk,
    input logic rst,
    input logic [9:0] player_xpos,  // Current X position of the player
    input logic [8:0] player_ypos,  // Current Y position of the player
    output logic [9:0] target_xpos, // Target X position
    output logic [8:0] target_ypos  // Target Y position
);

    logic [9:0] random_xpos_nxt;
    logic [8:0] random_ypos_nxt;

    logic [9:0] stored_xpos;
    logic [8:0] stored_ypos;

    logic reached_target;

    // LFSR for random number generation (16-bit)
    logic [15:0] lfsr;
    logic [15:0] lfsr_next;
    logic feedback;

    // Polynome: x^16 + x^14 + x^13 + x^11 + 1
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            lfsr <= 16'hACE1;  // Można zmienić na dowolną wartość początkową (tzw. seed)
            stored_xpos <= 0;
            stored_ypos <= 0;
        end else begin
            lfsr <= lfsr_next;

            if (reached_target) begin
                stored_xpos <= random_xpos_nxt;
                stored_ypos <= random_ypos_nxt;
            end
        end
    end

    always_comb begin
        feedback = lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10];
        lfsr_next = {lfsr[14:0], feedback};

        // Generate potential random positions
        random_xpos_nxt = lfsr[9:0] % 1024;  // Map to 0-1023 range (X position)
        random_ypos_nxt = lfsr[8:0] % 768;   // Map to 0-767 range (Y position)

        // Check if the random position is within any obstacle
        if ((random_xpos_nxt >= TERRAIN_LTX1 && random_xpos_nxt < TERRAIN_LTX2 && random_ypos_nxt >= TERRAIN_LTY1 && random_ypos_nxt < TERRAIN_LTY2) ||
            (random_xpos_nxt >= TERRAIN_RTX1 && random_xpos_nxt < TERRAIN_RTX2 && random_ypos_nxt >= TERRAIN_RTY1 && random_ypos_nxt < TERRAIN_RTY2) ||
            (random_xpos_nxt >= TERRAIN_LBX1 && random_xpos_nxt < TERRAIN_LBX2 && random_ypos_nxt >= TERRAIN_LBY1 && random_ypos_nxt < TERRAIN_LBY2) ||
            (random_xpos_nxt >= TERRAIN_RBX1 && random_xpos_nxt < TERRAIN_RBX2 && random_ypos_nxt >= TERRAIN_RBY1 && random_ypos_nxt < TERRAIN_RBY2) ||
            (random_xpos_nxt >= TERRAIN_MTTX1 && random_xpos_nxt < TERRAIN_MTTX2 && random_ypos_nxt >= TERRAIN_MTTY1 && random_ypos_nxt < TERRAIN_MTTY2) ||
            (random_xpos_nxt >= TERRAIN_MTSX1 && random_xpos_nxt < TERRAIN_MTSX2 && random_ypos_nxt >= TERRAIN_MTSY1 && random_ypos_nxt < TERRAIN_MTSY2) ||
            (random_xpos_nxt >= TERRAIN_MBTX1 && random_xpos_nxt < TERRAIN_MBTX2 && random_ypos_nxt >= TERRAIN_MBTY1 && random_ypos_nxt < TERRAIN_MBTY2) ||
            (random_xpos_nxt >= TERRAIN_MBSX1 && random_xpos_nxt < TERRAIN_MBSX2 && random_ypos_nxt >= TERRAIN_MBSY1 && random_ypos_nxt < TERRAIN_MBSY2) ||
            (random_xpos_nxt >= TERRAIN_MMX1 && random_xpos_nxt < TERRAIN_MMX2 && random_ypos_nxt >= TERRAIN_MMY1 && random_ypos_nxt < TERRAIN_MMY2) ||
            (random_xpos_nxt >= TERRAIN_MLX1 && random_xpos_nxt < TERRAIN_MLX2 && random_ypos_nxt >= TERRAIN_MLY1 && random_ypos_nxt < TERRAIN_MLY2) ||
            (random_xpos_nxt >= TERRAIN_MRX1 && random_xpos_nxt < TERRAIN_MRX2 && random_ypos_nxt >= TERRAIN_MRY1 && random_ypos_nxt < TERRAIN_MRY2)) begin
            // Invalid position, keep old position
            random_xpos_nxt = stored_xpos;
            random_ypos_nxt = stored_ypos;
        end
    end

    always_comb begin
        // Check if the player reached the target
        reached_target = (player_xpos == stored_xpos) && (player_ypos == stored_ypos);

        if (!reached_target) begin
            target_xpos = stored_xpos;
            target_ypos = stored_ypos;
        end else begin
            target_xpos = random_xpos_nxt;
            target_ypos = random_ypos_nxt;
        end
    end

endmodule
