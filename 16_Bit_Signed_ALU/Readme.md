## Block Diagram

![image](https://github.com/user-attachments/assets/9d028f2d-413e-48e6-adde-738ee6d691cc)


## ALU_FUNC Table

The `ALU_FUNC` signal determines the operation performed by the ALU:

| ALU_FUNC | Operation                        | ALU_OUT |
|----------|----------------------------------|---------|
| 0000     | Arithmetic: Signed Addition      | Result  |
| 0001     | Arithmetic: Signed Subtraction   | Result  |
| 0010     | Arithmetic: Signed Multiplication| Result  |
| 0011     | Arithmetic: Signed Division      | Result  |
| 0100     | Logic: AND                       | Result  |
| 0101     | Logic: OR                        | Result  |
| 0110     | Logic: NAND                      | Result  |
| 0111     | Logic: NOR                       | Result  |
| 1000     | NOP                              | 0       |
| 1009     | CMP: A = B                       | Result  |
| 1010     | CMP: A > B                       | Result  |
| 1011     | CMP: A < B                       | Result  |
| 1100     | SHIFT: A >> 1                    | Result  |
| 1101     | SHIFT: A << 1                    | Result  |
| 1110     | SHIFT: B >> 1                    | Result  |
| 1111     | SHIFT: B << 1                    | Result  |

---
