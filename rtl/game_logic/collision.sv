/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Ksawery Broszkiewicz, Jan Bartnik
 *
 * Description:
 * 
 */
module collision 
#(  parameter
    SIZE = 16
)
(
    input logic [9:0] xpos, ypos,
    output logic collision_up, collision_down, collision_right, collision_left
);

import vga_pkg::*;

logic [9:0] terrain_xpos1[11] = {  TERRAIN_LTX1, TERRAIN_RTX1, TERRAIN_LBX1, TERRAIN_RBX1, 
                                    TERRAIN_MTTX1, TERRAIN_MTSX1, TERRAIN_MBTX1, TERRAIN_MBSX1,
                                    TERRAIN_MMX1, TERRAIN_MLX1, TERRAIN_MRX1};

logic [9:0] terrain_xpos2[11] = {  TERRAIN_LTX2, TERRAIN_RTX2, TERRAIN_LBX2, TERRAIN_RBX2, 
                                    TERRAIN_MTTX2, TERRAIN_MTSX2, TERRAIN_MBTX2, TERRAIN_MBSX2,
                                    TERRAIN_MMX2, TERRAIN_MLX2, TERRAIN_MRX2};

logic [9:0] terrain_ypos1[11] = {  TERRAIN_LTY1, TERRAIN_RTY1, TERRAIN_LBY1, TERRAIN_RBY1, 
                                    TERRAIN_MTTY1, TERRAIN_MTSY1, TERRAIN_MBTY1, TERRAIN_MBSY1,
                                    TERRAIN_MMY1, TERRAIN_MLY1, TERRAIN_MRY1};

logic [9:0] terrain_ypos2[11] = {  TERRAIN_LTY2, TERRAIN_RTY2, TERRAIN_LBY2, TERRAIN_RBY2, 
                                    TERRAIN_MTTY2, TERRAIN_MTSY2, TERRAIN_MBTY2, TERRAIN_MBSY2,
                                    TERRAIN_MMY2, TERRAIN_MLY2, TERRAIN_MRY2};                                    

integer i;

logic collision_up_tmp, collision_down_tmp, collision_right_tmp, collision_left_tmp;

always_comb begin

    collision_up = 0;
    collision_down = 0;
    collision_right = 0;
    collision_left = 0;

    for (i = 0; i < TERRAIN_NUM; i++) begin
        collision_up_tmp = ((xpos + SIZE > terrain_xpos1[i]) && 
                            (xpos - SIZE < terrain_xpos2[i]) && 
                            (ypos - SIZE < terrain_ypos2[i]) && 
                            (ypos - SIZE > terrain_ypos1[i]));

        collision_down_tmp = ((xpos + SIZE > terrain_xpos1[i]) && 
                              (xpos - SIZE < terrain_xpos2[i]) && 
                              (ypos + SIZE > terrain_ypos1[i]) && 
                              (ypos + SIZE < terrain_ypos2[i]));

        collision_right_tmp = ((xpos + SIZE > terrain_xpos1[i]) && 
                               (xpos + SIZE < terrain_xpos2[i]) && 
                               (ypos + SIZE > terrain_ypos1[i]) && 
                               (ypos - SIZE < terrain_ypos2[i]));

        collision_left_tmp = ((xpos - SIZE < terrain_xpos2[i]) && 
                              (xpos - SIZE > terrain_xpos1[i]) && 
                              (ypos + SIZE > terrain_ypos1[i]) && 
                              (ypos - SIZE < terrain_ypos2[i]));

        collision_up = collision_up || collision_up_tmp;
        collision_down = collision_down || collision_down_tmp;
        collision_right = collision_right || collision_right_tmp;
        collision_left = collision_left || collision_left_tmp;
    end
end


endmodule
