module comb_mux(
    input           i_ref_clk,   // Reference clock
    input           divided_clk, // Divided clock
    input           i_rst_n,     // Active low reset signal
    input   [7:0]   i_div_ratio, // Division ratio (used for selection)
    output  reg     o_div_clk    // Output clock (mux output)
);

always @(*) begin
    // Check reset first
    if (!i_rst_n) begin
        o_div_clk = 1'b0;  // Reset the output to 0
    end else begin
        // Combinational logic for MUX
        case (i_div_ratio)
            8'b00000000: o_div_clk = i_ref_clk;   // Select i_ref_clk if div_ratio is 0
            8'b00000001: o_div_clk = i_ref_clk;   // Select i_ref_clk if div_ratio is 1
            default:     o_div_clk = divided_clk; // Select divided_clk for other values
        endcase
    end
end

endmodule
