# Lab 08 — SSM2603 Audio + I2S + DMA

## 原版板卡警告

这是最容易被 Zybo Z7 Pinout 坑到的 Lab。

原版 ZYBO Master XDC 的 Audio Pins：

| Signal | Pin |
|---|---|
| BCLK | K18 |
| MCLK | T19 |
| MUTEN | P18 |
| PBDAT | M17 |
| PBLRC | L17 |
| RECDAT | K17 |
| RECLRC | M18 |
| SCL | N18 |
| SDA | N17 |

不要复制 Zybo Z7 DMA Demo 的 Audio Pin。

## Architecture

~~~text
SSM2603 ADC
  |
I2S RX
  |
AXI-Stream
  |
AXI DMA S2MM
  |
DDR
  |
AXI DMA MM2S
  |
I2S TX
  |
SSM2603 DAC
~~~

控制面：I2C 配 Codec，CPU 配 DMA 和 Buffer。

## Bring-up 顺序

1. MCLK；
2. I2C Scan / Codec Register Write；
3. MUTE Control；
4. BCLK/LRCLK；
5. I2S TX 固定 Tone；
6. Headphone；
7. I2S RX；
8. DMA Capture；
9. Playback；
10. Full-duplex / DSP。

## I2S 必须理解

I2S 与 Left-justified 不同：LRCLK Edge 后，MSB 通常有一个 BCLK Delay。

## Acceptance

最小目标：
- 48 kHz；
- Line-in Capture；
- DDR Buffer；
- Headphone Playback。

进阶：
- 直通 Latency Measurement；
- FIR；
- FFT Spectrum；
- Audio over Ethernet。

## Original Reference

https://github.com/Digilent/ZYBO/tree/master/Projects/dma
