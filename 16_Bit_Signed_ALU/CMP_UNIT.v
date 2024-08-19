
module CMP_UNIT #(parameter WIDTH = 16) (
  input wire  [WIDTH-1:0] A,B,
  input wire              clk,rst,
  input wire              CMP_Enable,
  input wire  [1:0]        ALU_FUN,
  output reg  [WIDTH-1:0]  CMP_Out,
  output  reg              CMP_Flag
);

reg [WIDTH-1:0] CMP_comb;
reg             Flag_comb;
always @(posedge clk or negedge rst) begin
  if(!rst) 
    begin
      CMP_Out <= 'b0;
      CMP_Flag <= 1'b0;
    end
  else
    begin
      CMP_Out <= CMP_comb;
      CMP_Flag <= Flag_comb;
    end
end
 


always @(*)
begin
  if(CMP_Enable)
    begin
      Flag_comb = 1'b1;
      case(ALU_FUN)
        2'b00: CMP_comb = 0;
        2'b01: CMP_comb = (A==B)?1:0;
        2'b10: CMP_comb = (A > B)?2:0;
        2'b11: CMP_comb = (A < B)?3:0;
      endcase
    end
  else
    begin
      CMP_comb = 'b0;
      Flag_comb = 1'b0;
      
    end
end
  
endmodule

