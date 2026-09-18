# Lab 04 — AXI GPIO：PS 控制 PL

## Objectives

第一次真正理解 PS↔PL：M_AXI_GP0、AXI-Lite、Address Map 和 xparameters。

## Block Design

~~~text
Cortex-A9
  |
M_AXI_GP0
  |
AXI Interconnect / SmartConnect
  |
AXI GPIO
  |
LED[3:0]
~~~

AXI GPIO Channel 1：Width = 4，All Outputs。把 External Port 约束到原版 ZYBO LED Pin。

## Software

src/main.c 使用 XGpio Driver。若 IP Instance 不是 axi_gpio_0，需要根据生成的 xparameters.h 修改 Device ID 宏。

## Acceptance

- 4-bit Binary Counter 每 250 ms 更新；
- 能在 Address Editor 说明 GPIO Base Address；
- 能在 xparameters.h 找到同一地址。

## Extension

不用 XGpio，改用 Xil_Out32 直接写 Base Address + Register Offset，理解 Driver 与 MMIO 的关系。


## Reproducible Vivado build

~~~bash
make vivado-lab04
make vivado-bd-lab04
~~~

The Tcl creates PS7 + M_AXI_GP0 + 4-bit AXI GPIO and fixes the control window at 0x4120_0000. Outputs are under build/lab04/.
