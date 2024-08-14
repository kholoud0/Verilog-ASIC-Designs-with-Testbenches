`timescale 1ns/1ps
module ALU_tb();

reg [15:0]    A_tb, B_tb;
reg [3:0]    ALU_FUN_tb;
reg          clk_tb;
wire [15:0]  ALU_OUT_tb;
wire         Arith_Flag_tb;
wire         Carry_Flag_tb;
wire         Logic_Flag_tb;
wire         CMP_Flag_tb;
wire         Shift_Flag_tb;
reg          x;
always #5 clk_tb = ~clk_tb;

ALU DUT (
  .A(A_tb),
  .B(B_tb),
	.ALU_FUN(ALU_FUN_tb),
	.clk(clk_tb),
	.ALU_OUT(ALU_OUT_tb),
	.Arith_Flag(Arith_Flag_tb), 
	.Carry_Flag(Carry_Flag_tb), 
	.Logic_Flag(Logic_Flag_tb),
	.CMP_Flag(CMP_Flag_tb),
	.Shift_Flag(Shift_Flag_tb)
);

initial begin
  $dumpfile("alu_waveform.vcd");  // Specify the VCD file name
  $dumpvars(0, ALU_tb);            // Dump all variables in the scope of ALU_tb
  
  A_tb = 16'b00;
  B_tb = 16'b00 ;
  ALU_FUN_tb = 4'b0000;
  clk_tb = 1'b0;
  
  #3
  $display(" TEST CASE 1 Addition");
  A_tb = 16'b101;
  B_tb = 16'b110;
  #7
  if(({Carry_Flag_tb , ALU_OUT_tb} == A_tb + B_tb) && (Arith_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
  
  #3
  $display(" TEST CASE 2 Subtraction");
  ALU_FUN_tb = 4'b0001;
  #7
  if( (ALU_OUT_tb == A_tb - B_tb)&&(Carry_Flag_tb == (A_tb <B_tb)?1:0)&& (Arith_Flag_tb==1 ))
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
    
  #3
  $display(" TEST CASE 3 Multiplcation");
  ALU_FUN_tb = 4'b0010;
  #7
  if( (ALU_OUT_tb == A_tb * B_tb)&& (Arith_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
   
  #3  
  $display(" TEST CASE 4 Division");
  ALU_FUN_tb = 4'b0011;
  #7
  if((ALU_OUT_tb== A_tb / B_tb) && (Arith_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
    
  #3
  $display(" TEST CASE 5 AND");
  ALU_FUN_tb = 4'b0100;
  #7
  if(( ALU_OUT_tb == (A_tb & B_tb))&& (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
  
  #3
  $display(" TEST CASE 6 OR");
  ALU_FUN_tb = 4'b0101;
  #7
  if((ALU_OUT_tb == A_tb | B_tb) && (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
  
  #3
  $display(" TEST CASE 7 NAND");
  ALU_FUN_tb = 4'b0110;
  #7
  if(( ALU_OUT_tb == ~(A_tb & B_tb)) && (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
  #3
  $display(" TEST CASE 8 NOR");
  ALU_FUN_tb = 4'b0111;
  #7
  if( (ALU_OUT_tb == ~(A_tb|B_tb))&& (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
  
  #3
  $display(" TEST CASE 9 XOR");
  ALU_FUN_tb = 4'b1000;
  #7
  if((ALU_OUT_tb == A_tb ^ B_tb)&& (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
    
  #3
  $display(" TEST CASE 10 XNOR");
  ALU_FUN_tb = 4'b1001;
  #7
  if( (ALU_OUT_tb == ~(A_tb^B_tb)) && (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
    
  #3
  $display(" TEST CASE 11 A = B");
  ALU_FUN_tb = 4'b1010;
  #7
  if(( ALU_OUT_tb == (A_tb==B_tb) ) && (CMP_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  #3
  $display(" TEST CASE 12 A > B");
  ALU_FUN_tb = 4'b1011;
  #7
  if(( ALU_OUT_tb == ((A_tb>B_tb)?2:0) ) && (CMP_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
     
  #3
  $display(" TEST CASE 13 A < B");
  ALU_FUN_tb = 4'b1100;
  #7
 
  if( (ALU_OUT_tb == ((A_tb < B_tb)?16'b11:16'b0) ) && (CMP_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
  
  #3
  $display(" TEST CASE 14 A >> 1");
  ALU_FUN_tb = 4'b1101;
  #7
  if( (ALU_OUT_tb == (A_tb >> 1) ) && (Shift_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
    
   #3
  $display(" TEST CASE 15 A << 1");
  ALU_FUN_tb = 4'b1110;
  #7
  if( (ALU_OUT_tb == (A_tb << 1) ) && (Shift_Flag_tb==1 ) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
   #3
  $display(" TEST CASE 16 NOP");
  ALU_FUN_tb = 4'b1111;
  #7
  if( ALU_OUT_tb == 16'b0 ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
  #20
   $stop;
  
end

  
endmodule