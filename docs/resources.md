# Resources — 原版 ZYBO 资料地图

资源按 **原版适用性、教学价值、时代/工具版本** 分类，而不是看到 Zybo 就收录。

## A — 原版官方必读

### Digilent ZYBO Reference Manual
https://reference.digilentinc.com/_media/reference/programmable-logic/zybo/zybo_rm.pdf

原版 Board Architecture、Power、Boot、MIO、HDMI、VGA、Audio、XADC、Pmod 的最高优先级参考。

### Digilent/ZYBO
https://github.com/Digilent/ZYBO

原版官方 Demo 源代码。重点目录：
- Projects/dma
- Projects/XADC
- Projects/hdmi_in
- Projects/hdmi_out
- Projects/linux_bd
- Projects/sdsoc

### Original Master XDC
https://github.com/Digilent/ZYBO/blob/master/Resources/XDC/ZYBO_Master.xdc

原版 PL Pin 公开基准。不要用 Z7 XDC 替代。

### Digilent Vivado Board Files
https://github.com/Digilent/vivado-boards

关注 new/board_files/zybo/B.3。

## B — 系统级教材

### The Zynq Book
https://www.zynqbook.com/

24 章系统教材，覆盖 Zynq Architecture、AXI、Embedded Software、Linux、HLS 等。

### The Zynq Book Tutorials
https://www.zynqbook.com/downloads/The_Zynq_Book_Tutorials_Aug_15.pdf

五个实践教程，并明确用 Zybo / ZedBoard 图标区分板级步骤。虽然 GUI 属于早期 Vivado/SDK，但教学结构仍非常好。

### AMD UG585 — Zynq-7000 TRM
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM

MIO/SLCR/GIC/Timer/DMA/DDR/Boot 的根参考。

### AMD UG1165 — Zynq-7000 Embedded Design Tutorial
https://docs.amd.com/r/en-US/ug1165-zynq-embedded-design-tutorial

现代 Zynq-7000 工具流程。示例板不一定是 ZYBO，但 PS/PL/AXI/Vitis 方法可迁移。

## C — 原版入门与工程例程

### sunsided/zybo-tutorial
https://github.com/sunsided/zybo-tutorial

2014 年 Original ZYBO Quick-start，使用 ISE14/PlanAhead/XPS/SDK，包含：
- New Project；
- User IP；
- Constraint；
- Synthesis/Bitstream；
- Processing System。

它很老，但非常适合看 Zynq 工具链从 XPS/PlanAhead 到 Vivado IP Integrator 的演化。

### coldnew/zybo-examples
https://github.com/coldnew/zybo-examples

Original ZYBO，至少包含：
- PL LED Flash；
- PS + PL LED；
- Boot Linux。

README 指向繁体中文系列文章，适合和本仓库 Lab 00/03/05/13 对照。

### coldnew/zybo-templates
https://github.com/coldnew/zybo-templates

基于 Digilent/ZYBO，保存多个 Vivado 版本的 Zybo Board File、XDC 和可重建 Tcl；对于研究“旧原厂工程怎样跨 Vivado 版本迁移”很有价值。

## D — Linux / PetaLinux

### Digilent/Petalinux-Zybo
https://github.com/Digilent/Petalinux-Zybo

原版官方 BSP，PetaLinux 2017.4。包括：
- Ethernet + Unique MAC + DHCP；
- USB Host；
- UIO buttons/switches/LEDs；
- SSH；
- On-board GCC；
- HDMI KMS。

### Digilent/Zybo-base-linux
https://github.com/Digilent/Zybo-base-linux

原版 Vivado 2017.2 Hardware Design，是 Petalinux-Zybo 的硬件侧参考。

### zybo_linux_setup_doc
https://github.com/jinchenglee/zybo_linux_setup_doc

Original Zynq-7010，PetaLinux/Vivado 2017.4；内容包括 SD 双分区、Initramfs、Linaro/Ubuntu/Debian Rootfs。

### PetaLinux2022.2_Zybo_example
https://github.com/StevenKnudsen/PetaLinux2022.2_Zybo_example

搜索得到的较新 Original Zybo PetaLinux 示例。仓库说明较少，适合作为版本迁移线索，而不是主要教材。

## E — PYNQ / Python

### PYNQ-ZYBO
https://github.com/nick-petrovsky/PYNQ-ZYBO

明确支持 Retired Original Zybo，提供 PYNQ 3.0.1 Build/Image 路线，并处理 Original Board Ethernet MAC / I2C 差异。

### Ween's Lab — PYNQ on ZYBO
https://weenslab.gitbook.io/pages/fpga-tutorials/fpga-boards-getting-started/getting-started-with-pynq-on-zybo

AXI GPIO、AXI DMA Loopback、BIT/HWH/Tcl、Python 控制，适合 Lab 14。

### 2026 Legacy Zybo PYNQ Boot/WiFi Guide
https://mummanajagadeesh.github.io/blogs/setting-up-pynq/

2026 年针对 xc7z010clg400-1 Original Zybo 的实操记录，说明旧板仍可以运行较新的 PYNQ 软件栈，但需要专门 BSP/Image 和网络处理。

## F — AMP / 多核

### xupsh/Amp-zynq
https://github.com/xupsh/Amp-zynq

Original ZYBO，CPU0 Linux + CPU1 Bare-metal + Shared Memory，Vivado 2015.2。对应 Lab 15。

### Javier-varez/zybo_petalinux_AMP
https://github.com/Javier-varez/zybo_petalinux_AMP

可作为 PetaLinux + AMP 的补充搜索入口。使用前必须核实工具版本和目标板 revision。

## G — 社区模板与历史 Linux

### binarycourse/zybo-templates
https://github.com/binarycourse/zybo-templates

Original ZYBO Template，可参考硬件/软件项目组织。

### OpenWrt — Digilent Zybo
https://openwrt.org/toh/hwdata/digilent/digilent_zybo

说明 Original ZYBO 仍在现代 Linux/OpenWrt Target 数据中。不是入门主线。

## H — Z7 资料：只用于迁移思想，不作为板级来源

### Introducing the Zybo Z7
https://digilent.com/blog/introducing-the-zybo-z7/

Digilent 对 Original Zybo → Z7 的 HDMI/VGA/Pmod/Pcam 变化说明。

Zybo Z7 的 DMA/XADC/HDMI 教程可以用来学习较新 Vivado 操作，但必须遵守：

- 不复制 Z7 XDC；
- 不复制 Z7 Audio Pin；
- 不把双 HDMI In/Out 当成原版单 HDMI Dual-role；
- 不把 Pcam/MIPI 内容当原版功能；
- 若引用，必须标记 Z7-derived / migration-required。

## I — 资源可信度分级

| 等级 | 含义 | 使用方式 |
|---|---|---|
| A | Digilent/AMD 官方 Original ZYBO | 可作为板级/架构依据 |
| B | The Zynq Book、成熟社区 Original 教程 | 可作为课程教材，板级信息仍与官方交叉确认 |
| C | 个人 Original 项目 | 作为案例和迁移线索 |
| D | Zybo Z7 项目 | 只借鉴工具/架构思想，不直接用 Pin/BSP |

本仓库正文优先把 A/B 级资料重构成可执行 Lab；C/D 级资料放在延伸阅读或 Migration Notes。
