module ALU(
	input	wire	[15:0]	A,B,
	input	wire	[3:0]	ALU_FUN,
	input	wire			clk,
	output	reg		[15:0]	ALU_OUT,
	output	reg				Arith_Flag, 
	output	reg				Carry_Flag, 
	output	reg				Logic_Flag,
	output	reg				CMP_Flag,
	output	reg				Shift_Flag
);

reg  [15:0]  ALU_INT;

always @(posedge clk) begin
  
  ALU_OUT <= ALU_INT;
end

always @(*) begin
  Carry_Flag = 1'b0;
  Arith_Flag = 1'b0;
  Logic_Flag = 1'b0;
  CMP_Flag   = 1'b0;
  Shift_Flag = 1'b0;
  
	case(ALU_FUN)
 		4'b0000: begin
			{Carry_Flag , ALU_INT} = A+B; 
			 Arith_Flag = 1'b1;
		end

 		4'b0001: begin
			{Carry_Flag , ALU_INT} = A-B; 
			Carry_Flag = (A < B);
			 Arith_Flag = 1'b1;
		end

 		4'b0010: begin
			ALU_INT = A*B; 
			Carry_Flag = 1'b0;
			 Arith_Flag = 1'b1;
		end

		4'b0011: begin
			ALU_INT = A/B; 
			 Arith_Flag = 1'b1;
		end

 		4'b0100: begin	
			ALU_INT = A&B;
			Logic_Flag = 1'b1;
		end

 		4'b0101:	begin
			ALU_INT = A|B; 
			Logic_Flag = 1'b1;
		end

 		4'b0110: begin 
			ALU_INT = ~(A&B); 
			Logic_Flag = 1'b1;
		end
 		4'b0111: begin
			ALU_INT = ~(A|B); 
			Logic_Flag = 1'b1;
		end

 		4'b1000: begin
			ALU_INT = A^B; 
			Logic_Flag = 1'b1;
		end

		4'b1001: begin
			ALU_INT = ~(A^B); 
			Logic_Flag = 1'b1;
		end

		4'b1010: begin
			ALU_INT = (A == B) ? 16'b1 : 16'b0;
			CMP_Flag = 1'b1;
		end

		4'b1011: begin
		  ALU_INT = (A > B) ? 16'b10 : 16'b0;
		  CMP_Flag = 1'b1;
		end

		4'b1100: begin
	    ALU_INT = (A < B) ? 16'b11 : 16'b0;
	    CMP_Flag = 1'b1;
	    end
 
		4'b1101: begin
			ALU_INT = A >> 1; 
			Shift_Flag = 1'b1;

		end

		4'b1110: begin 
			ALU_INT = A << 1; 
			Shift_Flag = 1'b1;
		end

		default: begin 
			ALU_INT = 16'b0; 
		end
	endcase
end	

endmodule
 

