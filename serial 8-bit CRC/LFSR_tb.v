`timescale 1ns/1ps


module FSLR_tb_1();
  
//////////////////// DUT Signals ////////////////////////
  reg  Data_tb;
  reg  Active_tb;
  reg  Clk_tb;
  reg  Rst_tb;
  wire   Valid_tb;
  wire   CRC_tb;

///////////////////// Parameters ////////////////////////
parameter LFSR_WD_tb = 8 ;
parameter Clk_period = 100 ;
parameter Test_Cases = 10 ;
parameter Data_WD = 8;
///////////////// Loops Variables ///////////////////////
integer                       Operation ;



/////////////////////// Memories ////////////////////////
reg    [LFSR_WD_tb-1:0]   input_data   [Test_Cases-1:0] ;
reg    [LFSR_WD_tb-1:0]   Expec_Outs   [Test_Cases-1:0] ;



////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial 
 begin
 
 // System Functions
 $dumpfile("LFSR_DUMP.vcd") ;       
 $dumpvars; 
 
 // Read Input Files
 $readmemh("DATA_h.txt", input_data);
 $readmemh("Expec_Out_h.txt", Expec_Outs);

 // initialization
 initialize() ;
 reset();

 // Test Cases
 for (Operation=0;Operation<Test_Cases;Operation=Operation+1)
  begin
   do_oper(input_data[Operation]) ;                       // do_lfsr_operation
   check_out(Expec_Outs[Operation],Operation) ;           // check output response
  reset();
  end

 #100
 $finish ;

 end




////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////

task initialize ;
 begin
  Clk_tb  = 1'b0;
  Rst_tb  = 1'b1;
  Active_tb = 1'b0;  
  Data_tb = 1'b0;
  
 end
endtask

///////////////////////// RESET /////////////////////////

task reset ;
 begin
  Rst_tb =  1'b1;
  #(Clk_period)
  Rst_tb  = 1'b0;
  #(Clk_period)
  Rst_tb  = 1'b1;
 end
endtask

////////////////// Do LFSR Operation ////////////////////

task do_oper ;
 input  [LFSR_WD_tb-1:0]     IN_Data ;
  integer k;
 
 begin
   Active_tb = 1'b1;
   for ( k=0 ;k<8; k=k+1)
   begin
     
    Data_tb = IN_Data[k];
    #(Clk_period);
   end
   Active_tb = 1'b0;   
 end
endtask

////////////////// Check Out Response  ////////////////////

task check_out ;
 input  reg     [LFSR_WD_tb-1:0]     expec_out ;
 input  integer                      Oper_Num ; 

 integer i ;
 
 reg    [LFSR_WD_tb-1:0]     gener_out ;

 begin
  Active_tb = 1'b0;  
  @( posedge Valid_tb);
  for(i=0; i<8; i=i+1)
   begin
     
    #(Clk_period) gener_out[i] = CRC_tb ;
   end
   if(gener_out == expec_out) 
    begin
     $display("Test Case %d is succeeded",Oper_Num);
    end
   else
    begin
     $display("Test Case %d is failed", Oper_Num);
    end
   
 end
endtask




////////////////// Clock Generator  ////////////////////  
always #(Clk_period/2) Clk_tb = ~Clk_tb;

/////////////////// DUT Instantation ///////////////////
LFSR #(.SEED(8'hD8)) Dut (
  .Data(Data_tb),
  .Active(Active_tb),
  .Clk(Clk_tb),
  .Rst(Rst_tb),
  .Valid(Valid_tb),
  .CRC(CRC_tb) 
  );
endmodule

