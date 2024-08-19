module SHIFT_UNIT #(parameter WIDTH = 16)(
  input wire  signed  [WIDTH-1:0]   A,B,
  input wire                        Shift_enable,
  input wire                        clk,rst,
  input wire          [1:0]         ALU_FUN,
  output  reg signed  [2*WIDTH:0]   Shift_out,
  output  reg                       Shift_Flag
);
  
reg  signed  [WIDTH-1:0] Shift_comb;  
reg                    Flag_comb;
   
always @(posedge clk or negedge rst) begin
  if(!rst) 
    begin
      Shift_out <= 1'b0;
      Shift_Flag <= 'b0;
    end
  else
    begin
      Shift_out <= Shift_comb;
      Shift_Flag <= Flag_comb;
    end
end

always @(*)
begin
  if(Shift_enable)
    begin
      Flag_comb = 1'b1;
      case(ALU_FUN)
        2'b00: Shift_comb = A >> 1;
        2'b01: Shift_comb = A << 1;
        2'b10: Shift_comb = B >> 1;
        2'b11: Shift_comb = B << 1;
      endcase
    end
  else
    begin
      Shift_comb = 'b0;
      Flag_comb = 1'b0;
  end
end
endmodule