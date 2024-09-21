module UART_RX(
    input               RX_IN,
    input        [5:0]  Prescale,
    input               CLK,
    input               RST,
    input               PAR_TYP,
    input               PAR_EN,
    output  wire [7:0]  P_DATA,
    output  wire        data_valid,
    output  wire        Parity_Error,
    output  wire        Stop_error
);
wire        deser_en;
wire        sampled_bit;
wire        enable;
wire        bit_cnt;
wire        edge_cnt;
wire        par_chk_en;
wire        par_err;
wire        stp_chk_en;
wire        stp_err;
wire        strt_chk_en;
wire        strt_glitch;
wire        dat_samp_en;

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