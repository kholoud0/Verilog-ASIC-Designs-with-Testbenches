module ALU_TOP #(parameter WIDTH =16)(
  input wire  [WIDTH-1:0]   A,B,
  input wire  [3:0]         ALU_FUN,
  input wire                clk,rst,
  output  wire [2*WIDTH:0]  Arith_OUT,
  output  wire [WIDTH-1:0]  Logic_Out,
  output  wire [WIDTH-1:0]  CMP_Out,
  output  wire  [WIDTH-1:0] Shift_Out,
  output  wire               Arith_Flag,
  output  wire               Logic_Flag,
  output  wire               CMP_Flag,
  output  wire               Shift_Flag
); 


wire  Arith_Enable;
wire  Logic_Enable;
wire  CMP_Enable;
wire  Shift_Enable;


DECODER_2_4 DECODER_UNIT(
  .ALU_FUN(ALU_FUN[3:2]),
  .Arith_Enable(Arith_Enable),
  .Logic_Enable(Logic_Enable),
  .CMP_Enable(CMP_Enable),
  .Shift_Enable(Shift_Enable)
  );
  
ARITHMETIC_UNIT A_UNIT(
  .A(A),
  .B(B),
  .Arith_enable(Arith_Enable),
  .clk(clk),
  .rst(rst),
  .ALU_FUN(ALU_FUN[1:0]),
  .Arith_out(Arith_OUT),
  .Arith_Flag(Arith_Flag)
);


LOGIC_UNIT L_UNIT (
  .A(A),
  .B(B),
  .clk(clk),
  .rst(rst),
  .Logic_Enable(Logic_Enable),
  .ALU_FUN(ALU_FUN[1:0]),
  .Logic_Out(Logic_Out),
  .Logic_Flag(Logic_Flag)
);

CMP_UNIT C_UNIT (
  .A(A),
  .B(A),
  .clk(clk),
  .rst(rst),
  .CMP_Enable(CMP_Enable),
  .ALU_FUN(ALU_FUN[1:0]),
  .CMP_Out(CMP_Out),
  .CMP_Flag(CMP_Flag)
);

SHIFT_UNIT S_UNIT(
  .A(A),
  .B(B),
  .clk(clk),
  .rst(rst),
  .Shift_enable(Shift_Enable),
  .ALU_FUN(ALU_FUN[1:0]),
  .Shift_out(Shift_Out),
  .Shift_Flag(Shift_Flag)
);
endmodule