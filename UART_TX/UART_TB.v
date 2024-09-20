`timescale 1ns/1ps  // Time unit is 1ns, precision is 1ps

module UART_TB();

  reg   [7:0]  P_DATA_TB;
  reg          Data_Valid_TB;
  reg          PAR_EN_TB;
  reg          PAR_TYP_TB;
  reg          CLK_TB;
  reg          RST_TB;
  wire         TX_OUT_TB;
  wire         busy_TB;
  
  parameter CLK_PERIOD = 5.0;
  integer i;  // Loop variable for bit checking

  // Clock generation
  always #2.5 CLK_TB = ~CLK_TB;

  // UART TX module instantiation
  UART_TX TX (
    .P_DATA(P_DATA_TB),
    .Data_Valid(Data_Valid_TB),
    .PAR_EN(PAR_EN_TB),
    .PAR_TYP(PAR_TYP_TB),
    .CLK(CLK_TB),
    .RST(RST_TB),
    .TX_OUT(TX_OUT_TB),
    .busy(busy_TB)
  );

  // Task: Apply reset
  task apply_reset;
    begin
      RST_TB = 1'b1;
      #20;  // Wait for 4 clock cycles
      RST_TB = 1'b0;
	$display("TEST CASE 1 RESET");
	#10
       if(TX_OUT_TB == 1'b1)
		$display("TEST PASSED");
      	else
		$display("TEST FAILED");
      #20;  // Wait after reset
      RST_TB = 1'b1;
    end
  endtask

  // Task: Send Data
  task send_data;
    input [7:0] data;
    input parity_enable;
    input parity_type;
    begin
      P_DATA_TB = data;
      Data_Valid_TB = 1'b1;
      PAR_EN_TB = parity_enable;
      PAR_TYP_TB = parity_type;
      #5;  // Wait for one clock cycle to capture data
      Data_Valid_TB = 1'b0;
    end
  endtask

  // Task: Wait for transmission to complete
  task wait_for_transmission;
    begin
      wait(busy_TB == 1'b0);
    end
  endtask

  // Function: Calculate parity bit
  function calc_parity;
    input [7:0] data;
    input parity_type;  // 0 for even, 1 for odd
    reg parity;
    integer j;
    begin
      parity = parity_type;  // Start with parity type (odd or even)
      for (j = 0; j < 8; j = j + 1) begin
        parity = parity ^ data[j];  // XOR all bits for parity calculation
      end
      
      calc_parity = parity;
    end
  endfunction

  // Task: Check Output Frame (Start, Data, Parity (if enabled), and Stop bits)
  task check_output_frame;
    input [7:0] data;
    input       parity_enable;
    input       parity_type;
    reg   [10:0] expected_frame;  // Frame with start, data, parity, stop bits
    reg   parity_bit;
    begin
      if(parity_enable ==1'b1)
        begin
          // If parity is enabled, calculate and add the parity bit
          parity_bit = calc_parity(data, parity_type); 
           // Calculate the expected frame
          expected_frame[10] = 1'b1;  // Stop bit (always 1)
          expected_frame[9] = parity_bit;
          expected_frame[8:1] = data;  // Data bits (LSB first)
          expected_frame[0] = 1'b0;  // Start bit (always 0)
          
        end
      else
        begin 
          // Calculate the expected frame
          expected_frame[10:9] = 2'b11;  // Stop bit (always 1)
          expected_frame[8:1] = data;  // Data bits (LSB first)
          expected_frame[0] = 1'b0;  // Start bit (always 0)
       end

      // Display the expected frame
      $display("Expected frame: %b", expected_frame);

      // Check each bit of the frame
      for (i = 0; i <= 10; i = i + 1) begin
        @(posedge CLK_TB);  // Wait for the next clock cycle
        if (TX_OUT_TB === expected_frame[i]) begin
          $display("PASS: Bit %0d is correct: %b", i, TX_OUT_TB);
        end else begin
          $display("FAIL: Bit %0d is incorrect. Expected: %b, Got: %b", i, expected_frame[i], TX_OUT_TB);
        end
      end
    end
  endtask

  // Testbench sequence
  initial begin
    // Initialize signals
    CLK_TB = 1'b0;
    Data_Valid_TB = 1'b0;
    PAR_EN_TB = 1'b0;
    PAR_TYP_TB = 1'b0;
    P_DATA_TB = 8'b0;
    RST_TB = 1'b1;

    // Apply reset
    apply_reset;

    // Wait a bit after reset
    #20;

    // Test case 1: Send data without parity
    send_data(8'hA5, 1'b0, 1'b0);  // Data = 10100101, no parity
    //wait_for_transmission();
    check_output_frame(8'hA5, 1'b0, 1'b0);  // Check bit-by-bit
    
    // Test case 2: Send data with even parity
    #20;  // Wait before next test
    send_data(8'h5A, 1'b1, 1'b0);  // Data = 01011010, even parity
    #5
    check_output_frame(8'h5A, 1'b1, 1'b0);  // Check bit-by-bit

    // Test case 3: Send data with odd parity
    #20;  // Wait before next test
    
    
    send_data(8'h3C, 1'b1, 1'b1);  // Data = 00111100, odd parity
    #5
    check_output_frame(8'h3C, 1'b1, 1'b1);  // Check bit-by-bit

    // Finish simulation
    #20;
    $stop;
  end

endmodule
