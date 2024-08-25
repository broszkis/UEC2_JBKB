module collision (
    input logic [10:0] xpos, ypos,
    output logic collision_up, collision_down, collision_right, collision_left
);

import vga_pkg::*;

always_comb begin
    collision_up = ((xpos + PLAYER_SIZE > 200) && 
                    (xpos - PLAYER_SIZE < 230) && 
                    (ypos - PLAYER_SIZE <= 230) && 
                    (ypos - PLAYER_SIZE > 200));


    collision_down = ((xpos + PLAYER_SIZE > 200) && 
                      (xpos - PLAYER_SIZE < 230) && 
                      (ypos + PLAYER_SIZE >= 200) && 
                      (ypos + PLAYER_SIZE < 230));

    collision_right = ((xpos + PLAYER_SIZE >= 200) && 
                       (xpos + PLAYER_SIZE < 230) && 
                       (ypos + PLAYER_SIZE > 200) && 
                       (ypos - PLAYER_SIZE < 230));

    collision_left = ((xpos - PLAYER_SIZE <= 230) && 
                      (xpos - PLAYER_SIZE > 200) && 
                      (ypos + PLAYER_SIZE > 200) && 
                      (ypos - PLAYER_SIZE < 230));
end


endmodule
