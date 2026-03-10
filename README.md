Async FIFO Design (SystemVerilog)
Overview

This project implements an Asynchronous FIFO (First-In-First-Out) memory in SystemVerilog.
The FIFO allows data transfer between two different clock domains using separate write (wclk) and read (rclk) clocks.

A SystemVerilog testbench verifies correct FIFO behavior using a queue-based reference model.

Features

Separate write and read clock domains

Parameterized data width

Full and Empty flag generation

Random data testing

Queue-based scoreboard for verification

VCD waveform generation for debugging
Design Details

Data is written on the write clock (wclk)

Data is read on the read clock (rclk)

FIFO status signals:

full → FIFO cannot accept more data

empty → FIFO has no data to read

Verification Strategy

The testbench uses:

Randomized write data

SystemVerilog queue (wdata_q) as a reference model

Comparison of expected data vs FIFO output

Error reporting using $error
Comparison Passed: wr_data = XX and rd_data = XX
Example Output
Time = 1645: Comparison Passed: wr_data = 24 and rd_data = 24
Time = 1785: Comparison Passed: wr_data = 81 and rd_data = 81
Concepts Demonstrated

Asynchronous FIFO architecture

Clock domain crossing (CDC)

SystemVerilog verification techniques

Queue-based scoreboard

Randomized testing
