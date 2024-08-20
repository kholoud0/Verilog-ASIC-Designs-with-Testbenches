`timescale 1us/1ns


module ALU_TB #(parameter OP_DATA_WIDTH_TB = 16,ARITH_OUT_WIDTH_TB = 32) ();

//ALU INPUTS  
reg signed [OP_DATA_WIDTH_TB -1:0]    A_tb, B_tb;
reg         [3:0]    ALU_FUN_tb;
reg          clk_tb;
reg          rst_tb;

//ALU OUTPUT RESULTS
wire signed [ARITH_OUT_WIDTH_TB - 1:0]  Arith_OUT_tb;
wire [15:0]  Logic_Out_tb;
wire [15:0]  CMP_Out_tb;
wire [15:0]  Shift_Out_tb;

//ALU OUTPUT FLAGS
wire         Arith_Flag_tb;
wire         Logic_Flag_tb;
wire         CMP_Flag_tb;
wire         Shift_Flag_tb;

  
//CLOK DECLERATION
always begin
  #4 clk_tb = ~clk_tb;
  #6 clk_tb = ~clk_tb;
end

//ALU INSTANTIATION
ALU_TOP ALU_DUT(
  .A(A_tb),
  .B(B_tb),
  .ALU_FUN(ALU_FUN_tb),
  .clk(clk_tb),
  .rst(rst_tb),
  .Arith_OUT(Arith_OUT_tb),
  .Logic_Out(Logic_Out_tb),
  .CMP_Out(CMP_Out_tb),
  .Shift_Out(Shift_Out_tb),
  .Arith_Flag(Arith_Flag_tb),
  .Logic_Flag(Logic_Flag_tb),
  .CMP_Flag(CMP_Flag_tb),
  .Shift_Flag(Shift_Flag_tb)
); 

initial begin
  $dumpfile("ALU_waveform.vcd");  // Specify the VCD file name
  $dumpvars(0,ALU_TB);            // Dump all variables in the scope of ALU_tb
  clk_tb = 0;
  rst_tb = 1'b0;
  
  A_tb = 'b00;
  B_tb = 'b00 ;
  ALU_FUN_tb = 4'b0000;
  clk_tb = 1'b0;
  
  
  
  
  
//LOGICAL OPERATION TESTCASES
    
  #3
  $display(" TEST CASE 1 AND");
  ALU_FUN_tb = 4'b0100;
  A_tb = 'b101;
  B_tb = 'b110;
  rst_tb = 1'b1;
  #7
  if(( Logic_Out_tb == (A_tb & B_tb))&& (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
  
  #3
  $display(" TEST CASE 2 OR");
  ALU_FUN_tb = 4'b0101;
  #7
  if((Logic_Out_tb == A_tb | B_tb) && (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
  
  #3
  $display(" TEST CASE 3 NAND");
  ALU_FUN_tb = 4'b0110;
  #7
  if(( Logic_Out_tb == ~(A_tb & B_tb)) && (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
  #3
  $display(" TEST CASE 4 NOR");
  ALU_FUN_tb = 4'b0111;
  #7
  if( (Logic_Out_tb == ~(A_tb|B_tb))&& (Logic_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
//CMP BLOCK TESTCASES
  
  #3
  $display(" TEST CASE 5 NOP");
  ALU_FUN_tb = 4'b1000;
  #7
  if((CMP_Out_tb == 'b0)&& (CMP_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
    
    
  #3
  $display(" TEST CASE 6 A = B");
  ALU_FUN_tb = 4'b1001;
  #7
  if(( CMP_Out_tb == ((A_tb==B_tb)?'b1:0) ) && (CMP_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  #3
  $display(" TEST CASE 7 A > B");
  ALU_FUN_tb = 4'b1010;
  #7
  if(( CMP_Out_tb == ((A_tb>B_tb)?2:0) ) && (CMP_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
     
  #3
  $display(" TEST CASE 8 A < B");
  ALU_FUN_tb = 4'b1011;
  #7
 
  if( (CMP_Out_tb == ((A_tb < B_tb)?'b11:'b00) ) && (CMP_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 

//SHIFT BLOCK TESTCASES  
  #3
  $display(" TEST CASE 9 A >> 1");
  ALU_FUN_tb = 4'b1100;
  #7
  if( (Shift_Out_tb == (A_tb >> 1) ) && (Shift_Flag_tb==1 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");
    
   #3
  $display(" TEST CASE 10 A << 1");
  ALU_FUN_tb = 4'b1101;
  #7
  if( (Shift_Out_tb == (A_tb << 1) ) && (Shift_Flag_tb==1 ) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
   #3
  $display(" TEST CASE 11 B >> 1");
  ALU_FUN_tb = 4'b1110;
  #7
  if( (Shift_Out_tb == (B_tb >> 1))&& (Shift_Flag_tb==1 ) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
  #3
  $display(" TEST CASE 12 B << 1");
  ALU_FUN_tb = 4'b1111;
  #7
  if( (Shift_Out_tb == (B_tb << 1))&& (Shift_Flag_tb==1 ) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  //ARITH ADDITION TESTCASES
    
  #3
  $display(" TEST CASE 13 ADDETION NEG + NEG");
  ALU_FUN_tb = 4'b0000;
  A_tb = -'d4;
  B_tb = -'d5;
  #7
  if( (Arith_OUT_tb == -'d9)&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
  
  #3
  $display(" TEST CASE 14 ADDETION POS + NEG");
  ALU_FUN_tb = 4'b0000;
  A_tb = 'd4;
  B_tb = -'d5;
  #7
  if( (Arith_OUT_tb == -'d1)&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
  #3
  $display(" TEST CASE 15 ADDETION NEG + POS");
  ALU_FUN_tb = 4'b0000;
  A_tb = -'d4;
  B_tb = 'd5;
  #7
  if( (Arith_OUT_tb == 'd1)&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED");  
    
  #3
  $display(" TEST CASE 16 ADDETION POS + POS");
  ALU_FUN_tb = 4'b0000;
  A_tb = 'd4;
  B_tb = 'd5;
  #7
  if( (Arith_OUT_tb == 'd9 )&& (Arith_Flag_tb == 1)) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  //ARITH SUBTRACTION TESTCASES
  
  #3
  $display(" TEST CASE 17 SUBTRACTION NEG + NEG");
  ALU_FUN_tb = 4'b0001;
  A_tb = -'d4;
  B_tb = -'d5;
  #7
  if( (Arith_OUT_tb == 'd1)&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  
  #3
  $display(" TEST CASE 18 SUBTRACTION POS + NEG");
  ALU_FUN_tb = 4'b0001;
  A_tb = 'd4;
  B_tb = -'d5;
  #7
  if( (Arith_OUT_tb == 'd9)&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  #3
  $display(" TEST CASE 19 SUBTRACTION NEG + POS");
  ALU_FUN_tb = 4'b0001;
  A_tb = -'d4;
  B_tb = 'd5;
  #7
  if( (Arith_OUT_tb == -'d9)&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  #3
  $display(" TEST CASE 20 SUBTRACTION POS + POS");
  ALU_FUN_tb = 4'b0001;
  A_tb = 'd4;
  B_tb = 'd5;
  #7
  if( (Arith_OUT_tb == -'d1)&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
  
    
//ARITH MULTIPLICATIN TESTCASES
  #3
  $display(" TEST CASE 21 MULTIPLICATION NEG * NEG");
  ALU_FUN_tb = 4'b0010;
  A_tb = -'d4;
  B_tb = -'d5;
  #7
  if( (Arith_OUT_tb == (A_tb * B_tb))&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
  
  #3
  $display(" TEST CASE 22 MULTIPLICATION POS * NEG");
  ALU_FUN_tb = 4'b0010;
  A_tb = 'd4;
  B_tb = -'d5;
  #7
  if( (Arith_OUT_tb == (A_tb * B_tb))&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  #3
  $display(" TEST CASE 23 MULTIPLICATION NEG * POS");
  ALU_FUN_tb = 4'b0010;
  A_tb = -'d4;
  B_tb = 'd5;
  #7
  if( (Arith_OUT_tb == (A_tb * B_tb))&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  #3
  $display(" TEST CASE 24 MULTIPLICATION POS * POS");
  ALU_FUN_tb = 4'b0010;
  A_tb = 'd4;
  B_tb = 'd5;
  #7
  if( (Arith_OUT_tb == (A_tb * B_tb))&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
    
     
//ARITH DIVISION TESTCASES
  #3
  $display(" TEST CASE 25 DIVISION NEG / NEG");
  ALU_FUN_tb = 4'b0011;
  A_tb = -'d4;
  B_tb = -'d5;
  #7
  if(( Arith_OUT_tb == (A_tb / B_tb))&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
  
  #3
  $display(" TEST CASE 26 DIVISION POS / NEG");
  ALU_FUN_tb = 4'b0011;
  A_tb = 'd4;
  B_tb = -'d5;
  #7
  if( (Arith_OUT_tb == (A_tb / B_tb))&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  #3
  $display(" TEST CASE 27 DIVISION NEG * POS");
  ALU_FUN_tb = 4'b0011;
  A_tb = -'d4;
  B_tb = 'd5;
  #7
  if(( Arith_OUT_tb == (A_tb / B_tb))&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
  #3
  $display(" TEST CASE 28 DIVISION POS / POS");
  ALU_FUN_tb = 4'b0011;
  A_tb = 'd4;
  B_tb = 'd5;
  #7
  if(( Arith_OUT_tb == (A_tb / B_tb))&& (Arith_Flag_tb == 1) ) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
#2
  $display(" TEST CASE 29 ASYNCHROUNUS RESET");
  ALU_FUN_tb = 4'b0011;
  A_tb = 'd4;
  B_tb = 'd5;
  #2
  if(( Arith_OUT_tb == 'b0)&& (Arith_Flag_tb == 0)&&(Logic_Out_tb == 'b0) && (Logic_Flag_tb==0 ) &&(CMP_Out_tb == 'b0)&& (CMP_Flag_tb==0 ) &&(Shift_Out_tb == 'b0)&& (Shift_Flag_tb==0 )) 
    $display(" TEST PASSED \n");
  else
    $display("TEST FAILED"); 
    
    

    
  
  #20
   $stop;



end  
  
  
endmodule
