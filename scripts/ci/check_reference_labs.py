#!/usr/bin/env python3
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[2]

errors = []
makefile = (ROOT / "Makefile").read_text(encoding="utf-8")

for n in range(4, 11):
    lab = f"{n:02d}"
    script = ROOT / "scripts" / f"create_lab{lab}.tcl"
    target = f"vivado-lab{lab}:"
    bd_target = f"vivado-bd-lab{lab}:"

    if not script.exists():
        errors.append(f"missing {script.relative_to(ROOT)}")
        continue
    if target not in makefile:
        errors.append(f"missing Make target {target[:-1]}")
    if bd_target not in makefile:
        errors.append(f"missing Make target {bd_target[:-1]}")

    text = script.read_text(encoding="utf-8")
    if n != 9 and "zybo::finalize" not in text:
        errors.append(f"Lab {lab}: does not use common finalize path")
    if n != 9 and "zybo_common.tcl" not in text:
        errors.append(f"Lab {lab}: does not source common Tcl")
    if "zybo-z7" in text.lower():
        errors.append(f"Lab {lab}: Zybo Z7 leaked into executable Tcl")

expect = {
    "04": ["axi_gpio", "0x41200000"],
    "05": ["axi_gpio", "IRQ_F2P", "0x41200000"],
    "06": ["axi_dma", "S_AXI_HP0", "axis_data_fifo", "0x40400000"],
    "07": ["xadc_wiz", "VAUXP14", "0x43C30000"],
    "08": ["axi_iic", "12.288", "i2s_tone_gen"],
    "09": ["834fd71ed0349b8be6594a75f63a5f0c1f6ba615", "hdmi_out"],
    "10": ["PCW_ENET0_PERIPHERAL_ENABLE", "axi_gpio"],
}

for lab, needles in expect.items():
    text = (ROOT / "scripts" / f"create_lab{lab}.tcl").read_text(encoding="utf-8")
    for needle in needles:
        if needle not in text:
            errors.append(f"Lab {lab}: expected token {needle!r}")

common = (ROOT / "scripts/common/zybo_common.tcl").read_text(encoding="utf-8")
for token in ["xc7z010clg400-1", "MT41K128M16 JT-125", "validate_bd_design", "write_hw_platform"]:
    if token not in common:
        errors.append(f"common Tcl missing {token!r}")

for xdc in [
    ROOT / "labs/04-axi-gpio/zybo.xdc",
    ROOT / "labs/05-axi-interrupt/zybo.xdc",
    ROOT / "labs/07-xadc/zybo.xdc",
    ROOT / "labs/08-audio-i2s-dma/zybo.xdc",
    ROOT / "labs/10-ethernet-lwip/zybo.xdc",
]:
    if not xdc.exists():
        errors.append(f"missing {xdc.relative_to(ROOT)}")

if errors:
    print("Reference-lab static checks FAILED:")
    for e in errors:
        print(" -", e)
    sys.exit(1)

print("Reference-lab static checks PASS")
