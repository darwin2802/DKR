module checker_ALB(
    input [7:0] F_hw,
    input [7:0] F_ref,
    input       clk
);

    always @(posedge clk) begin
        if (F_hw !== F_ref)
            $display("%0dns ? ERROR: F = %b, expected = %b", $time, F_hw, F_ref);
        else
            $display("%0dns ? OK", $time);
    end

endmodule
