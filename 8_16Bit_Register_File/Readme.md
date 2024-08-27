<h1>8x16 Register File<\h1>
<br>
This folder contains the Verilog design and testbench for an 8x16 Register File. The register file consists of 8 registers, each with a 16-bit width. It supports both read and write operations controlled by separate enable signals (RdEn and WrEn), and all operations are synchronized to the positive edge of the clock.

<h3>Specifications<\h3>
8 registers, each 16 bits wide
Shared address bus for read and write operations
RdEn enables the read operation, and WrEn enables the write operation
Asynchronous active-low reset clears all registers
Synchronous read/write on clock's positive edge
