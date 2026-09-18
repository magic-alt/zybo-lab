# Lab 00 — Pure PL GPIO

## Objectives

- 验证 Vivado/JTAG/XDC；
- 学会最小 Verilog Module；
- 建立“先验证 PL，再进入 PS”的调试习惯。

## Architecture

~~~text
SW[3:0] ----+
             XOR ----> LED[3:0]
BTN[3:0] ---+
~~~

按键和开关全部是 PL Pin，不依赖 ARM、DDR 或软件。

## Build

~~~bash
make sim-gpio
vivado -mode batch -source scripts/create_lab00.tcl
~~~

## Acceptance

1. 仿真 PASS；
2. Bitstream 可以 JTAG 下载；
3. LED = SW xor BTN；
4. 四路全部验证。

## Why XOR

比 LED=SW 多一步，能同时确认两组输入 Constraint 和逻辑确实重新综合。

## Extension

- 2:1 Mux；
- BTN0 作为 Enable；
- Debounce；
- LED PWM Brightness。
