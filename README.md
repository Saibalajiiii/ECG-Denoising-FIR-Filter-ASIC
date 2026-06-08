# ASIC Implementation of ECG Denoising FIR Filter using Hybrid Vedic-Wallace Tree Multiplier

## Overview

This project presents the RTL-to-GDSII implementation of a 64th-order ECG denoising FIR filter using a Hybrid Vedic-Wallace Tree Multiplier (HVWTM) architecture.

The objective is to design a low-area and low-power FIR filter suitable for biomedical signal processing applications, particularly ECG denoising in portable healthcare systems.

## Key Features

* 64th-order Low-Pass FIR Filter
* Hybrid Vedic-Wallace Tree Multiplier Architecture
* Symmetric Coefficient Optimization
* Verilog RTL Implementation
* Functional Verification using VCS and Verdi
* Synthesis using Synopsys Design Compiler
* Physical Design using Synopsys ICC2
* Static Timing Analysis using PrimeTime
* ECG Denoising Validation

## Design Flow

MATLAB Coefficient Generation
→ Verilog RTL Design
→ Functional Verification (VCS/Verdi)
→ Logic Synthesis (Design Compiler)
→ Physical Design (ICC2)
→ Static Timing Analysis (PrimeTime)
→ GDSII Generation

## Architecture

The FIR filter employs:

* Shift-register based tapped delay line
* Hybrid Vedic-Wallace multipliers
* Ripple Carry Adders
* Symmetric FIR coefficient optimization

## Verification

The design was verified through:

* Module-level testbenches
* Multiplier verification
* FIR filter verification
* Waveform analysis using Verdi

For validation, a constant input sequence was applied to the FIR filter. The steady-state output converged to the sum of filter coefficients, confirming correct filter functionality.

## Tools Used

| Stage           | Tool                     |
| --------------- | ------------------------ |
| Filter Design   | MATLAB                   |
| RTL Design      | Verilog HDL              |
| Simulation      | Synopsys VCS             |
| Debugging       | Verdi                    |
| Synthesis       | Synopsys Design Compiler |
| Physical Design | Synopsys ICC2            |
| Timing Analysis | Synopsys PrimeTime       |

## Repository Structure

rtl/
testbench/
simulation/
synthesis/
physical_design/
docs/
images/

## Status

Work in progress. Additional implementation details, reports, scripts, waveforms, and physical design results will be uploaded progressively.
