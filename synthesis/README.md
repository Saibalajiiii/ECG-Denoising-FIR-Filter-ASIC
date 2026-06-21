# Synthesis

This folder contains the Synopsys Design Compiler flow files and generated synthesis outputs for `filter_64`.

## Important Files

| File | Purpose |
| --- | --- |
| `dc_script.tcl` | Main Design Compiler synthesis script |
| `filter_64.sdc` | Source timing constraints |
| `filter_64.mapped.v` | Synthesized mapped Verilog netlist |
| `filter_64.mapped.sdc` | Mapped SDC output |
| `filter_64_area.rpt` | Area report |
| `filter_64_power.rpt` | Power report |
| `filter_64_timing.rpt` | Timing report |

## Report Summary

| Metric | Value |
| --- | ---: |
| Total cell area | 14,552.539644 |
| Total area | 17,531.567457 |
| Total dynamic power | 160.5735 uW |
| Total reported power | 186.3152 uW |
| Sequential cells | 320 |
| Combinational cells | 4,980 |

The scripts reference local library/setup paths. Update those paths before rerunning the flow on another machine.
