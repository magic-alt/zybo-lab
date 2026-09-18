# Lab 09 — 原版 Dual-role HDMI

## 先理解板级硬件

原版 ZYBO 与 Z7 最大差异之一：

- 原版：**一个 HDMI Connector，可做 Source 或 Sink**；
- Z7：独立 HDMI Input / Output。

原版有方向控制信号 HDMI_OUT_EN，同时 HPD、5V、DDC 的角色随方向变化。

## 推荐学习顺序

### 1. 先完成 VGA

完成 Lab 02，确认 Video Timing 基础。

### 2. HDMI Source

学习：
- Pixel Stream；
- RGB→TMDS；
- DDC；
- HPD；
- VTC；
- Framebuffer / VDMA。

原厂参考：
https://github.com/Digilent/ZYBO/tree/master/Projects/hdmi_out

### 3. HDMI Sink

学习：
- TMDS Receive；
- Lock；
- Video Timing Detect；
- VDMA S2MM；
- DDR Framebuffer。

原厂参考：
https://github.com/Digilent/ZYBO/tree/master/Projects/hdmi_in

## Architecture Exercise

必须自己画两张数据流：

~~~text
Source:
DDR -> VDMA MM2S -> Video Pipeline -> TMDS -> Monitor

Sink:
HDMI -> TMDS Decode -> Video -> VDMA S2MM -> DDR
~~~

## Acceptance

Source：
- 640×480；
- 800×600；
- Framebuffer Test Pattern。

Sink：
- 能检测 Resolution；
- 抓一帧到 DDR；
- 软件修改部分 Pixel 后再显示。
