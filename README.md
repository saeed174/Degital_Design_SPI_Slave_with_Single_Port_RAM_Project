# 🧠 SPI Wrapper Module – Verilog Implementation

Welcome to the **SPI Wrapper Project**!  
This project implements a modular and extensible **SPI communication system** using **Verilog**, including an SPI Slave interface, memory access, and structured data conversion between serial and parallel formats.

---

## 🔝 Top Module: `SPI_Wrapper`

The entry point for this design is the `SPI_Wrapper` module, which integrates:

- 🧩 `SPI_Slave`: Manages SPI protocol and serial communication  
- 🧠 `RAM`: Stores and retrieves 8-bit data  
- 🔄 Data paths for transmitting (`tx_data`) and receiving (`rx_data`) data

---

## 🔧 Features

- 📡 **SPI Slave Communication**  
  Supports `MOSI`, `MISO`, `SS_n`, and `clk` lines  
  SPI protocol handling via `SPI_Slave`

- 🧭 **Finite State Machine (FSM)**  
  States: `IDLE`, `CHK_CMD`, `WRITE`, `READ_ADD`, `READ_DATA`  
  Controls transaction type and flow

- 🧮 **Serial-to-Parallel & Parallel-to-Serial Conversion**  
  Serial-to-Parallel (STP): Converts 10-bit serial input from `MOSI`  
  Parallel-to-Serial (PTS): Sends 8-bit parallel data over `MISO`

- 🧠 **RAM Integration**  
  Handles memory write/read using control signals from `SPI_Wrapper`

- 🧼 **Tri-state MISO Control**  
  `MISO` is `1'bz` during `IDLE` and `CHK_CMD` states  
  Prevents bus conflicts on shared SPI line

---

## 📁 File Structure
├── SPI_Wrapper.v # 🔝 Top-level wrapper module
├── SPI_Slave.v # SPI slave controller
├── Serial_to_Parallel.v # Serial-to-parallel converter
├── parallel_to_serial.v # Parallel-to-serial converter
├── RAM.v # Simple RAM memory
├── README.md # Project documentation
نسخ
تحرير

---

## 🧪 Simulation & Testing

To simulate this design:

1. ✅ Create a testbench for `SPI_Wrapper.v`
2. 🧩 Stimulate SPI input sequences (`MOSI`, `SS_n`)
3. 📤 Observe `MISO`, memory contents, and FSM state transitions

> Need a testbench file? Let me know — I can generate one for you.

---

## 🚦 SPI Slave FSM Diagram

```text
                                               +-------+
                                               | IDLE  |<--------------------+<-------+<-------+<--------+
                                               +---+---+                     |        |        |         |
                                                   | SS_n=0                  | SS_n=1 | SS_n=1 |SS_n=1   |SS_n=1
                                                   v                         |        |        |         |
                              MOSI=1 (read)   +----+-----+                   |        |        |         |
         +----------------+<----------------- | CHK_CMD  |------------------>+        |        |         |
         | read_or_addr=1 |   read_or_addr=0  +----+-----+                            |        |         |
         |                |                        | MOSI=0 (write)                   |        |         |
         |                |                        v                                  |        |         |
         |                |                     +--+--+                               |        |         |
         |                |                     |WRITE|------------------------------>+        |         |
         |                |                     +--+--+                                        |         |
         |                |                                                                    |         |
         |          +-----v------+                                                             |         |
         |          | READ_ADD   |-------------------------------------------------------------+         |
         |          +-----+------+                                                                       |   
         |                                                                                               |    
         v                                                                                               |    
  +-----+------+                                                                                         |
  | READ_DATA  |-----------------------------------------------------------------------------------------+
  +------------+

## 🛠️ Requirements
Verilog HDL simulator (e.g., ModelSim, Icarus Verilog)

Optional: FPGA toolchain (Vivado, Quartus) for hardware testing

##🧠 Notes
SPI Mode: Mode 0 (CPOL=0, CPHA=0) assumed

MISO tristated during IDLE and CHK_CMD to avoid bus contention

RAM responds to rx_valid and tx_valid flags for memory interaction

##📜 License
This project is open-source and licensed under the MIT License.

##🙋‍♂️ Author
saeed174

