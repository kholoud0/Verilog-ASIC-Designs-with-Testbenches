module parit_calc(
  input [7:0] P_DATA,
  input       DATA_VALID,
  input       PAR_TYP,
  input       CLK,
  output  reg par_bit
);


always@(posedge CLK)
begin
  if (!DATA_VALID)
     par_bit <= par_bit;
  else
    if (PAR_TYP)
      par_bit <= ~(^P_DATA);
    else
       par_bit <= (^P_DATA);
end
endmodule  
