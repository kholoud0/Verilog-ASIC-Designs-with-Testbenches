module LOGIC_UNIT #(parameter WIDTH = 16) (
  input wire  [WIDTH-1:0] A,B,
  input wire              clk,rst,
  input wire              Logic_Enable,
  input wire  [1:0]        ALU_FUN,
  output reg  [WIDTH-1:0]  Logic_Out,
  output  reg              Logic_Flag
);

reg [WIDTH-1:0] LOGIC_comb;
reg             Flag_comb;
always @(posedge clk or negedge rst) begin
  if(!rst) 
    begin
      Logic_Out <= 'b0;
      Logic_Flag <= 1'b0;
    end
  else
    begin
      Logic_Out <= LOGIC_comb;
      Logic_Flag <= Flag_comb;
    end
end
 


always @(*)
begin
  if(Logic_Enable)
    begin
      Flag_comb = 1'b1;
      case(ALU_FUN)
        2'b00: LOGIC_comb = A & B;
        2'b01: LOGIC_comb = A| B;
        2'b10: LOGIC_comb = ~(A & B);
        2'b11: LOGIC_comb = ~(A | B);
      endcase
    end
  else
    begin
      LOGIC_comb = 'b0;
      Flag_comb = 1'b0;
      
    end
end
  
endmodule
