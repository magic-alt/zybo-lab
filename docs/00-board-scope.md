# 00 — 原版 ZYBO 边界与 Z7 防混淆

## 本仓库只针对哪块板

目标是 2014~2017 年间常见的 Digilent ZYBO Rev B/C 系列：

- Zynq-7000 XC7Z010-1CLG400C；
- 512 MB DDR3；
- 板载 VGA；
- 单个可切换 Source/Sink 的 HDMI；
- SSM2603 Audio Codec；
- 6 个 Pmod；
- JA 同时引出 XADC；
- PL 外部 sysclk 125 MHz。

## 为什么不能把 Zybo Z7 教程直接照搬

Zybo Z7 虽然名字接近，Z7-10 甚至仍然是 XC7Z010，但板级设计已经改变。

| 项目 | 原版 ZYBO | Zybo Z7 |
|---|---|---|
| VGA | 板载 DB-15 | 移除，通常用 Pmod VGA |
| HDMI | 单口 Source/Sink 复用 | 独立 HDMI in / out |
| 摄像头 | 无 MIPI Pcam connector | Z7 增加 Pcam |
| Pmod | 6 个 | Z7-10 数量/布局不同 |
| board part | zybo | zybo-z7-10 / zybo-z7-20 |
| XDC | ZYBO_Master.xdc | Zybo-Z7 系列 XDC |

因此，本仓库所有板级 XDC 都以原版 ZYBO 为准。

## 快速外观检查

看到以下组合，基本可以确定是原版：

1. 有 VGA；
2. HDMI 只有一个；
3. 六个 Pmod；
4. 丝印为 ZYBO；
5. FPGA package 为 CLG400，Zynq-7010。

## Revision 注意事项

Digilent 历史资料同时存在 Rev B / Rev C preset。课程的纯 PL GPIO/VGA pin mapping 依据公开 ZYBO_Master.xdc；涉及 DDR/PS preset 时，应优先使用实际 board revision 对应 preset，并逐项核对。

## 核心官方依据

- 原版手册  
  https://reference.digilentinc.com/_media/reference/programmable-logic/zybo/zybo_rm.pdf
- 原版 Digilent 工程  
  https://github.com/Digilent/ZYBO
- 原版 Master XDC  
  https://github.com/Digilent/ZYBO/blob/master/Resources/XDC/ZYBO_Master.xdc
- Digilent Vivado board files  
  https://github.com/Digilent/vivado-boards/tree/master/new/board_files/zybo
- Z7 发布时的差异说明  
  https://digilent.com/blog/introducing-the-zybo-z7/
