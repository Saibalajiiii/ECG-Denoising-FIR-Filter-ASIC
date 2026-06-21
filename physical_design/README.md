# Physical Design

This folder contains IC Compiler II scripts and screenshots for the physical implementation flow.

## Flow Scripts

| Step | Script |
| --- | --- |
| Floorplan | `floorplan.tcl` |
| Placement | `placement.tcl` |
| Power planning | `power_planning.tcl` |
| Clock tree synthesis | `clock.tcl` |
| Routing | `route.tcl` |

## Screenshots

| Stage | Image |
| --- | --- |
| Floorplan | `floorplan.png` |
| Placement | `placement.png` |
| Power plan | `powerplan.png` |
| Clock tree synthesis | `cts.png` |
| Routing | `route.png` |
| Layout zoom | `zoom.png` |

The TCL files assume a local SAED 32 nm PDK/reference-library setup. Adjust `PDK_PATH` and related input/output directories before rerunning.
