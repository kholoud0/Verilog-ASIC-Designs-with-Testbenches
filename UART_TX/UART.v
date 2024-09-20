
module UART_TX(
  input   [7:0]  P_DATA,
  input     Data_Valid,
  input     PAR_EN,
  input     PAR_TYP,
  input     CLK,
  input     RST,
  output  wire  TX_OUT,
  output  wire  busy
  );
  

wire    ser_done;
wire    ser_en;
wire  [1:0]  mux_sel;
wire    par_bit;
wire    ser_data;

serializer  SER_U(
  .P_DATA(P_DATA),
  .ser_en(ser_en),
  .Data_Valid(Data_Valid),
  .CLK(CLK),
  .RST(RST),
  .ser_data(ser_data),
  .ser_done(ser_done)
);

parit_calc PARITY_U(
  .P_DATA(P_DATA),
  .DATA_VALID(Data_Valid),
  .PAR_TYP(PAR_TYP),
  .CLK(CLK),
  .par_bit(par_bit)
);

FSM FAM_U(
  .Data_Valid(Data_Valid),
  .ser_done(ser_done),
  .CLK(CLK),
  .RST(RST),
  .PAR_EN(PAR_EN),
  .mux_sel(mux_sel),
  .busy(busy),
  .ser_en(ser_en)
  );

MUX MUX_U(
  .mux_sel(mux_sel),
  .ser_data(ser_data),
  .par_bit(par_bit),
  .TX_OUT(TX_OUT)
);


  
endmodule
