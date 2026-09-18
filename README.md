# zybo-lab

面向 **Digilent 原版 ZYBO（Retired，Zynq-7010，带 VGA、单个双角色 HDMI）** 的系统教学仓库。

> 本仓库明确 **不是 Zybo Z7-10 / Z7-20 教程集合**。Z7 的 HDMI、Pmod、摄像头接口和若干引脚定义不同，不能直接套用 Z7 的 XDC 或板级工程。

## 仓库目标

zybo-lab 不是只罗列 URL 的 awesome-list，而是把分散在 Digilent、AMD/Xilinx、The Zynq Book、旧 GitHub 工程、PetaLinux/PYNQ 社区中的资料重构为一套可执行课程：

1. 认识原版 ZYBO 的 PS / PL、MIO / EMIO、DDR、AXI 和启动链；
2. 用纯 PL 实验建立 Vivado、XDC、时钟、仿真和 ILA 基础；
3. 用 Cortex-A9 裸机实验学习 UART、GPIO、GIC、中断；
4. 进入 PS↔PL：AXI GPIO、AXI-Lite、自定义 IP；
5. 学习 AXI-Stream、DMA、DDR 和 cache coherency；
6. 使用原版板载 XADC、VGA、双角色 HDMI、SSM2603 Audio、Ethernet、microSD/QSPI；
7. 进入 FreeRTOS、PetaLinux、UIO、PYNQ；
8. 最后做 AMP 和综合项目。

## 目标板卡

| 项目 | 原版 ZYBO |
|---|---|
| FPGA/SoC | XC7Z010-1CLG400C |
| CPU | Dual Cortex-A9，最高 650 MHz |
| DDR | 512 MB DDR3 |
| PL 外部时钟 | 125 MHz |
| 视频 | VGA 输出 + 单个 HDMI Source/Sink 双角色口 |
| 音频 | SSM2603，Mic / Line-in / Headphone |
| 网络 | 10/100/1000 Ethernet |
| 存储 | microSD + 128 Mbit QSPI |
| 扩展 | 6 个 Pmod，其中 JA 支持 XADC |
| Vivado board name | zybo |
| part | xc7z010clg400-1 |

## 如何确认你拿的是原版 ZYBO

最简单的外观判断：

- **有板载 VGA DB-15 接口**；
- 只有一个 HDMI 口，而且它是 Source/Sink 双角色；
- 丝印通常直接写 ZYBO，而不是 Zybo Z7；
- SoC 为 Z-7010；
- 不要因为 Z7-10 也是 Z-7010 就混用 XDC。

详细差异见 docs/00-board-scope.md。

## 推荐学习顺序

| 阶段 | Lab | 主题 | 验收 |
|---|---:|---|---|
| PL-0 | 00 | switches/buttons → LEDs | 仿真 + 上板 |
| PL-1 | 01 | 125 MHz 时钟与计数器 | 1 Hz LED |
| PL-2 | 02 | VGA timing | 640×480 彩条 |
| PS-0 | 03 | Cortex-A9 + UART | Hello + heartbeat |
| PS/PL-0 | 04 | AXI GPIO | PS 控制 PL LED |
| PS/PL-1 | 05 | AXI GPIO interrupt + GIC | 按键中断 |
| Data-0 | 06 | AXI DMA loopback | DDR→DMA→AXIS→DMA→DDR |
| Analog | 07 | XADC / JA | 采样 + 标定 |
| Audio | 08 | SSM2603 + I2S + DMA | 录音/回放或直通 |
| Video | 09 | 原版 HDMI dual-role | Source/Sink 数据流 |
| Net | 10 | lwIP Ethernet | ping + TCP echo |
| Boot | 11 | SD / QSPI / FSBL | 脱离 JTAG 启动 |
| RTOS | 12 | FreeRTOS | task + queue + IRQ |
| Linux | 13 | PetaLinux | SSH + UIO |
| Python | 14 | PYNQ | MMIO/GPIO/DMA |
| Advanced | 15 | AMP dual-core | Linux + bare-metal CPU1 |

## 两条工具链

### A. Modern learning track

面向今天重新学习这块板：

- Vivado / Vitis 2026.1 或其它仍支持 Zynq-7000 的版本；
- 优先按 part 创建工程：xc7z010clg400-1；
- Digilent board file 只作为便利项，不把课程绑定在某一版 Board Automation；
- 新实验尽量使用 Tcl、RTL、XDC 和可重建 block design 思路。

### B. Legacy reproduction track

用于复现原厂旧工程：

- Vivado / SDK 2015.4、2016.2、2017.2/2017.4；
- PetaLinux 2017.4；
- Digilent 原版 ZYBO 仓库中的 DMA、XADC、HDMI in/out、Linux BD、SDSoC；
- 旧工程用于理解架构后再迁移，不把生成的工程目录作为长期源码。

详见 docs/01-toolchains.md。

## 快速开始

安装 Icarus Verilog 后：

~~~bash
make sim
~~~

构建 Lab 00：

~~~bash
vivado -mode batch -source scripts/create_lab00.tcl
~~~

## 仓库结构

~~~text
zybo-lab/
├─ docs/              # 教材、架构、工具链、资源考据
├─ hardware/          # 原版 ZYBO 教学用 XDC
├─ labs/              # 00~15 逐级实验
├─ projects/          # 综合课程设计
├─ scripts/           # 可重建 Vivado 工程 Tcl
└─ .github/workflows/ # RTL smoke tests
~~~

## 学习原则

每个 Lab 尽量回答六件事：

- **Why**：为什么要学；
- **Architecture**：PS/PL/AXI/DDR 数据如何流动；
- **Build**：具体怎么构建；
- **Observe**：用 UART、ILA、寄存器、波形观察什么；
- **Acceptance**：怎样证明实验真的完成；
- **Extensions**：怎样从 Demo 走向工程。

完整资料地图见 docs/resources.md。

## License

MIT。外部参考工程、手册和第三方代码仍遵循各自许可证；本仓库不直接复制第三方大型教程或工程。