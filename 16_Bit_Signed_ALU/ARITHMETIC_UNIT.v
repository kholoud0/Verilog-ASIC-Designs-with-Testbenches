module ARITHMETIC_UNIT #(parameter WIDTH = 16)(
  input wire  signed  [WIDTH-1:0]   A,B,
  input wire                        Arith_enable,
  input wire                        clk,rst,
  input wire          [1:0]         ALU_FUN,
  output  reg signed  [2*WIDTH:0]   Arith_out,
  output  reg                       Arith_Flag
);
  
reg  signed  [2*WIDTH:0] Arith_comb;  
reg                    Flag_comb;
   
always @(posedge clk or negedge rst) begin
  if(!rst) 
    begin
      Arith_Flag <= 1'b0;
      Arith_out <= 'b0;
    end
  else
    begin
      Arith_out <= Arith_comb;
      Arith_Flag <= Flag_comb;
    end
end

always @(*)
begin
  if(Arith_enable)
    begin
      Flag_comb = 1'b1;
      case(ALU_FUN)
        2'b00: Arith_comb = A + B;
        2'b01: Arith_comb = A - B;
        2'b10: Arith_comb = A * B;
        2'b11: Arith_comb = A / B;
      endcase
    end
  else
    begin
      Arith_comb = 'b0;
      Flag_comb = 1'b0;
  end
end
endmodule