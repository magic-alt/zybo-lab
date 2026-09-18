VIVADO ?= vivado
ZYBO_JOBS ?= 4
ZYBO_BUILD_ROOT ?= $(CURDIR)/build

VIVADO_ENV = ZYBO_JOBS=$(ZYBO_JOBS) ZYBO_BUILD_ROOT=$(ZYBO_BUILD_ROOT)

.PHONY: sim sim-gpio sim-blink sim-vga \
        vivado-lab04 vivado-lab05 vivado-lab06 vivado-lab07 vivado-lab08 vivado-lab09 vivado-lab10 \
        vivado-bd-lab04 vivado-bd-lab05 vivado-bd-lab06 vivado-bd-lab07 vivado-bd-lab08 vivado-bd-lab09 vivado-bd-lab10 \
        vivado-all vivado-bd-all vivado-clean legacy-ip check-reference-labs

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

vivado-lab04:
	$(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab04.tcl

vivado-lab05:
	$(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab05.tcl

vivado-lab06:
	$(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab06.tcl

vivado-lab07:
	$(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab07.tcl

vivado-lab08:
	$(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab08.tcl

vivado-lab09: legacy-ip
	$(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab09.tcl

vivado-lab10:
	$(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab10.tcl

vivado-bd-lab04:
	ZYBO_BUILD_MODE=bd $(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab04.tcl

vivado-bd-lab05:
	ZYBO_BUILD_MODE=bd $(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab05.tcl

vivado-bd-lab06:
	ZYBO_BUILD_MODE=bd $(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab06.tcl

vivado-bd-lab07:
	ZYBO_BUILD_MODE=bd $(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab07.tcl

vivado-bd-lab08:
	ZYBO_BUILD_MODE=bd $(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab08.tcl

vivado-bd-lab09: legacy-ip
	ZYBO_BUILD_MODE=bd $(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab09.tcl

vivado-bd-lab10:
	ZYBO_BUILD_MODE=bd $(VIVADO_ENV) $(VIVADO) -mode batch -nojournal -nolog -source scripts/create_lab10.tcl

vivado-all: vivado-lab04 vivado-lab05 vivado-lab06 vivado-lab07 vivado-lab08 vivado-lab09 vivado-lab10

vivado-bd-all: vivado-bd-lab04 vivado-bd-lab05 vivado-bd-lab06 vivado-bd-lab07 vivado-bd-lab08 vivado-bd-lab09 vivado-bd-lab10

legacy-ip:
	bash scripts/bootstrap_legacy_ip.sh

check-reference-labs:
	python3 scripts/ci/check_reference_labs.py

vivado-clean:
	rm -rf build/lab04 build/lab05 build/lab06 build/lab07 build/lab08 build/lab09 build/lab10
