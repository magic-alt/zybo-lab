# 原版 Digilent/ZYBO 工程解剖

Digilent 历史仓库是理解原版 ZYBO 最有价值的工程考古现场：

https://github.com/Digilent/ZYBO

## XADC — Projects/XADC

原版 JA/XADC pin、XADC Wizard/DRP、Analog Input → Digital Logic。与 Lab 07 对照。

## DMA — Projects/dma

SSM2603、AXI DMA、DDR Buffer、PS 控制数据通路、Audio Record/Playback。

## HDMI Out — Projects/hdmi_out

原版双角色 HDMI Source、VDMA、VTC、Framebuffer、Display Controller。

## HDMI In — Projects/hdmi_in

HDMI Sink、Input Video、VDMA/Framebuffer、DDC/HPD。

## Linux BD — Projects/linux_bd

Linux Hardware Platform、Digilent 自定义 IP、Audio/Video，以及后续 Zybo-base-linux / Petalinux-Zybo 的历史背景。

## SDSoC — Projects/sdsoc

用于理解早期 C/C++ Kernel 下沉 PL 的工具思想，不作为今天的第一学习路径。

## 正确使用方式

不要只打开旧工程点 Generate Bitstream。每个工程都做一次 Architecture Reverse Engineering：

1. 画 PS / Interconnect / Peripheral / DDR 数据流；
2. 标 GP/HP Port；
3. 标每个 Clock Domain；
4. 标 Reset；
5. 标 Interrupt；
6. 标软件负责配置哪些 Register；
7. 找 DMA Buffer；
8. 找 Cache Maintenance；
9. 找板级 Pin；
10. 再在新 Vivado 从空工程复刻。
