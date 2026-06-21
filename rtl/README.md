# RTL

This folder contains the Verilog implementation of the 64th-order FIR filter and a simple testbench.

## Files

| File | Purpose |
| --- | --- |
| `filter_64.v` | Complete RTL, including flip-flops, adders, Wallace Tree Multiplier blocks, and the top-level `filter_64` module |
| `tb.v` | Testbench for basic input/output simulation |
| `print.pdf` | RTL-related exported document |

## Top-Level Interface

```verilog
module filter_64(
    input ce,
    input rst,
    input [15:0] x,
    input clk,
    output [31:0] y
);
```

## Simulation

```sh
iverilog -o filter_64_tb filter_64.v tb.v
vvp filter_64_tb
```

The simulation writes `filter_64_tb.vcd` by default.
