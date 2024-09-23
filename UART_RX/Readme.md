
# UART RX Receiver

## Introduction

UART (Universal Asynchronous Receiver/Transmitter) is a widely-used serial communication protocol. It's a full-duplex protocol, allowing simultaneous data transmission and reception. The UART RX module converts serial data into parallel form for the receiving device. It also includes error detection via parity and stop bit checks.
![image](https://github.com/user-attachments/assets/6713f77b-4984-4dbb-8be6-8c1de97b847d)

## Block Interface

| Port      | Width | Description                     |
|-----------|-------|---------------------------------|
| CLK       | 1     | UART RX Clock Signal            |
| RST       | 1     | Synchronized Reset Signal       |
| PAR_TYP   | 1     | Parity Type (1: Even, 0: Odd)   |
| PAR_EN    | 1     | Parity Enable (0: Disable, 1: Enable) |
| Prescale  | 6     | Oversampling Prescale           |
| RX_IN     | 1     | Serial Data Input               |
| P_DATA    | 8     | Frame Data Byte                 |
| Data_valid| 1     | Data Byte Valid Signal          |
| Parity_Error | 1  | Frame Parity Error              |
| Stop_Error | 1    | Frame Stop Error                |

## Specifications

- Supports UART frame reception with oversampling by 8, 16, or 32.
- RX_IN remains high when idle (no transmission).
- Detects errors:
  - **Parity Error**: Raised when the calculated parity bit differs from the received one.
  - **Stop Error**: Raised when the stop bit is not received correctly.
- Data is validated and sent through `P_DATA` only if no errors are detected.
- Supports continuous reception of frames without gaps.
- Asynchronous active-low reset clears registers.

## Frame Structure

1. **With Parity (Even/Odd)**:
   - 1 Start Bit
   - 8 Data Bits (LSB or MSB first)
   - 1 Parity Bit (Even/Odd)
   - 1 Stop Bit

2. **Without Parity**:
   - 1 Start Bit
   - 8 Data Bits
   - 1 Stop Bit

## Oversampling

- RX clock is a multiple of TX clock:
  - **Prescale = 8**: RX_CLK = TX_CLK * 8 = 921.6 kHz
  - **Prescale = 16**: RX_CLK = TX_CLK * 16 = 1.843 MHz
  - **Prescale = 32**: RX_CLK = TX_CLK * 32 = 3.686 MHz

