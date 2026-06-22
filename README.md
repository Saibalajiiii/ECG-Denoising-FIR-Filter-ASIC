# ECG Denoising FIR Filter ASIC Using HVWTM

This repository documents the design and ASIC implementation flow of a **64th-order low-pass FIR filter for ECG denoising**. The datapath uses a **Hybrid Vedic-Wallace Tree Multiplier (HVWTM)** architecture, combining Vedic operand decomposition with Wallace Tree sub-multipliers.

The complete academic flow was performed on a lab computer using licensed MATLAB and Synopsys tools. The repository preserves the RTL, MATLAB/Simulink validation, synthesis outputs, PrimeTime timing evidence, ICC2 physical-design scripts, reports, schematics, and screenshots.

## Architecture

![64th-order symmetric FIR architecture](architecture/fir_64.jpeg)

The symmetric 64th-order FIR structure pairs input samples before multiplication. This reduces the implementation to 32 paired coefficient multipliers plus the center tap.

The multiplier hierarchy is:

```text
16x16 HVWTM
`-- four 8x8 WTM blocks
    `-- four 4x4 WTM blocks
```

| 4x4 Wallace Tree block | 8x8 HVWTM/WTM hierarchy | 16x16 HVWTM |
| --- | --- | --- |
| ![4x4 WTM](architecture/wtm_4x4.jpeg) | ![8x8 HVWTM](architecture/hvwtm_8x8.jpeg) | ![16x16 HVWTM](architecture/hvwtm_16x16.jpeg) |

The included [`JRNL3_Fin_rev_old.pdf`](JRNL3_Fin_rev_old.pdf) is the architecture reference used to understand the HVWTM-based ECG FIR design. The implementation in this repository was synthesized using the SAED 32 nm RVT library.

## Tool Flow

```text
MATLAB Filter Designer + MIT-BIH ECG data
                    |
         Verilog RTL: FIR + HVWTM
                    |
       Synopsys VCS functional simulation
                    |
          Verdi FSDB waveform debug
                    |
             Simulink validation
                    |
     Synopsys Design Compiler synthesis
                    |
       Synopsys PrimeTime timing analysis
                    |
       Synopsys IC Compiler II physical design
```

| Stage | Tool |
| --- | --- |
| Coefficient design and ECG preparation | MATLAB |
| System-level validation | Simulink with Vitis Model Composer |
| RTL simulation | Synopsys VCS |
| Waveform and schematic debug | Synopsys Verdi |
| Logic synthesis | Synopsys Design Compiler |
| Static timing analysis | Synopsys PrimeTime |
| Floorplan through routing | Synopsys IC Compiler II |

## Repository Structure

```text
architecture/       HVWTM and FIR architecture diagrams
rtl/                Verilog source, testbench, Verdi evidence
simulink/           ECG dataset, MATLAB script, model and results
synthesis/          Design Compiler scripts, reports and netlist
timing_analysis/    PrimeTime constraint experiments and results
physical_design/    ICC2 floorplan, placement, CTS and routing
docs/               Detailed artifact index
```

## RTL Verification With VCS and Verdi

The RTL was verified using Synopsys VCS and debugged in Verdi. It was not verified with Icarus Verilog.

```csh
csh
source /home/synopsys/tools/synopsys_c2s.cshrc
cd rtl
vcs -full64 -debug_access+all -kdb tb.v
./simv
verdi -ssf test.fsdb
```

The testbench includes `filter_64.v` and writes `test.fsdb`.

| Elaborated DUT | Verdi waveform |
| --- | --- |
| ![Verdi DUT schematic](rtl/tb_dut.png) | ![Verdi waveform](rtl/tb_waveform.png) |

## Simulink Validation

The ECG signal is loaded from the MIT-BIH `100m` record. The MATLAB script adds Gaussian noise at 10 dB SNR, and the FIR RTL is connected as a black box in Simulink.

| Simulink circuit | Input/output waveform |
| --- | --- |
| ![Simulink black-box circuit](simulink/simulink_ckt.png) | ![Simulink waveform](simulink/simulink_run.jpg) |

## Synthesis Results

Synopsys Design Compiler was run with the SAED 32 nm RVT library and a 20 ns clock constraint.

| Metric | Result |
| --- | ---: |
| Clock constraint | 20 ns |
| Critical-path delay | 15.44 ns |
| Setup slack | +3.76 ns, MET |
| Total cell area | 14,552.539644 |
| Total area including estimated interconnect | 17,531.567457 |
| Dynamic power | 160.5735 uW |
| Leakage power | 25.7415 uW |
| Total reported power | 186.3152 uW |
| Combinational cells | 4,980 |
| Sequential cells | 320 |

See [`synthesis/README.md`](synthesis/README.md) and the original area, power, and timing reports for details.

## PrimeTime Timing Study

The supplied PrimeTime evidence demonstrates how the design responds to different timing constraints:

| Run | Observed result |
| --- | --- |
| 1 ns constraint | 29 violating endpoints, WNS `-41.065 ns`, TNS `-651.377 ns` |
| Intermediate run | Screenshot visibly reports a 10 ns edge and slack `-0.69 ns` |
| 100 ns constraint | No setup violations and no hold violations |

The intermediate image was originally described as a 50 ns experiment, but the visible report shows a 10.00 ns clock edge; it is documented according to the report itself.

See [`timing_analysis/README.md`](timing_analysis/README.md).

## Physical Design

The ICC2 flow includes floorplanning, power planning, placement, clock-tree synthesis, routing, and routed-output generation.

| Floorplan | Placement | Clock tree |
| --- | --- | --- |
| ![Floorplan](physical_design/floorplan.png) | ![Placement](physical_design/placement.png) | ![Clock tree](physical_design/clock_tree.png) |

| Power plan | CTS layout | Routed layout |
| --- | --- | --- |
| ![Power plan](physical_design/powerplan.png) | ![CTS](physical_design/cts.png) | ![Route](physical_design/route.png) |

## Important Notes

- Premium EDA tools and the SAED PDK are not included.
- Paths in TCL scripts refer to the original lab environment and may require adjustment.
- Generated source, reports, and screenshots are preserved as evidence of the completed flow.
- The source paper uses a Cadence/SCL 180 nm flow; this repository records a separate Synopsys/SAED 32 nm implementation of the HVWTM concept.

## License

The repository source is provided under the included [`LICENSE`](LICENSE). The included paper remains subject to its original authors' and publisher's rights.
