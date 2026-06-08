# ECG Denoising FIR Filter ASIC Implementation

## Project Overview

This project presents the design and implementation of a 64th-order ECG denoising FIR filter using a Hybrid Vedic-Wallace Tree Multiplier (HVWTM) architecture. The objective is to develop a low-area and low-power digital filter suitable for biomedical signal processing applications, particularly portable ECG monitoring systems.

The complete design flow includes algorithm development, RTL design, functional verification, synthesis, physical design, and timing analysis.

---

## Motivation

Electrocardiogram (ECG) signals are often corrupted by high-frequency noise during acquisition and transmission. Digital low-pass FIR filters are widely used to remove these unwanted components while preserving the important diagnostic features of the ECG waveform.

Since FIR filters require a large number of multiplication operations, multiplier optimization plays a critical role in reducing hardware area and power consumption.

This project implements a Hybrid Vedic-Wallace Tree Multiplier architecture to improve the efficiency of FIR filter implementation.

---

## Project Specifications

| Parameter               | Value                                |
| ----------------------- | ------------------------------------ |
| Filter Type             | Low-Pass FIR                         |
| Filter Order            | 64                                   |
| Application             | ECG Denoising                        |
| Data Width              | 16-bit                               |
| Multiplier Architecture | Hybrid Vedic-Wallace Tree Multiplier |
| RTL Language            | Verilog HDL                          |

---

## Design Flow

MATLAB Filter Design

↓

Coefficient Generation

↓

Verilog RTL Design

↓

Functional Verification (VCS)

↓

Waveform Debugging (Verdi)

↓

Simulink Integration and Validation

↓

Logic Synthesis (Synopsys Design Compiler)

↓

Physical Design (Synopsys ICC2)

↓

Static Timing Analysis (PrimeTime)

↓

GDSII Generation

---

## Architecture

The FIR filter architecture consists of:

* Shift-register based delay line
* Multiply-Accumulate (MAC) structure
* Hybrid Vedic-Wallace Tree Multipliers
* Ripple Carry Adders
* Symmetric FIR coefficient implementation

The design exploits coefficient symmetry to reduce hardware complexity and improve implementation efficiency.

---

## MATLAB and Simulink Verification

The FIR filter coefficients were generated and verified in MATLAB.

The RTL implementation was integrated into Simulink using a Black Box interface and tested using noisy ECG signals.

Verification steps included:

* ECG signal acquisition
* Noise injection
* FIR filtering
* Output waveform comparison

The filtered ECG output demonstrated successful attenuation of high-frequency noise while preserving ECG features.

---

## RTL Design

The project includes implementation of:

* Half Adder (HA)
* Full Adder (FA)
* Ripple Carry Adder (RCA)
* Wallace Tree Multiplier (WTM)
* Hybrid Vedic-Wallace Tree Multiplier (HVWTM)
* FIR Filter Top Module

All modules were developed in Verilog HDL.

---

## Functional Verification

Verification was performed using Synopsys VCS and Verdi.

The following tests were carried out:

* Individual module verification
* Multiplier verification
* FIR filter verification
* Waveform inspection

A constant input sequence was applied to the FIR filter, and the steady-state output converged to the sum of filter coefficients, confirming correct filter functionality.

---

## Tools Used

| Design Stage            | Tool                     |
| ----------------------- | ------------------------ |
| Algorithm Development   | MATLAB                   |
| System Validation       | Simulink                 |
| RTL Design              | Verilog HDL              |
| Functional Verification | Synopsys VCS             |
| Waveform Debugging      | Verdi                    |
| Logic Synthesis         | Synopsys Design Compiler |
| Physical Design         | Synopsys ICC2            |
| Timing Analysis         | Synopsys PrimeTime       |

---

## Repository Structure

```text
rtl/
testbench/
images/
docs/
simulation/
synthesis/
physical_design/
```

---

## Current Status

* MATLAB Filter Design Completed
* Simulink Validation Completed
* RTL Design Completed
* Functional Verification Completed
* Logic Synthesis Completed
* Physical Design In Progress
* Static Timing Analysis In Progress

---

## Future Work

* Power Gating Optimization
* Signoff Timing Closure
* DRC/LVS Verification
* Final GDSII Generation

---

## Author

Sai Balaji

VLSI Design and Digital ASIC Implementation Projects
