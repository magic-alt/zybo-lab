# Lab 14 — PYNQ on Retired ZYBO

## Why

PYNQ 很适合把硬件 Accelerator 变成 Python 可交互对象。

社区已有明确支持 Retired Original Zybo 的 PYNQ 3.0.1 Port：

https://github.com/nick-petrovsky/PYNQ-ZYBO

2026 年也仍有针对 Legacy Zybo xc7z010clg400-1 的 PYNQ 启动与网络配置实践：

https://mummanajagadeesh.github.io/blogs/setting-up-pynq/

## Recommended First Overlay

~~~text
Zynq PS
  + AXI GPIO -> LED
  + AXI DMA
       MM2S -> AXIS FIFO -> S2MM
~~~

导出 BIT + HWH，必要时保留 Tcl。

## Notebook Exercises

1. MMIO Read/Write；
2. LED；
3. DMA 256 Words；
4. NumPy Compare；
5. Throughput；
6. Interrupt；
7. Custom RTL Kernel。

## Important Original-Zybo Issue

社区 Port 专门处理 Original Board 的 Ethernet MAC / I2C 差异。不要直接把 Z7 PYNQ Image 当成原版 Zybo Image。

## Acceptance

- Jupyter Reachable；
- Overlay Load；
- LED；
- DMA Loopback；
- NumPy Throughput Benchmark。
