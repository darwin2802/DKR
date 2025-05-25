`timescale 1ns / 1ps

module top;

    reg [7:0] R;
    reg [7:0] S;
    reg       CI;
    reg [1:0] ALB_MI;
    wire [7:0] F_hw;
    wire       CO, ZO, NO, VO;
    wire [7:0] F_ref;

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
        .F(F_hw),
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
                2'b00: temp = {1'b0,R} + {1'b0,~S} + CI; 
                2'b01: reference_model = R & S;
                2'b10: temp = {1'b0,R} + {1'b0,S} + CI;  
                2'b11: reference_model = R | S;
                default: reference_model = 8'b0;
            endcase

            if (ALB_MI == 2'b00 || ALB_MI == 2'b10)
                reference_model = temp[7:0];
        end
    endfunction

    assign F_ref = reference_model(R, S, CI, ALB_MI);

    checker_ALB checker (
        .F_hw(F_hw),
        .F_ref(F_ref),
        .clk(clk)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top);
    end

endmodule
