module cLOCK_DIVIDER_top (
    input           i_ref_clk,
    input           i_rst_n,
    input           i_clk_en,
    input   [7:0]        i_div_ratio,
    output  wire     o_div_clk

);
wire    divided_clk;
 comb_mux mux1(
    .i_ref_clk(i_ref_clk),   // Reference clock
    .divided_clk(divided_clk), // Divided clock
    .i_rst_n(i_rst_n),     // Active low reset signal
    .i_div_ratio(i_div_ratio), // Division ratio (used for selection)
    .o_div_clk(o_div_clk)    // Output clock (mux output)
);
divider divider1(
    .i_ref_clk(i_ref_clk),
    .i_rst_n(i_rst_n),
    .i_clk_en(i_clk_en),
    .i_div_ratio(i_div_ratio),
    .divided_clk(divided_clk)
);
endmodule
