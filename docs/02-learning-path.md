# 02 — 完整学习路线

## Level 0：PL 基础

### Lab 00 — GPIO
Verilog module、XDC、Synthesis/Implementation/Bitstream、Icarus Verilog Testbench。

### Lab 01 — Clock
原版 ZYBO 125 MHz sysclk、Counter、Clock Enable，以及为什么不随意在 Fabric 中制造野时钟。

### Lab 02 — VGA
640×480 Timing、HS/VS、Blanking、RGB565。视频 Timing 是理解 FPGA Streaming 的好入口。

## Level 1：PS 裸机

### Lab 03 — UART
Processing System 7、PS Init、UART MIO、Vitis Standalone Domain。

### Lab 04 — AXI GPIO
M_AXI_GP0、AXI-Lite、Address Editor、xparameters、Memory-mapped Register。

### Lab 05 — Interrupt
PL Interrupt、IRQ_F2P、GIC、Edge/Level、ISR 最小化。

## Level 2：高速数据

### Lab 06 — AXI DMA
MM2S/S2MM、AXI Memory Mapped、AXI-Stream、HP Port、DDR、Cache Flush/Invalidate。

这是 Zynq 学习的分水岭。

## Level 3：板载外设

- Lab 07 XADC；
- Lab 08 SSM2603 Audio；
- Lab 09 HDMI Dual-role；
- Lab 10 Ethernet；
- Lab 11 SD/QSPI Boot。

## Level 4：系统软件

- Lab 12 FreeRTOS；
- Lab 13 PetaLinux；
- Lab 14 PYNQ；
- Lab 15 Dual-core AMP。

## 建议时间

如果已有 MCU/嵌入式背景：

- Level 0：2~3 天；
- Level 1：3~5 天；
- Level 2：3~7 天；
- Level 3：2~3 周；
- Level 4：2~4 周。

不要以看完文档为验收，必须完成每个 Lab 的 Acceptance。
