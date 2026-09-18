# 01 — 工具链策略

教学仓库采用 **现代学习 + 旧工程复现** 双轨制。

## Track A — Modern Learning

适合从零学习和新写工程：

- Vivado / Vitis 2026.1；
- part：xc7z010clg400-1；
- board file 可选；
- PS preset 若自动化不可用，按 Reference Manual / Preset 核对 MIO、DDR；
- Block Design 尽量脚本化；
- RTL/XDC/Tcl 纳入 Git；
- 软件用当前 BSP Driver API，同时理解最终都是 MMIO。

AMD 2026.1 仍提供 Zynq-7000 Embedded Design Tutorial，因此 Zynq-7000 仍可用现代工具学习。

## Track B — Legacy Reproduction

| 资料 | 典型版本 |
|---|---|
| The Zynq Book Tutorials | Vivado/SDK 2014.x 时代 |
| Digilent ZYBO hdmi_in/out | SDK 2015.4 |
| Digilent DMA | SDK 2016.2 |
| Zybo-base-linux | Vivado 2017.2 |
| Petalinux-Zybo | PetaLinux 2017.4 |
| 社区 Linux setup | Vivado/PetaLinux 2017.4 |

Legacy 的价值不是长期依赖旧 IDE，而是回答：

- 原厂如何连接 PS、VDMA、I2S、HDMI；
- DDR / AXI HP port 为什么这样连；
- FSBL / BOOT.BIN / Device Tree 怎样工作；
- Digilent 自定义 IP 的设计意图。

## Board File

Digilent vivado-boards 中仍保留原版 zybo/B.3。

安装后可在 Tcl Console 检查：

~~~tcl
get_board_parts *zybo*
~~~

找不到也不影响课程，可直接按 part 建工程。

## 不建议

- 使用 Z7 board file；
- 从 2015.4 工程一路点 Upgrade 到 2026.1；
- 把 generated HDL wrapper、runs、cache 当源码；
- PetaLinux 跨多年直接 Project Upgrade；
- 只会 Run Block Automation，却说不清 AXI 地址、Clock 和 Reset。
