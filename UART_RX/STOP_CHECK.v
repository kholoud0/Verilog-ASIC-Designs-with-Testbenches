module STOP_CHECK(
    input       CLK,
    input       RST,
    input       stp_chk_en,
    input       sampled_bit,
    output  reg     stp_err
);
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        stp_err <= 1'b0;
    end
    else if(stp_chk_en) begin
      if(sampled_bit == 1'b1) begin
        stp_err <= 1'b0;
      end
      else begin
        stp_err <= 1'b1;
      end
    end
    else begin
      stp_err <= stp_err;
    end
    
end


endmodule
