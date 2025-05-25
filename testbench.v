`timescale 1ns / 1ps

module _alb_tb;

    wire [7:0] R;
    wire [7:0] S;
    wire       CI;
    wire [1:0] ALB_MI;

    wire [7:0] F;
    wire       CO, ZO, NO, VO;

    reg clk = 0;
    reg resetb = 0;

    always #5 clk = ~clk;

    initial begin
        resetb = 0;
        #15 resetb = 1;
    end

    ALB dut (
        .clk(clk),
        .resetb(resetb),
        .R_in(R),
        .S_in(S),
        .CI_in(CI),
        .ALB_MI(ALB_MI),
        .F(F),
        .CO(CO),
        .ZO(ZO),
        .NO(NO),
        .VO(VO)
    );

  
    stimulus stim (
        .R(R),
        .S(S),
        .CI(CI),
        .ALB_MI(ALB_MI),
        .clk(clk),
        .resetb(resetb)
    );

    function [7:0] reference_model;
        input [7:0] R, S;
        input       CI;
        input [1:0] ALB_MI;
        reg [8:0] temp;
        begin
            case (ALB_MI)
                2'b00: temp = R - S - 1 + CI;       
                2'b01: reference_model = R & S;    
                2'b10: temp = R + S + CI;          
                2'b11: reference_model = R | S;     
                default: reference_model = 8'b0;
            endcase
            if (ALB_MI == 2'b00 || ALB_MI == 2'b10)
                reference_model = temp[7:0];
        end
    endfunction


    always @(posedge clk) begin
        if (resetb) begin
            if (F !== reference_model(R, S, CI, ALB_MI)) begin
                $display("? Mismatch at time %t: ALB_MI=%b R=%h S=%h CI=%b | F_hw=%h != F_ref=%h",
                    $time, ALB_MI, R, S, CI, F, reference_model(R, S, CI, ALB_MI));
            end else begin
                $display("? Match at time %t: ALB_MI=%b R=%h S=%h CI=%b | F=%h",
                    $time, ALB_MI, R, S, CI, F);
            end
        end
    end

    initial begin
        $dumpfile("_alb_tb.vcd");
        $dumpvars(0, _alb_tb);
    end

    initial begin

    end

endmodule
