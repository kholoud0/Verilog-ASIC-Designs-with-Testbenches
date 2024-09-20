module FSM(
  input   Data_Valid,
  input   ser_done,
  input   CLK,
  input   RST,
  input   PAR_EN,
  output  reg  [1:0] mux_sel,
  output  reg   busy,
  output  reg   ser_en
  );
  
reg	[2:0]	n_state;
reg 	[2:0]	c_state;

localparam  IDLE = 3'b000,
            START = 3'b001,
            DATA = 3'b010,
            PARITY = 3'b011,
            STOP = 3'b100,
            DONE = 3'b101;

always@(posedge CLK or negedge RST)
begin
  if(!RST)
    c_state <= IDLE;
  else
    c_state <= n_state;
end
always@(*)
begin
  case(c_state)
    IDLE:
    begin
      mux_sel = 2'b01;
      ser_en= 1'b0;
      busy = 1'b0;
      if(Data_Valid)
        n_state = START;
      else
        n_state = IDLE;
      end
      START:
      begin
        mux_sel= 2'b00;
        ser_en=1'b1;
        busy= 1'b1;
        n_state = DATA;
      end
      DATA:
      begin
        mux_sel= 2'b10;
        ser_en=1'b1;
        busy= 1'b1;
        if(ser_done)
          if(PAR_EN)
            n_state = PARITY;
          else
            n_state = STOP;
        else
           n_state = DATA;
      end
      PARITY:
      begin
        mux_sel= 2'b11;
        ser_en=1'b0;
        busy= 1'b1;
        n_state = STOP;
      end
      STOP:
      begin
        mux_sel= 2'b01;
        ser_en=1'b0;
        busy= 1'b1;
        
          n_state = IDLE;
      end
        
  
endcase
end

endmodule
  
  