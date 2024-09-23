module STRT_CHECK(
    input       CLK,
    input       RST,
    input       strt_chk_en,
    input       sampled_bit,
    output  reg     strt_glitch
);
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        strt_glitch <= 1'b0;
    end
    else if(strt_chk_en) begin
      if(sampled_bit == 1'b0) begin
        strt_glitch <= 1'b0;
      end
      else begin
        strt_glitch <= 1'b1;
      end
    end
    else begin
      strt_glitch <= 1'b0;
    end
    
end


endmodule


