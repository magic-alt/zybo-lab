# Lab 01 — 125 MHz Clock

## Objectives

- 使用原版 ZYBO 的 125 MHz PL sysclk；
- 理解 Counter 与 Clock Enable；
- 理解 create_clock Constraint。

125 MHz → Counter → 每 0.5 s Toggle LED → 1 Hz 完整闪烁周期。

## Build

~~~bash
make sim-blink
~~~

Vivado 中将 blink.v 设为 Top，添加 zybo.xdc。

## Acceptance

- LED0 约 1 Hz；
- Timing Report 中主时钟周期为 8 ns；
- 不存在 Unconstrained Primary Clock。

## Pitfall

不要把 Counter 某一位拿去当另一个 Always Block 的 Clock。入门阶段统一使用同一个 Clock + Clock Enable。
