
# UART TX Transmitter

## Introduction

UART (Universal Asynchronous Receiver/Transmitter) is a widely-used serial communication protocol, commonly used alongside protocols like I2C and SPI. It enables full-duplex communication, meaning data can be transmitted and received simultaneously. The UART TX module converts parallel data from the master device (e.g., CPU) into serial form for transmission to the UART RX module.
![image](https://github.com/user-attachments/assets/6713f77b-4984-4dbb-8be6-8c1de97b847d)

## Block Interface

| Port      | Width | Description                           |
|-----------|-------|---------------------------------------|
| CLK       | 1     | UART TX Clock Signal                  |
| RST       | 1     | Synchronized Reset Signal             |
| PAR_TYP   | 1     | Parity Type (1: Even, 0: Odd)         |
| PAR_EN    | 1     | Parity Enable (0: Disable, 1: Enable) |
| P_DATA    | 8     | Input Data Byte                       |
| DATA_VALID| 1     | Input Data Valid Signal               |
| TX_OUT    | 1     | Serial Data Output (High during transmission, low otherwise) |
| Busy      | 1     | High when transmitting, low otherwise |

## Specifications

- The UART TX module accepts data on the `P_DATA` bus when `DATA_VALID` is high.
- Registers are cleared using an asynchronous active-low reset.
- `DATA_VALID` is high for only 1 clock cycle when valid data is sent.
- The `Busy` signal remains high during transmission and low when idle.
- While transmitting, UART TX cannot accept new data even if `DATA_VALID` goes high.
- `TX_OUT` is high in the idle state (no transmission).
- **Parity Enable (PAR_EN)**: 
  - 0: Disables parity bit
  - 1: Enables parity bit
- **Parity Type (PAR_TYP)**:
  - 0: Even parity
  - 1: Odd parity

## UART Frame Formats

1. **Data Frame with Parity Enabled (Even)**:
   - 1 Start Bit (1'b0)
   - 8 Data Bits (LSB or MSB first)
   - 1 Even Parity Bit
   - 1 Stop Bit

2. **Data Frame with Parity Enabled (Odd)**:
   - 1 Start Bit (1'b0)
   - 8 Data Bits (LSB or MSB first)
   - 1 Odd Parity Bit
   - 1 Stop Bit

3. **Data Frame without Parity**:
   - 1 Start Bit (1'b0)
   - 8 Data Bits (LSB or MSB first)
   - 1 Stop Bit


