# 03 — Zynq-7000 架构速查

## PS 与 PL

Zynq-7010 = Processing System + Programmable Logic。

PS 包含 Dual Cortex-A9、DDR Controller、OCM、GIC、Timers，以及 UART/SPI/I2C/CAN/SDIO/USB/Ethernet 等。

PL 是 7-series FPGA Fabric：LUT/FF、BRAM、DSP48、MMCM/PLL、XADC 和自定义逻辑/IP。

## MIO 与 EMIO

**MIO**：PS Peripheral 直接走 Dedicated Pins。  
**EMIO**：PS Peripheral 信号先进入 PL，再由 PL Routing 到外部或逻辑。

## AXI 三个最重要概念

### AXI4-Lite
低带宽寄存器控制。典型：PS → AXI GPIO → LED。

### AXI4 Memory Mapped
高吞吐地址空间访问。典型：AXI DMA → HP0 → DDR。

### AXI4-Stream
没有地址，只传数据流。典型：ADC/I2S/Video → AXIS FIFO → DMA。

## GP / HP / ACP

推荐顺序：

1. M_AXI_GP0：PS Master 访问 PL 寄存器；
2. S_AXI_HP0：PL Master/DMA 访问 DDR；
3. ACP：真正需要 Cache Coherent 场景时再学。

## Interrupt

PL Peripheral 可通过 IRQ_F2P 进入 PS GIC。需要同时理解 Source Edge/Level、Peripheral Status/Enable/Clear、GIC Trigger Type、CPU Exception 和 ISR。

## Cache

DMA 是常见 Bug 来源。

CPU 写 TX Buffer 后，DMA 读 DDR 前要 Flush Cache。  
DMA 写 RX Buffer 后，CPU 读之前要 Invalidate Cache。

出现“DMA 偶尔正确、加个 printf 就变了”时，优先检查 Cache、Alignment、TLAST 和 Buffer Ownership。
