module REG_8_16(
  input wire  [15:0] WrData,
  input wire  [2:0]  Address,
  input              WrEn,
  input              RdEn,
  input              CLK,
  input              RST,
  output  reg [15:0] RdData
);

reg [15:0]  REGISTER [0:7];

always @(posedge CLK or negedge RST) begin
  if(!RST) begin
   // Clear all registers on asynchronous Active Low reset 
    RdData <= 16'b0;
    REGISTER[0] <= 16'b0;
    REGISTER[1] <= 16'b0;
    REGISTER[2] <= 16'b0;
    REGISTER[3] <= 16'b0;
    REGISTER[4] <= 16'b0;
    REGISTER[5] <= 16'b0;
    REGISTER[6] <= 16'b0;
    REGISTER[7] <= 16'b0;
end
else begin
  if(WrEn & !RdEn) 
    REGISTER[Address] <= WrData; // Write data to register
  else if(RdEn & ! WrEn) 
    RdData <= REGISTER[Address]; // Read data from register
end

end
endmodule