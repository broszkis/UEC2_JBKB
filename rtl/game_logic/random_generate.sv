module random_generate(
    input logic clk,
    input logic rst,
    output logic [14:0][31:0] position_x,
    output logic [14:0][31:0] position_y
);

localparam int CLK_FREQ = 65000000;
logic [31:0] cycle_counter;
logic generate_point;

always_ff@(posedge clk) begin
    if(rst) begin 
        cycle_counter <= '0;
        generate_point <= '0;
    end else begin
        if (cycle_counter >= CLK_FREQ) begin
            cycle_counter <= '0;
            generate_point <= 1;
        end else begin
            cycle_counter <= cycle_counter + 1;
            generate_point <= '0;
        end
    end
end

always_ff@(posedge clk) begin
    if(rst) begin
        for (int i=0;i<15;i++) begin
            position_x[i]<='0;
            position_y[i]<='0;
        end
    end else begin
        for (int i=0;i<15;i++) begin
            position_x[i]<= $urandom_range(5, 1024 - 10);
            position_y[i]<= $urandom_range(5, 768 - 10);
        end
    end
end
endmodule