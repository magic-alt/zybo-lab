# 06 — Embedded Linux Hands-on Tutorial 的现代映射

## 为什么单独保留这份旧教程

Digilent 的 Embedded Linux Hands-on Tutorial for the ZYBO 是 Original ZYBO 时代少数把 **PL Hardware → Boot → Kernel → Device Tree → Driver → User Application** 串成完整链路的官方教材。

它的 GUI、Kernel Branch 和构建命令已经过时，但系统分层没有过时。

## 旧教程应该学什么，不应该照抄什么

### 应该保留

- PS/PL Hardware Description 是 Linux 的硬件事实来源；
- FSBL 负责早期 Zynq 初始化；
- U-Boot 负责第二阶段引导；
- Kernel 依赖 Device Tree 描述板级硬件；
- PL Peripheral 最终要通过 Driver 或 UIO 暴露给 Userspace；
- Debug 要跨 Hardware / Bootloader / Kernel / Driver / Application 分层。

### 不应该直接照抄

- 2014 年 Vivado GUI 路径；
- 旧 Linux-Digilent-Dev Branch；
- 旧 DTS Syntax 中已经被 Mainline Binding 取代的写法；
- 旧 Bootargs；
- 固定版本 U-Boot/Kernel Patch；
- 旧版 SDK/HDF Handoff。

## 映射到本仓库

| Old tutorial concept | zybo-lab |
|---|---|
| Board hardware customization | Lab 03/04/05 |
| AXI peripheral | Lab 04 |
| Boot image | Lab 11 |
| FSBL | Lab 11 |
| U-Boot/Linux boot | Lab 13 |
| Device Tree | Lab 13 |
| Userspace MMIO / UIO | Lab 13 |
| Driver boundary | Lab 13 extension |
| Data-plane accelerator | Lab 06 + Lab 13 extension |

## Modern Rebuild Exercise

### Step 1 — Minimal Hardware

先只做：

~~~text
Zynq PS
  |
M_AXI_GP0
  |
AXI GPIO
  |
LED[3:0]
~~~

生成当前 Vivado 的 XSA。

### Step 2 — Boot Linux

使用与你当前 AMD 工具链匹配的 PetaLinux/Yocto 流程，新建工程，不升级旧 Project。

第一阶段只要求：

- UART Console；
- SD Boot；
- Ethernet；
- SSH。

### Step 3 — Device Tree

确认 AXI GPIO 的：

- Compatible；
- Reg Base/Size；
- Interrupt（若启用）；
- Clock/Reset Dependency。

把 Address Editor、XSA、DTS 和 /proc/iomem 对起来。

### Step 4 — UIO

先通过 UIO 完成 Userspace LED 控制：

~~~text
Device Tree
  -> UIO Platform Driver
  -> /dev/uio0
  -> mmap
  -> AXI GPIO Register
~~~

这一步成功后，再考虑写专用 Kernel Driver。

### Step 5 — Interrupt

让 BTN/AXI GPIO Interrupt 进入 Linux Userspace Poll，验证：

- PL Source；
- GIC；
- Device Tree IRQ；
- UIO；
- Userspace Event。

### Step 6 — DMA Extension

最后把 Lab 06 的 AXI DMA 引入 Linux：

- Reserved/CMA Buffer；
- Cache / DMA API；
- Interrupt；
- Buffer Ownership；
- Throughput。

## 验收

完成后应该能够解释：

1. XSA 和 Device Tree 各描述什么；
2. FSBL、U-Boot、Kernel 分别在哪个阶段工作；
3. AXI Base Address 如何从 Vivado 传到 Linux；
4. UIO 与专用 Kernel Driver 的边界；
5. DMA 为什么不能像普通 GPIO 一样只 mmap 几个寄存器就结束。
