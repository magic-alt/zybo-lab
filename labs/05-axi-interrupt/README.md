# Lab 05 — AXI GPIO Interrupt + GIC

## Architecture

~~~text
BTN[3:0]
   |
AXI GPIO
   |
ip2intc_irpt
   |
IRQ_F2P
   |
GIC
   |
Cortex-A9 ISR
~~~

## Objectives

理解完整中断链：

1. Peripheral Event；
2. Peripheral Status；
3. Local/Global Enable；
4. PL→PS Interrupt Net；
5. GIC Config；
6. CPU Exception；
7. ISR；
8. Source Clear。

## Software

不同 Vivado/Vitis 版本生成的 Interrupt Macro 名称可能不同。先在 xparameters.h 搜索 GPIO 和 INTR，再确认示例中的 GPIO_IRPT_ID。

## Acceptance

- 按键时进入 ISR；
- ISR 只记录 Pending/Value 并 Clear；
- 主循环打印事件；
- 长按不会造成失控 Interrupt Storm。

## Debug

ILA 同时观察 Button、ip2intc_irpt 和 AXI Clear。
