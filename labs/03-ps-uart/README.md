# Lab 03 — Processing System + UART

## Objectives

- 建立最小 PS7；
- 使用 DDR/UART；
- 理解 Hardware Handoff → Vitis Platform；
- Cortex-A9 上运行 Standalone C。

## Vivado

1. Create Project：part = xc7z010clg400-1；
2. Create Block Design；
3. Add ZYNQ7 Processing System；
4. 使用原版 ZYBO Preset，或手工核对 DDR / UART1 / MIO；
5. Run Block Automation；
6. Validate Design；
7. Generate Output Products；
8. Create HDL Wrapper；
9. Generate Bitstream；
10. Export XSA，包含 Bitstream。

## Vitis

建立 Standalone Domain，CPU = ps7_cortexa9_0，把 src/main.c 加入 Application。

## Acceptance

串口持续输出 Lab 名称和 Heartbeat Counter。

## Observe

在 XSCT/hw_server 中观察 Cortex-A9 State、PC、Halt/Run，并对比 JTAG Run 与 SD Boot。
