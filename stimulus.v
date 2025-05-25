module stimulus (
    output reg [7:0] R,
    output reg [7:0] S,
    output reg       CI,
    output reg [1:0] ALB_MI,
    input            clk,
    input            resetb
);

  
    reg [3:0] counter = 0;

    always @(posedge clk or negedge resetb) begin
        if (!resetb) begin
            counter <= 0;
            R <= 8'b0;
            S <= 8'b0;
            CI <= 0;
            ALB_MI <= 2'b00;
        end else begin
            counter <= counter + 1;

            
            case (counter)
                4'd0: begin R <= 8'h55; S <= 8'h33; CI <= 1'b1; ALB_MI <= 2'b00; end
                4'd1: begin R <= 8'hAA; S <= 8'h0F; CI <= 1'b0; ALB_MI <= 2'b01; end
                4'd2: begin R <= 8'h0F; S <= 8'hF0; CI <= 1'b1; ALB_MI <= 2'b10; end
                4'd3: begin R <= 8'hFF; S <= 8'h00; CI <= 1'b0; ALB_MI <= 2'b11; end
                4'd4: begin R <= 8'h0A; S <= 8'h05; CI <= 1'b1; ALB_MI <= 2'b00; end
                4'd5: begin R <= 8'hF0; S <= 8'h0F; CI <= 1'b0; ALB_MI <= 2'b01; end
                4'd6: begin R <= 8'h3C; S <= 8'hC3; CI <= 1'b1; ALB_MI <= 2'b10; end
                4'd7: begin R <= 8'hAA; S <= 8'h55; CI <= 1'b0; ALB_MI <= 2'b11; end
                default: begin
                   
                    R <= 8'b0; S <= 8'b0; CI <= 0; ALB_MI <= 2'b00;
                end
            endcase
        end
    end

endmodule
