# Async FIFO Design (SystemVerilog)

## 1. Overview

This project implements an **Asynchronous FIFO (First-In-First-Out)** memory in SystemVerilog.

The FIFO enables data transfer between **two different clock domains** using separate write (`wclk`) and read (`rclk`) clocks.

A SystemVerilog testbench verifies correct FIFO behavior using a **queue-based reference model**.

---

## 2. Features

- Separate write and read clock domains  
- Parameterized data width  
- Full and Empty flag generation  
- Random data testing  
- Queue-based scoreboard for verification  
- VCD waveform generation for debugging  

---

## 3. Design Details

- Data is written on the **write clock (`wclk`)**
- Data is read on the **read clock (`rclk`)**

### FIFO Status Signals

| Signal | Description |
|------|-------------|
| `full` | FIFO cannot accept more data |
| `empty` | FIFO has no data to read |

---

## 4. Verification Strategy

The testbench uses the following verification techniques:

- Randomized write data  
- SystemVerilog queue (`wdata_q`) as a reference model  
- Comparison of expected data vs FIFO output  
- Error reporting using `$error`  


---

## 5. Concepts Demonstrated

- Asynchronous FIFO architecture  
- Clock Domain Crossing (CDC)  
- SystemVerilog verification techniques  
- Queue-based scoreboard  
- Randomized testing  

