module REG_TB();
  
reg   [15:0]   WrData_tb;
reg   [2:0]    Address_tb;
reg            WrEn_tb;
reg            RdEn_tb;
reg            CLK_tb,RST_tb;
wire  [15:0]   RdData_tb;


always #5 CLK_tb = ~CLK_tb;

REG_8_16 REG_DUT(
  .WrData(WrData_tb),
  .Address(Address_tb),
  .WrEn(WrEn_tb),
  .RdEn(RdEn_tb),
  .CLK(CLK_tb),
  .RST(RST_tb),
  .RdData(RdData_tb)
);

initial begin
  CLK_tb = 0;
  WrEn_tb = 0;
  RdEn_tb = 0;
  RST_tb = 0;
  #13
  $display("TESTCASE WRITE 1 on reg 3");
  WrData_tb = 16'b01011;
  WrEn_tb = 1;
  RST_tb = 1;
  Address_tb = 3'b011;
  #7
  if(REG_DUT.REGISTER[Address_tb] == 16'b01011)
    $display("test passed");
  else
    $display("TEST FAILED");
    
  #3
  $display("TEST CASE READ 1 from REG 3");
  WrEn_tb=0;
  RdEn_tb =1;
  #7
  if(RdData_tb ==   16'b01011)
    $display("test passed");
  else
    $display("TEST FAILED");
    
  #13
  $display("TESTCASE WRITE 2 on reg 7");
  WrData_tb = 16'b1111111111111111;
  WrEn_tb = 1;
  RST_tb = 1;
  RdEn_tb = 0;
  Address_tb = 3'b111;
  #7
  if(REG_DUT.REGISTER[Address_tb] == 16'b1111111111111111)
    $display("test passed");
  else
    $display("TEST FAILED");
    
  #3
  $display("TEST CASE READ 2 from REG 4");
  WrEn_tb=0;
  RdEn_tb =1;
  #7
  if(RdData_tb ==   16'b1111111111111111)
    $display("test passed");
  else
    $display("TEST FAILED");
    #20
    $stop;
    
    
  
  
end

endmodule