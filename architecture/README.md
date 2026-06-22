# HVWTM and FIR Architecture

This folder contains the architecture diagrams used to explain the hierarchical Hybrid Vedic-Wallace Tree Multiplier and its use in the ECG FIR filter.

## Hybridization Strategy

The HVWTM combines:

- **Vedic decomposition at the top level:** each N-bit operand is divided into upper and lower N/2-bit halves.
- **Wallace Tree multiplication at the lower level:** the four half-width products are generated using WTM blocks.
- **Parallel addition:** ripple-carry adders and a half-adder combine the vertical and crosswise partial products.

This structure targets the modular, shorter-interconnect behavior of Vedic multiplication while retaining the compact partial-product reduction of Wallace Tree multiplication.

## Hierarchy

### 4x4 Wallace Tree Multiplier

![4x4 Wallace Tree Multiplier](wtm_4x4.jpeg)

### 8x8 Hierarchical Multiplier

![8x8 HVWTM](hvwtm_8x8.jpeg)

### 16x16 HVWTM

![16x16 HVWTM](hvwtm_16x16.jpeg)

The signed 16x16 block is instantiated for each non-zero FIR coefficient product.

## 64th-Order Symmetric FIR

![64th-order FIR](fir_64.jpeg)

Coefficient symmetry allows sample pairs such as `x[n] + x[n-64]` to share a multiplier. The implementation therefore uses 32 paired products and one center-tap product instead of 65 independent multipliers.
