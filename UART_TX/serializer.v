module serializer(
  
  input [7:0] P_DATA,
  input       ser_en,
  input       Data_Valid,
  input       CLK,
  input       RST,
  output reg  ser_data,
  output  reg ser_done
);

reg [3:0] Counter;
reg [7:0] Reg_Data;
always@(posedge CLK)
begin
  if(!ser_en)
  begin
    ser_data <= 1;
    Counter <= 0;
    ser_done <= 0;
    
  end
  else
    if(Counter<=4'b0111)
    begin
      ser_data<= Reg_Data[Counter];
      Counter <= Counter+1;
      if(Counter == 4'b0111)
	ser_done <= 1;
      else
      	ser_done <= 0;
     end
        else    
    begin
      Counter <= 0;
      ser_data <= 1;
      ser_done <= 0;
  end
end

always@(posedge CLK or negedge RST)
begin
  if(!RST)
    Reg_Data<= 8'b11111111;
  else if(Data_Valid)
    Reg_Data <= P_DATA;
     
end
  
endmodule