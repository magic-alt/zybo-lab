.PHONY: sim sim-gpio sim-blink sim-vga

sim: sim-gpio sim-blink sim-vga

sim-gpio:
	mkdir -p build
	iverilog -g2012 -o build/lab00 labs/00-pl-gpio/src/top.v labs/00-pl-gpio/sim/tb_top.v
	vvp build/lab00

sim-blink:
	mkdir -p build
	iverilog -g2012 -o build/lab01 labs/01-pl-clock/src/blink.v labs/01-pl-clock/sim/tb_blink.v
	vvp build/lab01

sim-vga:
	mkdir -p build
	iverilog -g2012 -o build/lab02 labs/02-vga-pattern/src/vga_pattern.v labs/02-vga-pattern/sim/tb_vga_pattern.v
	vvp build/lab02
