# Lab 12 — FreeRTOS

## Why

在 Bare-metal 与 Linux 之间建立实时系统思维。

## Minimal System

Tasks：
- led_task：100 ms；
- uart_task：Event Log；
- control_task：1 kHz 软件周期实验。

Interrupt：
- AXI GPIO IRQ；
- ISR 只发 Queue/Semaphore。

## Topics

- Task Priority；
- Preemption；
- Tick；
- Queue；
- Semaphore；
- Mutex；
- ISR-safe API；
- Stack Watermark；
- Deadline/Jitter。

## Measurement

用 PL GPIO Pin 或 LED Probe：

1. control_task Entry Toggle；
2. Logic Analyzer 测 Period/Jitter；
3. 增加低优先级负载；
4. 增加高优先级干扰；
5. 解释 Priority Inversion。

## Acceptance

- Queue-driven Button Event；
- ISR 无 printf；
- Control Task 运行 60 s；
- 输出 Min/Max/Mean Period；
- 解释为什么 RTOS Tick 不等于硬实时保证。
