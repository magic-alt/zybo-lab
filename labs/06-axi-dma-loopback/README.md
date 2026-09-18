# Lab 06 — AXI DMA Loopback

这是整套课程最重要的实验之一。

## Architecture

~~~text
CPU Buffer in DDR
   |
S_AXI_HP0 <---- AXI DMA MM Side
                  |
        MM2S ----> AXIS FIFO ----> S2MM
                  |
               AXI4-Stream
~~~

控制面：PS M_AXI_GP0 → AXI DMA AXI-Lite Registers。  
数据面：AXI DMA Master → PS HP0 → DDR。

## Hardware Checklist

- AXI DMA Simple Mode；
- MM2S/S2MM 都 Enable；
- MM2S Stream → AXIS FIFO → S2MM Stream；
- DMA Memory Masters 通过 Interconnect 到 S_AXI_HP0；
- AXI-Lite Control 连接 M_AXI_GP0；
- 初版保持统一 Clock/Reset；
- 第一版先 Polling，再扩展 Interrupt。

## Software Sequence

1. 填 TX Buffer；
2. Flush TX Cache；
3. 准备 RX Buffer；
4. 先启动 S2MM；
5. 再启动 MM2S；
6. Polling Busy；
7. Invalidate RX Cache；
8. Compare。

## Acceptance

- 256 Words 逐字一致；
- 改成 4 KB / 64 KB；
- 连续 1000 次无 Mismatch；
- ILA 看到 tvalid/tready/tlast。

## 必做实验

故意删掉 Cache Maintenance，观察错误是否出现。理解 Cache Bug 为什么可能具有随机性，比只背 API 更重要。
