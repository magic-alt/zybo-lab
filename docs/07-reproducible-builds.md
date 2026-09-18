# 07 — Reproducible Vivado Builds

## Goal

A Zynq teaching repository is not reproducible if the real source of truth is a GUI-created .xpr.

For Labs 04–10, the source of truth is now Tcl + RTL + Original-ZYBO XDC + software source, with a pinned upstream commit only where historical Digilent IP is unavoidable.

## Entry points

### Full hardware build

~~~bash
make vivado-lab04
make vivado-lab05
make vivado-lab06
make vivado-lab07
make vivado-lab08
make vivado-lab09
make vivado-lab10
~~~

Labs 04/05/06/07/08/10 normally emit a disposable Vivado project plus system.generated.tcl, a bitstream, an XSA, timing_summary.rpt and utilization.rpt below build/labXX/.

### Block Design validation only

~~~bash
make vivado-bd-lab04
make vivado-bd-all
~~~

This sets ZYBO_BUILD_MODE=bd: construct the BD, run validate_bd_design, emit a generated BD Tcl snapshot and wrapper, then stop before implementation.

### Synthesis-only developer mode

~~~bash
ZYBO_BUILD_MODE=synth make vivado-lab06
~~~

## Common infrastructure

scripts/common/zybo_common.tcl centralizes:

- target part xc7z010clg400-1;
- Original ZYBO board-part detection;
- fallback Original-ZYBO PS7/DDR/MIO preset;
- dynamic selection of installed Xilinx IP versions;
- GP0/HP0 AXI connection helpers;
- XDC/RTL loading;
- Block Design validation;
- generated Tcl snapshot;
- synthesis/implementation/report/XSA export.

The board-part filter deliberately accepts digilentinc.com:zybo:* and does not select Zybo Z7.

If the Digilent board file is absent, the fallback carries the key official DDR and GEM0 I/O settings. Installing the official Original-ZYBO board files remains preferred.

## Stable address map

| Peripheral | Address |
|---|---:|
| AXI DMA | 0x4040_0000 |
| AXI GPIO baseline | 0x4120_0000 |
| AXI IIC audio control | 0x4160_0000 |
| XADC | 0x43C3_0000 |

These choices follow Digilent's historical Original-ZYBO reference-design conventions and stop software examples from drifting with Address Automation.

## CI layers

### Layer 1 — Open-source CI

.github/workflows/reference-labs.yml runs on GitHub-hosted Ubuntu and checks:

1. Lab 00–02 Icarus Verilog smoke tests;
2. Lab 04–10 Make/Tcl structure;
3. fixed address/reference tokens;
4. absence of Zybo-Z7 leakage in executable Tcl;
5. Tcl command completeness using tclsh info complete.

### Layer 2 — Real Vivado CI

.github/workflows/vivado-self-hosted.yml is a manual workflow for a runner labeled self-hosted, linux, vivado. It invokes make vivado-bd-labXX.

## Backend policy

Labs 04–07 and 10 use current Xilinx IP Integrator IP and the shared modern Tcl infrastructure.

Lab 08 currently implements reproducible codec/I2S Stage 1: AXI IIC, 12.288 MHz MCLK and an in-tree playback generator on the Original-ZYBO SSM2603 pins. Bidirectional AXI-Stream + DMA is the next milestone; Stage 1 is not described as full DMA-audio validation.

Lab 09 uses a pinned historical backend because the full Original-ZYBO HDMI source design depends on Digilent legacy TMDS/DVI and dynamic-clock IP.

~~~bash
make legacy-ip
make vivado-lab09
~~~

The source is pinned to Digilent/ZYBO commit 834fd71ed0349b8be6594a75f63a5f0c1f6ba615.

This makes the historical implementation stable while keeping the tool-version boundary explicit. It does not claim that 2015-era HDMI IP will synthesize unmodified in every future Vivado release.

## Definition of reproducible

1. No manually-created Vivado project is required as source input.
2. External historical source is pinned by commit.
3. Address maps are deterministic.
4. Board target is explicitly Original ZYBO.
5. Generated project/artifact directories are disposable.
6. Static checks run without proprietary tools.
7. Real Vivado validation has an explicit self-hosted CI path.

## Modern and legacy aggregate targets

A single Vivado version is not a truthful common denominator for current AXI IP and the 2015-era Digilent HDMI/audio custom IP. Aggregate targets are therefore separated:

~~~bash
# Current/native IP path: Labs 04,05,06,07,08,10
make vivado-all
make vivado-bd-all

# Pinned historical full-board paths
make vivado-legacy-all
make vivado-legacy-bd-all
~~~

Legacy aggregate includes the full official DMA-audio backend plus Original-ZYBO HDMI Source and Sink. This separation makes a CI failure attributable to either a current-design regression or a historical tool/IP compatibility boundary.
