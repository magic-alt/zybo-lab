# Lab 07 — XADC on JA

## Why

原版 ZYBO 的 JA 同时提供 XADC Differential Auxiliary Inputs，是学习 Mixed-signal FPGA 的低成本入口。

## 原版 JA XADC Channels

Digilent Master XDC 显示：

- JA1 Pair → AD14；
- JA2 Pair → AD7；
- JA3 Pair → AD15；
- JA4 Pair → AD6。

## Safety

XADC 输入不是“任意 3.3 V ADC”。上板前先阅读 Zynq-7000 XADC 文档和 ZYBO Reference Manual，确认允许输入范围、Common-mode、Reference 和 Source Impedance。

## Phase A — Pure PL

- XADC Wizard；
- Sequencer 或 Single Channel；
- DRP Read；
- Sample Value → PWM → LED Brightness。

## Phase B — PS Control

- XADC Data → AXI Readable Register/FIFO；
- PS 周期读取并 UART 输出；
- 做 Offset/Gain Calibration。

## Phase C — DMA

- Sample Trigger；
- Stream Pack；
- AXI DMA → DDR；
- PC/Python Plot。

## Acceptance

- 输入多个已知电压点时 Raw Code 单调；
- 记录 Raw Code 与换算值；
- 至少 1000 Sample，计算 Mean/Std；
- 能区分量化噪声、Reference 和模拟前端误差。

## Original Reference

https://github.com/Digilent/ZYBO/tree/master/Projects/XADC
