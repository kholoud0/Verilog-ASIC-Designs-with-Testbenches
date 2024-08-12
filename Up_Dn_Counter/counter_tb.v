module counter_tb();

reg [4:0] IN_tb;
reg load_tb, down_tb, up_tb, clk_tb;
wire [4:0] Counter_tb;
wire high_tb, low_tb;

always #5 clk_tb = ~clk_tb;

initial 
 begin
  $dumpfile("count.vcd"); // waveforms in this file      
  $dumpvars; 
  clk_tb = 1'b0;
  IN_tb = 5'b00011;
  up_tb = 1'b0;
  down_tb = 1'b0;
  load_tb = 1'b1;

  $display("TEST CASE 1 input load");
#15
  if(Counter_tb == IN_tb)
    $display("TEST PASSED ");
  else
    $display("TEST FAILED: Counter_tb = %b, Expected = %b", Counter_tb, IN_tb);

  load_tb = 1'b0;

  $display("TEST CASE 2 Counter is stable");
#10
  if(Counter_tb == 5'b00011)
   $display("TEST PASSED ");
  else
    $display("TEST FAILED: Counter_tb = %b, Expected = 5'b00011", Counter_tb);
  up_tb = 1'b1;

  $display("TEST CASE 3 Counter is incremented");
#10
  if(Counter_tb == 5'b00100)
   $display("TEST PASSED ");
  else
   $display("TEST FAILED: Counter_tb = %b, Expected = 5'b00100", Counter_tb);
  down_tb = 1'b1;

  $display("TEST CASE 4 decrement has high priority");
 #10
  if(Counter_tb == 5'b00011)
   $display("TEST PASSED ");
  else
   $display("TEST FAILED: Counter_tb = %b, Expected = 5'b00011", Counter_tb);

 $display("TEST CASE 5 counter saturate at zero with low flag");
 #50
  if(Counter_tb == 5'b00000 && low_tb == 1)
   $display("TEST PASSED ");
  else
    $display("TEST FAILED: Counter_tb = %b, low_tb = %b, Expected = 5'b00000, low_tb = 1", Counter_tb, low_tb);
  
 $display("TEST CASE 6 counter saturate at 31 with high flag");
 down_tb = 1'b0;
 
 #320
  if(Counter_tb == 5'b11111 && high_tb == 1)
   $display("TEST PASSED ");
  else
   $display("TEST FAILED: Counter_tb = %b, high_tb = %b, Expected = 5'b11111, high_tb = 1", Counter_tb, high_tb);
        
#20
$stop;

 end

counter_5bit counter_1(
 .IN (IN_tb),
 .load (load_tb),
 .up (up_tb),
 .down (down_tb),
 .clk (clk_tb),
 .Counter (Counter_tb),
 .high (high_tb),
 .low (low_tb)
);
endmodule

