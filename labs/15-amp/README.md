# Lab 15 — Dual Cortex-A9 AMP

## Goal

让 Zynq-7010 两个 Cortex-A9 运行不同软件栈：

- CPU0：Linux；
- CPU1：Bare-metal / RTOS。

历史 Original ZYBO 实例：

https://github.com/xupsh/Amp-zynq

## Topics

- CPU Start/Stop；
- Memory Partition；
- Shared DDR；
- OCM；
- Cache Coherency；
- Inter-core Interrupt；
- Resource Ownership；
- Remoteproc/OpenAMP 的现代替代思路。

## Minimal Exercise

CPU1：
- 1 kHz Heartbeat；
- 写 Shared-memory Counter。

Linux CPU0：
- mmap Reserved Memory；
- 每秒读 Counter；
- 检测 Monotonicity。

## Cache Warning

两个 CPU 都看到同一物理地址，不代表软件自动 Cache Coherent。

必须明确：
- Memory Attributes；
- Cache Maintenance；
- Barrier；
- Ownership Protocol。

## Acceptance

- Linux 稳定运行；
- CPU1 Independent Heartbeat；
- Shared Data 正确；
- 运行 1 小时无 Stale Data；
- 写一页 Coherency Analysis。
