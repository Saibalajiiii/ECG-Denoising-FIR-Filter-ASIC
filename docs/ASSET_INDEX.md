# Repository Artifact Index

This index maps the important source, report, document, and visual evidence in the repository.

## Architecture

| Artifact | Description |
| --- | --- |
| [`architecture/fir_64.jpeg`](../architecture/fir_64.jpeg) | Symmetric 64th-order FIR architecture |
| [`architecture/hvwtm_16x16.jpeg`](../architecture/hvwtm_16x16.jpeg) | 16x16 hierarchical HVWTM |
| [`architecture/hvwtm_8x8.jpeg`](../architecture/hvwtm_8x8.jpeg) | 8x8 hierarchical multiplier |
| [`architecture/wtm_4x4.jpeg`](../architecture/wtm_4x4.jpeg) | 4x4 Wallace Tree partial-product reduction |
| [`JRNL3_Fin_rev_old.pdf`](../JRNL3_Fin_rev_old.pdf) | Reference paper describing the HVWTM ECG FIR architecture |

## RTL and Verification

| Artifact | Description |
| --- | --- |
| [`rtl/filter_64.v`](../rtl/filter_64.v) | FIR, RCA, WTM, and HVWTM Verilog hierarchy |
| [`rtl/tb.v`](../rtl/tb.v) | VCS testbench writing `test.fsdb` |
| [`rtl/schematic.pdf`](../rtl/schematic.pdf) | RTL schematic export |
| [`rtl/tb_dut.png`](../rtl/tb_dut.png) | Verdi DUT schematic |
| [`rtl/tb_waveform.png`](../rtl/tb_waveform.png) | Verdi waveform |

## MATLAB and Simulink

| Artifact | Description |
| --- | --- |
| [`simulink/ECG1.m`](../simulink/ECG1.m) | ECG loading and noise-generation script |
| [`simulink/100m.mat`](../simulink/100m.mat) | MIT-BIH ECG data |
| [`simulink/simulink_ckt.png`](../simulink/simulink_ckt.png) | RTL black-box Simulink circuit |
| [`simulink/simulink_run.jpg`](../simulink/simulink_run.jpg) | Simulink waveform |
| [`simulink/clean.jpg`](../simulink/clean.jpg) | Clean ECG |
| [`simulink/ecg_noisy.jpg`](../simulink/ecg_noisy.jpg) | Noisy ECG |
| [`filter_designer.png`](../filter_designer.png) | MATLAB Filter Designer |

## Design Compiler

| Artifact | Description |
| --- | --- |
| [`synthesis/dc_script.tcl`](../synthesis/dc_script.tcl) | Design Compiler flow |
| [`synthesis/filter_64.sdc`](../synthesis/filter_64.sdc) | 20 ns synthesis constraints |
| [`synthesis/filter_64.mapped.v`](../synthesis/filter_64.mapped.v) | Mapped netlist |
| [`synthesis/filter_64_area.rpt`](../synthesis/filter_64_area.rpt) | Area report |
| [`synthesis/filter_64_power.rpt`](../synthesis/filter_64_power.rpt) | Power report |
| [`synthesis/filter_64_timing.rpt`](../synthesis/filter_64_timing.rpt) | Timing report |
| [`synthesis/design_compiler.png`](../synthesis/design_compiler.png) | Elaborated design |
| [`synthesis/top_module.png`](../synthesis/top_module.png) | Top-level synthesized module |
| [`synthesis/compile.png`](../synthesis/compile.png) | Compile schematic |
| [`synthesis/compile_ultra.png`](../synthesis/compile_ultra.png) | Compile Ultra schematic |

## PrimeTime

| Artifact | Description |
| --- | --- |
| [`timing_analysis/primetime_1ns_violations.png`](../timing_analysis/primetime_1ns_violations.png) | Aggressive constraint with setup violations |
| [`timing_analysis/intermediate_timing_violation.png`](../timing_analysis/intermediate_timing_violation.png) | Intermediate path with -0.69 ns slack |
| [`timing_analysis/primetime_100ns_clean.png`](../timing_analysis/primetime_100ns_clean.png) | Relaxed run without setup/hold violations |

## IC Compiler II

| Artifact | Description |
| --- | --- |
| [`physical_design/floorplan.tcl`](../physical_design/floorplan.tcl) | Floorplan script |
| [`physical_design/power_planning.tcl`](../physical_design/power_planning.tcl) | Power network script |
| [`physical_design/placement.tcl`](../physical_design/placement.tcl) | Placement script |
| [`physical_design/clock.tcl`](../physical_design/clock.tcl) | CTS script |
| [`physical_design/route.tcl`](../physical_design/route.tcl) | Routing script |
| [`physical_design/floorplan.png`](../physical_design/floorplan.png) | Floorplan |
| [`physical_design/powerplan.png`](../physical_design/powerplan.png) | Power plan |
| [`physical_design/placement.png`](../physical_design/placement.png) | Placement |
| [`physical_design/clock_tree.png`](../physical_design/clock_tree.png) | Clock-tree browser |
| [`physical_design/cts.png`](../physical_design/cts.png) | CTS layout |
| [`physical_design/route.png`](../physical_design/route.png) | Routed layout |
| [`physical_design/routed_detailed.png`](../physical_design/routed_detailed.png) | Detailed routed view |
