# Lab 10 — Gigabit Ethernet + lwIP

## Goals

1. PHY Link；
2. DHCP 或 Static IP；
3. Ping；
4. TCP Echo；
5. UDP Throughput；
6. PL Data → DMA → DDR → Network。

## Bare-metal Bring-up

在 Vitis Standalone Domain 中使用当前版本 lwIP Example 或等价模板。

Checklist：

- GEM；
- MDIO/MDC；
- PHY Address；
- Clock；
- MAC Address；
- Cache；
- lwIP Heap；
- Link Speed Negotiation。

## 原版板卡细节

原版 Zybo 的历史 Linux/PYNQ 支持中有专门的 Unique MAC / I2C 处理。因此不要把“PHY Link 灯亮”当作网络配置完成。

## Acceptance

- PC Ping 1000 Packets；
- TCP Echo；
- UDP 统计 Packet Loss；
- 记录 Bare-metal Throughput 和 CPU Utilization。

## Extension

把 Lab 07/08 的数据流通过 DMA 收到 DDR，再通过 UDP 发到 PC。
