# Capstone Projects

完成 Lab 00~11 后再做综合项目。

## A. Networked Oscilloscope

~~~text
JA XADC
 -> Sample Engine
 -> AXIS FIFO
 -> AXI DMA
 -> DDR
 -> UDP
 -> Python PC Plot
~~~

学习 Fixed Sample Rate、Trigger、Circular Buffer、Packetization、Packet Loss 和 Timestamp。

## B. Audio Spectrum Analyzer

~~~text
SSM2603
 -> I2S RX
 -> DMA
 -> FFT (CPU or PL)
 -> Framebuffer
 -> VGA/HDMI
~~~

分三版：
1. CPU FFT；
2. PL FFT IP；
3. Overlap Streaming + DMA Ping-pong。

## C. Video Frame Processor

HDMI Sink → Capture → Grayscale → Sobel → Display，PS 控 Threshold。

重点：VDMA、Multi-buffer、Bandwidth Budget、Line/Frame Timing。

## D. Dual-core Control Computer

CPU0 Linux：Network/UI/Logging。  
CPU1 FreeRTOS/Bare-metal：Deterministic Control Loop。  
PL：Encoder/PWM/ADC Timing Accelerator。

这是把原版 ZYBO 从“教学板”提升到完整 Zynq 系统设计训练平台的毕业项目。
