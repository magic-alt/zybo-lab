# Lab 13 — PetaLinux

## Two Modes

### Legacy Reproduce

Digilent/Petalinux-Zybo：

https://github.com/Digilent/Petalinux-Zybo

目标版本 PetaLinux 2017.4。用于理解 Original BSP、Ethernet、USB、UIO、HDMI/KMS、SSH。

### Modern Rebuild

推荐：

1. 当前 Vivado 生成最小 XSA；
2. 当前 PetaLinux 新建 Project；
3. Import Hardware；
4. 先 Console + Ethernet；
5. 再加 PL UIO；
6. 再迁移 Video/Audio。

## First Linux PL Device

建议 Block Design：PS + AXI GPIO。

Device Tree 将简单 PL Peripheral 暴露给 UIO。Userspace：

- Open /dev/uio0；
- mmap；
- Write LED Register；
- 可选 Poll Interrupt。

## Acceptance

- SD Boot Linux；
- UART Login；
- DHCP/Static IP；
- SSH；
- /dev/uioX；
- Userspace 控 LED；
- 能说明 Virtual/Physical Address 差异。

## Additional Original-Zybo References

- https://github.com/jinchenglee/zybo_linux_setup_doc
- https://github.com/StevenKnudsen/PetaLinux2022.2_Zybo_example
