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


always @(posedge clk) begin
  Carry_Flag <= 1'b0;
	case(ALU_FUN)
	  
 		4'b0000: begin
			{Carry_Flag , ALU_OUT} <= A+B; 
		end

 		4'b0001: begin
			{Carry_Flag , ALU_OUT} <= A-B; 
			Carry_Flag <= (A < B);
		end

 		4'b0010: begin
			ALU_OUT <= A*B; 
			Carry_Flag <= 1'b0;
		end

		4'b0011: begin
			ALU_OUT <= A/B; 
			Carry_Flag <= 1'b0;
		end

 		4'b0100: begin	
			ALU_OUT <= A&B;
		end

 		4'b0101:	begin
			ALU_OUT <= A|B; 
		end

 		4'b0110: begin 
			ALU_OUT <= ~(A&B); 
		end
 		4'b0111: begin
			ALU_OUT <= ~(A|B); 
		end

 		4'b1000: begin
			ALU_OUT <= A^B; 
		end

		4'b1001: begin
			ALU_OUT <= ~(A^B); 
		end

		4'b1010: begin
			ALU_OUT <= (A == B) ? 16'b1 : 16'b0;
		end

		4'b1011: begin
		  ALU_OUT <= (A > B) ? 16'b10 : 16'b0;
		end

		4'b1100: begin
	    ALU_OUT <= (A < B) ? 16'b11 : 16'b0;
	    end
 
		4'b1101: begin
			ALU_OUT <= A >> 1; 

		end

		4'b1110: begin 
			ALU_OUT <= A << 1; 
		end

		default: begin 
			ALU_OUT <= 16'b0; 
		end
	endcase
end	
always @(*)begin
  Arith_Flag = 1'b0;
  Logic_Flag = 1'b0;
  CMP_Flag   = 1'b0;
  Shift_Flag = 1'b0;
  
  case(ALU_FUN)
    4'b0000, 4'b0001, 4'b0010, 4'b0011: begin  
      Arith_Flag = 1'b1;
    end
    4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001: begin // Logic operations
      Logic_Flag = 1'b1;
    end
    4'b1010, 4'b1011, 4'b1100: begin // Comparison operations
      CMP_Flag = 1'b1;
    end
    4'b1101, 4'b1110: begin // Shift operations
      Shift_Flag = 1'b1;
    end
  endcase
  
end
endmodule
 

