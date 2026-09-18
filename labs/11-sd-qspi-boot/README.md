# Lab 11 — SD / QSPI Boot

## Goal

脱离 Vivado Hardware Manager 和 JTAG。

## Zynq Boot Chain

~~~text
BootROM
  -> FSBL
     -> PL Bitstream (optional)
     -> Application / U-Boot
~~~

## SD Boot

1. 生成 FSBL；
2. 准备 Bitstream；
3. 准备 app.elf；
4. 编写 BIF；
5. Bootgen 生成 BOOT.BIN；
6. FAT32 SD；
7. 设置 JP5；
8. Power-cycle。

原版手册强调 Boot Mode 在启动时采样，因此修改 Mode 后应进行真正 Cold Boot。

## Example BIF

~~~text
the_ROM_image:
{
  [bootloader] fsbl.elf
  system.bit
  app.elf
}
~~~

## Acceptance

- 不依赖 JTAG Programming 也能启动；
- UART 有 Boot/Application Log；
- LED 显示 Application Heartbeat。

## QSPI

SD 稳定后再做 QSPI：Program Flash → 切 Boot Mode → Cold Boot 验证，并保留 JTAG/SD Recovery Path。
