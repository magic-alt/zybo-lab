# 05 — Boot、Linux 与文件组成

## Zynq 启动链

Stage 0：BootROM 根据 Boot Mode 从 QSPI / SD 等读取 Boot Image，把 FSBL 装入 OCM。

Stage 1：FSBL 初始化 PS/DDR，可加载 Bitstream，并加载下一阶段程序。

Stage 2：进入 Bare-metal Application，或 U-Boot → Linux。

## Bare-metal BOOT.BIN

典型内容：

~~~text
FSBL.elf
system.bit
app.elf
~~~

现代工具用 XSA 作为 Hardware Handoff，但 BootROM/FSBL/Partition 的核心概念不变。

## Linux 常见内容

~~~text
BOOT.BIN
image.ub
# 或 Image / uImage + system.dtb + rootfs
~~~

## 原版 ZYBO Legacy PetaLinux

Digilent 保留：

- https://github.com/Digilent/Petalinux-Zybo
- https://github.com/Digilent/Zybo-base-linux

可用于理解原版 Ethernet + DHCP、USB Host、UIO、SSH、HDMI/KMS 和 Device Tree。

## 现代重建原则

不要把 2017.4 完整 Project 原样升级到 2026：

1. 现代 Vivado 重建最小 Hardware；
2. 导出 XSA；
3. 当前 PetaLinux 新建 Project；
4. 导入 XSA；
5. 根据旧 Config/Device Tree 逐项迁移；
6. 每新增一个功能就上板验证。

## UIO 为什么适合教学

UIO 让 Linux Userspace 通过 /dev/uioX + mmap 访问 PL 寄存器，适合先验证 AXI GPIO、自定义 AXI-Lite IP 和 Interrupt，再进入完整 Kernel Driver。
