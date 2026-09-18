# Lab 02 — 原版板载 VGA Pattern Generator

这是原版 ZYBO 的高价值 Lab。Zybo Z7 已移除板载 VGA，因此它也是验证目标板型的好实验。

## Objectives

- 640×480@60 Timing；
- 25 MHz Pixel Cadence；
- HS/VS；
- Active Video / Blanking；
- RGB565。

## Implementation

板上 sysclk = 125 MHz。代码使用 Mod-5 Pixel Enable，让水平/垂直状态每 5 个 sysclk 更新一次，相当于 25 MHz Pixel Cadence。

Timing：

- H active 640
- H front porch 16
- H sync 96
- H back porch 48
- total 800
- V active 480
- V front 10
- V sync 2
- V back 33
- total 525

HS/VS Active-low。

## Test

~~~bash
make sim-vga
~~~

## Hardware Acceptance

1. 显示器识别 640×480；
2. 有稳定彩条；
3. 无滚屏；
4. RGB 在 Blanking 区为 0。

## Extension

- Checkerboard；
- BRAM Framebuffer；
- AXI VDMA；
- PS DDR Framebuffer → VGA。
