module DESERIALIZER(
    input                 CLK,
    input                 RST,
    input                 deser_en,
    input                 sampled_bit,
    output  reg   [7:0]   P_DATA
);


always @(posedge CLK or negedge RST) begin
    if(!RST)
    begin
        P_DATA <= 8'b00000000;
    end
    else if(deser_en)
    begin
        P_DATA <= {sampled_bit, P_DATA[7:1]};
    
    end
    else
    begin
      P_DATA <= P_DATA;
    end
end

endmodule
