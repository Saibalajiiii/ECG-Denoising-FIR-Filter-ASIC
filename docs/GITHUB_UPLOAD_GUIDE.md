# GitHub Upload Guide

Use these steps after installing Git on your machine. You do not need MATLAB, Simulink, Design Compiler, or IC Compiler II to upload this repository. Those premium tools are only required if you want to rerun the lab flow.

If you do not want to install Git, you can still upload through the GitHub website:

1. Create a new empty repository on GitHub.
2. Click **uploading an existing file**.
3. Drag the contents of `C:\Users\AJITH\Videos\project1` into the upload page.
4. Commit the upload on GitHub.

## First-Time Upload

```sh
git init
git add .
git commit -m "Initial clean project upload"
git branch -M main
git remote add origin https://github.com/<your-username>/<your-repo-name>.git
git push -u origin main
```

This project repository is:

```text
https://github.com/Saibalajiiii/ECG-Denoising-FIR-Filter-ASIC
```

For this repository, use:

```sh
git init
git add .
git commit -m "Initial clean project upload"
git branch -M main
git remote add origin https://github.com/Saibalajiiii/ECG-Denoising-FIR-Filter-ASIC.git
git push -u origin main
```

## Suggested Repository Description

```text
64th-order FIR filter for ECG denoising with Verilog RTL, MATLAB/Simulink reference work, synthesis reports, and physical-design outputs.
```

## Suggested Topics

```text
verilog
fir-filter
ecg
vlsi
digital-signal-processing
synopsys
design-compiler
physical-design
matlab
simulink
```

## Before Publishing

- Confirm whether `JRNL3_Fin_rev_old.pdf` is intended to be public.
- Add a license if others should be allowed to reuse the work.
- Update tool paths inside TCL scripts if you want other users to rerun the flow.
