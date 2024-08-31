module LFSR #(parameter SEED =8'hD8 )(
  input Data,
  input Active,
  input Clk,Rst,
  output  reg Valid,
  output  reg  CRC 
);
reg [3:0]  Counter;
reg [7:0]  LFSR;

always @(posedge Clk or negedge Rst)
  begin
    if (!Rst) 
      begin
       LFSR <= SEED;
       CRC <= 1'b0;
       Valid <= 1'b0;
       Counter <= 4'b0;
       
      end
    else if(Active)
      begin
         LFSR[0] <= LFSR[1];
         LFSR[1] <= LFSR[2];
         LFSR[2] <= LFSR[3] ^ LFSR[0] ^ Data;
         LFSR[3] <= LFSR[4];
         LFSR[4] <= LFSR[5];
         LFSR[5] <= LFSR[6];
         LFSR[6] <= LFSR[7] ^ LFSR[0] ^ Data;
         LFSR[7] <= LFSR[0] ^ Data;
         CRC <= 1'b0;
         Valid <= 1'b0;
         Counter <= 4'b0;
         
      end
    else if (Counter < 4'b1000 && !Active)
      begin
        CRC <= LFSR[0] ;
        LFSR[0] <= LFSR[1];
        LFSR[1] <= LFSR[2];
        LFSR[2] <= LFSR[3] ;
        LFSR[3] <= LFSR[4];
        LFSR[4] <= LFSR[5];
        LFSR[5] <= LFSR[6];
        LFSR[6] <= LFSR[7];
        LFSR[7] <= 0;         
			  Valid <= 1'b1;
			  Counter <= Counter + 1;
      end  
    else 
      begin
        Counter <= 4'b0;
        Valid <= 1'b0;
        CRC <= 1'b0;  
        LFSR <= LFSR;
    end
  end
endmodule
