`timescale 1ns/1ps
module RX_TB();
reg               RX_IN_tb ;
reg       [5:0]   Prescale_tb ;
reg               CLK_RX_tb ;
reg               CLK_TX_tb;
reg               RST_tb ;
reg               PAR_TYP_tb ;
reg               PAR_EN_tb ;
wire      [7:0]   P_DATA_tb ;
wire              data_valid_tb ;


  // Parameters
parameter CLK_PERIOD_TX = 8680.56; // 115.2 KHz
parameter PRESCALE_8 = 6'd8;
parameter PRESCALE_16 = 6'd16;
parameter PRESCALE_32 = 6'd32;

// Clock generation for TX
always #(CLK_PERIOD_TX/2) CLK_TX_tb = ~CLK_TX_tb;


 // Task to send a byte
  task send_byte;
    input [7:0] data;
    input parity;
    integer i;
    begin
      // Start bit
      RX_IN_tb = 1'b0;
      #(CLK_PERIOD_TX);

      // Data bits
      for (i = 0; i < 8; i = i + 1) begin
        RX_IN_tb = data[i];
        #(CLK_PERIOD_TX);
      end

      // Parity bit (if enabled)
      if (PAR_EN_tb) begin
        RX_IN_tb = parity;
        #(CLK_PERIOD_TX);
      end

      // Stop bit
      RX_IN_tb = 1'b1;
      #(CLK_PERIOD_TX);
    end
  endtask

  // Test cases
  initial begin
    // Initialize signals
    CLK_TX_tb = 0;
    CLK_RX_tb = 0;
    RST_tb = 1;
    RX_IN_tb = 1;
    PAR_TYP_tb = 0;
    PAR_EN_tb = 0;
    Prescale_tb = PRESCALE_8;

    // Reset
    #100 RST_tb = 0;
    #100 RST_tb = 1;

    // Test case 1: Prescale 8
    $display("Test case 1: Prescale 8");
    Prescale_tb = PRESCALE_8;
    #100;
    send_byte(8'hA5, 1'b1);
    wait(data_valid_tb);
    #1000;
    if (P_DATA_tb === 8'hA5)
      $display("Test case 1 passed");
    else
      $display("Test case 1 failed");

    // Test case 2: Prescale 16
    $display("Test case 2: Prescale 16");
    Prescale_tb = PRESCALE_16;
    #1000;
    send_byte(8'h3C, 1'b0);
    wait(data_valid_tb);
    #1000;
    if (P_DATA_tb === 8'h3C)
      $display("Test case 2 passed");
    else
      $display("Test case 2 failed");

    // Test case 3: Prescale 32
    $display("Test case 3: Prescale 32");
    Prescale_tb = PRESCALE_32;
    #1000;
    send_byte(8'hF0, 1'b1);
    wait(data_valid_tb);
    #1000;
    if (P_DATA_tb === 8'hF0)
      $display("Test case 3 passed");
    else
      $display("Test case 3 failed");

    // Test case 4: With parity (even)
    $display("Test case 4: With even parity");
    PAR_EN_tb = 1;
    PAR_TYP_tb = 1; // Even parity
    #1000;
    send_byte(8'h55, 1'b1); // 8'h55 has odd number of 1s, so parity should be 1
    wait(data_valid_tb);
    #1000;
    if (P_DATA_tb === 8'h55)
      $display("Test case 4 passed");
    else
      $display("Test case 4 failed");

    // Test case 5: With parity (odd)
    $display("Test case 5: With odd parity");
    PAR_TYP_tb = 1'b0; // Odd parity
    #1000;
    send_byte(8'hAA, 1'b0); // 8'hAA has even number of 1s, so parity should be 0
    wait(data_valid_tb);
    #1000;
    if (P_DATA_tb === 8'hAA)
      $display("Test case 5 passed");
    else
      $display("Test case 5 failed");

    $finish;
  end

UART_RX uut (
    .RX_IN(RX_IN_tb),
    .Prescale(Prescale_tb),
    .CLK(CLK_RX_tb),
    .RST(RST_tb),
    .PAR_TYP(PAR_TYP_tb),
    .PAR_EN(PAR_EN_tb),
    .P_DATA(P_DATA_tb),
    .data_valid(data_valid_tb)
  );


// Generate RX clock based on Prescale
always  begin
    case (Prescale_tb)
      PRESCALE_8: #(CLK_PERIOD_TX/16) CLK_RX_tb = ~CLK_RX_tb;
      PRESCALE_16: #(CLK_PERIOD_TX/32) CLK_RX_tb = ~CLK_RX_tb;
      PRESCALE_32: #(CLK_PERIOD_TX/64)CLK_RX_tb = ~CLK_RX_tb;
    endcase
end
endmodule