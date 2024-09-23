module UART_RX(
    input               RX_IN,
    input        [5:0]  Prescale,
    input               CLK,
    input               RST,
    input               PAR_TYP,
    input               PAR_EN,
    output  wire [7:0]  P_DATA,
    output  wire        data_valid
    //output  wire        Parity_Error,
    //output  wire        Stop_error
);
wire        deser_en;
wire        sampled_bit;
wire        enable;
wire [3:0]  bit_cnt;
wire [5:0]  edge_cnt;
wire        par_chk_en;
wire        par_err;
wire        stp_chk_en;
wire        stp_err;
wire        strt_chk_en;
wire        strt_glitch;
wire        dat_samp_en;

FSM fsm(
    .CLK(CLK),
    .RST(RST),
    .RX_IN(RX_IN),
    .PAR_EN(PAR_EN),
    .edge_cnt(edge_cnt),
    .bit_cnt(bit_cnt),
    .strt_glitch(strt_glitch),
    .par_err(par_err),
    .stp_err(stp_err),
    .Prescale(Prescale),
    .dat_samp_en(dat_samp_en),
    .enable(enable),
    .par_chk_en(par_chk_en),
    .strt_chk_en(strt_chk_en),
    .stp_chk_en(stp_chk_en),
    .data_valid(data_valid),
    .deser_en(deser_en)
);

DATA_SAMPLING sampling(
    .CLK(CLK),
    .RST(RST),
    .edge_cnt(edge_cnt),
    .Prescale(Prescale),
    .dat_samp_en(dat_samp_en),
    .RX_IN(RX_IN),
    .sampled_bit(sampled_bit)
);

STRT_CHECK start(
    .CLK(CLK),
    .RST(RST),
    .strt_chk_en(strt_chk_en),
    .sampled_bit(sampled_bit),
    .strt_glitch(strt_glitch)
);
STOP_CHECK stop(
    .CLK(CLK),
    .RST(RST),
    .stp_chk_en(stp_chk_en),
    .sampled_bit(sampled_bit),
    .stp_err(stp_err)
);

PARITY_CHECK peaity(
    .CLK(CLK),
    .RST(RST),
    .par_chk_en(par_chk_en),
    .PAR_TYP(PAR_TYP),
    .sampled_bit(sampled_bit),
    .P_DATA(P_DATA),
    .par_err(par_err)
);

EDGE_BIT_COUNTER edge_bit_counter(
    .CLK(CLK),
    .RST(RST),
    .enable(enable),
    .Prescale(Prescale),
    .bit_cnt(bit_cnt),
    .edge_cnt(edge_cnt)
);

DESERIALIZER deserializer(
    .CLK(CLK),
    .RST(RST),
    .deser_en(deser_en),
    .sampled_bit(sampled_bit),
    .P_DATA(P_DATA)
);

endmodule