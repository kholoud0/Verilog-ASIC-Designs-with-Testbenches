module DATA_SAMPLING(
    input             CLK,
    input             RST,
    input   [5:0]    edge_cnt,
    input   [5:0]    Prescale,
    input            dat_samp_en,
    input            RX_IN,
    output   reg     sampled_bit
);
reg    [2:0] samples;

always @(posedge CLK or negedge RST) begin
        if (!RST)
            samples <= 3'b000;
        else if (dat_samp_en) begin
            if (edge_cnt == Prescale/2 - 1 || edge_cnt == Prescale/2 || edge_cnt == Prescale/2 + 1)
            samples <= {samples[1:0], RX_IN};
        end
        else  begin
          samples <= 3'b000;
        end
    end
always @(posedge CLK or negedge RST ) begin
    if (!RST) begin
        sampled_bit <= 1'b0;
    end
    else if (dat_samp_en) begin
        if (samples[0] + samples[1] + samples[2] >= 2)
        sampled_bit = 1'b1;
    else
        sampled_bit = 1'b0;
    end
end

endmodule
