module counter_5bit(

input [4:0] IN,
input load,up,down,clk,
output reg [4:0] Counter,
output reg high,low 
);


always @(*)begin
	if(Counter == 5'b00000)
		low = 1'b1;
	else 
		low = 1'b0;
end


always @(*)begin
	if(Counter ==5'b11111)
		high = 1'b1;
	else
		high = 1'b0;
end


always @(posedge clk)begin
	if(load)
		Counter <= IN;
	else if(down && !low)
		Counter <= Counter-1;
	else if(up && !high && !down)
		Counter <= Counter+1;
end
endmodule