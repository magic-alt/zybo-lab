# 04 — 调试方法

按层排查，不要一上来怀疑工具 Bug。

## 1. Power / Boot Mode
检查 Power-good、JP7 供电来源、JP5 Boot Mode；修改 Boot Mode 后要真正 Power-cycle。

## 2. JTAG / Device
Vivado Hardware Manager 能否稳定识别 xc7z010。

## 3. PS UART
确认串口、Baud、UART MIO 和 PS Init。

## 4. PL Static IO
先跑 Lab 00：SW→LED。它不依赖 PS、DDR、Vitis。

## 5. Clock / Reset
ILA 先看 Clock 是否在跑、Reset 是否释放、AXI aresetn 是否同步。

## 6. AXI-Lite
检查 Address Editor、当前 XSA 的 Base Address、Ready/Valid 握手。

## 7. Interrupt
逐级检查 Peripheral Status、Local Enable、Global Enable、IRQ_F2P、GIC Enable、CPU Exception Enable。

## 8. DMA
优先检查：

- Simple / SG Mode；
- MM2S/S2MM 方向；
- TLAST；
- HP Port Clock；
- DDR Address；
- Cache；
- Alignment；
- Transfer Length。

## ILA 建议探针

AXI-Stream：tvalid、tready、tdata、tlast。  
AXI-Lite：AW/W/B/AR/R 五通道的 Valid/Ready。

## 经典故障

### Bitstream 能下，软件不跑
看 PS Init、DDR、Reset、ELF 下载地址、Platform 是否来自当前 XSA。

### VGA 黑屏
看 sysclk constraint、25 MHz pixel cadence、HS/VS polarity、blanking。

### HDMI 不工作但 VGA 正常
原版 ZYBO HDMI 是 Dual-role，必须理解 HDMI_OUT_EN、DDC、HPD 方向，不能套 Z7 独立 TX 思维。

### Audio 没声音
检查原版 Audio Pins、MUTE、MCLK、I2C Codec Registers、BCLK/LRCLK、I2S one-bit delay。
