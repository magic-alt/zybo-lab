# Resources — 原版 ZYBO 资料地图

资源按 **原版适用性、教学价值、时代/工具版本** 分类，而不是看到 Zybo 就收录。

## 1. 必读官方板卡资料

### Digilent ZYBO Reference Manual
https://reference.digilentinc.com/_media/reference/programmable-logic/zybo/zybo_rm.pdf

用途：Board Architecture、Power、Boot、MIO、HDMI、VGA、Audio、XADC、Pmod。原版最高优先级。

### Digilent/ZYBO
https://github.com/Digilent/ZYBO

用途：原版 Demo、DMA/XADC/HDMI/Linux/SDSoC、旧 SDK C Code、Tcl/BD。

### Master XDC
https://github.com/Digilent/ZYBO/blob/master/Resources/XDC/ZYBO_Master.xdc

用途：原版 PL Pin 公开基准。不要用 Z7 XDC 替代。

### Digilent vivado-boards
https://github.com/Digilent/vivado-boards

关注 new/board_files/zybo/B.3。

## 2. Zynq 系统级教材

### The Zynq Book
https://www.zynqbook.com/

24 章系统教材；免费 PDF；Tutorial 明确包含 Zybo-specific 步骤。

### The Zynq Book Tutorials
https://www.zynqbook.com/downloads/The_Zynq_Book_Tutorials_Aug_15.pdf

从 PS/PL、IP Integrator、软件到系统；文中用 Zybo 图标标识板卡差异。GUI 已旧，但架构值得学习。

### AMD UG585 — Zynq-7000 TRM
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM

MIO/SLCR/GIC/Timer/DMA/DDR/Boot 的根参考。

### AMD UG1165 — Zynq-7000 Embedded Design Tutorial
https://docs.amd.com/r/en-US/ug1165-zynq-embedded-design-tutorial

现代 Zynq-7000 教学流程；示例板未必是 ZYBO，但体系适用。

## 3. 原版 Linux / PetaLinux

### Digilent/Petalinux-Zybo
https://github.com/Digilent/Petalinux-Zybo

原版，PetaLinux 2017.4，适合 Legacy Reproduction。

### Digilent/Zybo-base-linux
https://github.com/Digilent/Zybo-base-linux

原版，Vivado 2017.2 Hardware Design。

### zybo_linux_setup_doc
https://github.com/jinchenglee/zybo_linux_setup_doc

原版 Zynq-7010；PetaLinux/Vivado 2017.4；SD Partition 与 Ubuntu/Debian Rootfs 思路。

## 4. PYNQ

### PYNQ-ZYBO
https://github.com/nick-petrovsky/PYNQ-ZYBO

明确支持 Retired Original Zybo；包含 PYNQ 3.0.1、Image/Build Path，并处理 Original Board Ethernet MAC/I2C 差异。

### Ween's Lab — PYNQ on ZYBO
https://weenslab.gitbook.io/pages/fpga-tutorials/fpga-boards-getting-started/getting-started-with-pynq-on-zybo

AXI GPIO、AXI DMA、BIT/HWH/Tcl、Python 验证。

## 5. 历史 Quick-start

### sunsided/zybo-tutorial
https://github.com/sunsided/zybo-tutorial

2014、ISE/PlanAhead 时代、原版 Zynq-7010；用于理解工具历史，不作为现代主线。

## 6. AMP / 多核

### xupsh/Amp-zynq
https://github.com/xupsh/Amp-zynq

原版 ZYBO；CPU0 Linux + CPU1 Bare-metal；Shared Memory；Vivado 2015.2。对应 Lab 15。

## 7. 社区模板

### binarycourse/zybo-templates
https://github.com/binarycourse/zybo-templates

原版 ZYBO Template，可参考硬件/软件项目组织。

## 8. 现代 OS 资源

### OpenWrt — Digilent Zybo
https://openwrt.org/toh/hwdata/digilent/digilent_zybo

说明 Original ZYBO 仍存在于现代 Linux/OpenWrt 生态；不是入门主线。

## 9. 原版与 Z7 差异

### Introducing the Zybo Z7
https://digilent.com/blog/introducing-the-zybo-z7/

Digilent 自己说明 Original Zybo → Z7 的 HDMI/VGA/Pmod/Pcam 变化。

## 10. 可以借鉴但必须移植的 Z7 资料

Zybo Z7 的 DMA/XADC/HDMI 教程可用来学习新工具操作，但：

- 不能复制 XDC；
- Audio Pin 不同；
- HDMI 架构不同；
- Camera/Pcam 对原版无效。

未来若收录 Z7-derived 教程，必须标记 migration-required。
