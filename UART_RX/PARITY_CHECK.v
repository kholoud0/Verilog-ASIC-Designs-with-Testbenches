module PARITY_CHECK(
    input       CLK,
    input       RST,
    input       par_chk_en,
    input       PAR_TYP,
    input       sampled_bit,
    input   [7:0]   P_DATA,
    output  reg     par_err
);
wire Calculated_PArity;
assign Calculated_PArity = PAR_TYP? ~^P_DATA :^P_DATA;

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        par_err <= 1'b0;

    end
    else if (par_chk_en) begin
        if (Calculated_PArity == sampled_bit) begin
            par_err <= 1'b0;
        end
        else begin
            par_err <= 1'b1;
        end
    end
    else begin
      par_err <= 1'b0;
    end
end

endmodule
