module EDGE_BIT_COUNTER(
    input           CLK,
    input           RST,
    input           enable,
    input   [5:0]   Prescale,
    output  reg  [7:0]   bit_cnt,
    output  reg  [5 :0]   edge_cnt
);
always @(posedge CLK or negedge RST ) begin
    if (!RST) begin
        edge_cnt <= 'd0;
        bit_cnt <= 'd0;
    end
    else if (enable) begin
        if (edge_cnt== Prescale-1) begin
            edge_cnt <= 'd0;
            bit_cnt <= bit_cnt +1;
        end
        else begin
          edge_cnt <= edge_cnt +1;
        end
    end
    else begin
      edge_cnt <= 'd0;
      bit_cnt <= 'd0;
    end
end


endmodule
