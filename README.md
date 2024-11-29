# OSI Layer 3 Router Design

---

## Description
This project implements a routing device functioning at **OSI Layer 3 (Network Layer)**. The router enables efficient transmission of data packets between computer networks by incorporating modular components such as a Finite State Machine (FSM), Synchronizer, FIFO, and Register modules. It supports packet routing, parity checking, sending, and receiving, ensuring robust communication and data integrity.

---

## Features
- **Packet Routing**: Routes data packets to the appropriate destination based on header information.
- **Parity Checking**: Ensures data integrity during transmission by verifying parity bits.
- **Layered Design**: Implements OSI Layer 3 functionality for network packet handling.
- **State Management**: FSM-based architecture handles various states like packet detection, loading, and error handling.
- **Synchronization**: Uses a Synchronizer to ensure proper communication between asynchronous ports.
- **Data Buffering**: FIFO logic for managing input/output data flows.
- **Temporary Storage**: Registers for holding and managing bytes and packets during processing.

---

## Modules
1. **Finite State Machine (FSM)**:
   - Handles state transitions for packet detection, validation, and routing.
   - States include `IDLE`, `LOAD_HEADER`, `PARITY_CHECK`, `FORWARD_PACKET`, and `ERROR`.

2. **Register Module**:
   - Temporarily stores packets and byte data during routing operations.
   - Manages incoming and outgoing data with appropriate control signals.

3. **Synchronizer**:
   - Ensures reliable communication between asynchronous ports.
   - Synchronizes signals across clock domains.

4. **FIFO (First-In-First-Out)**:
   - Buffers incoming data for sequential processing.
   - Supports flow control by managing input/output data logic.

5. **Parity Checker**:
   - Verifies parity bits for error detection.
   - Generates an error signal if data corruption is detected.

---

## System Design Flow
1. **Packet Input**: The router detects an incoming packet and transitions the FSM to the `LOAD_HEADER` state.
2. **Header Parsing**: Extracts header information (e.g., payload length, destination address).
3. **Data Loading**: Stores packet data in registers and buffers using FIFO.
4. **Parity Validation**: Ensures data integrity by verifying the parity bit.
5. **Routing Decision**: Based on the header, routes the packet to the appropriate output port.
6. **Packet Forwarding**: Transmits the packet to the destination while handling any error conditions via FSM.

---

## Usage
1. **Simulation**:
   - Use a testbench to simulate packet transmission, reception, and error handling.
   - Verify FSM transitions, parity checking, and FIFO buffer operations.
   
2. **Synthesis**:
   - Synthesize the design using a hardware description language like Verilog.
   - Deploy on FPGA or ASIC for hardware testing.

3. **Testing**:
   - Test different network packet scenarios, including normal transmission, parity errors, and synchronization delays.

---

## Dependencies
- **Hardware Description Language**: Verilog HDL
- **Simulation Tools**: ModelSim, Vivado, or any Verilog-compatible simulator.
- **Synthesis Tools**: Xilinx Vivado or Intel Quartus for FPGA implementation.
