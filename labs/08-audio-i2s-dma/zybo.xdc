## ORIGINAL Digilent ZYBO SSM2603 pins. Not Zybo Z7.
set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports ac_bclk]
set_property -dict { PACKAGE_PIN T19 IOSTANDARD LVCMOS33 } [get_ports ac_mclk]
set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports ac_muten]
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports ac_pbdat]
set_property -dict { PACKAGE_PIN L17 IOSTANDARD LVCMOS33 } [get_ports ac_pblrc]

set_property PACKAGE_PIN N18 [get_ports -quiet *scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports -quiet *scl_io]
set_property PACKAGE_PIN N17 [get_ports -quiet *sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports -quiet *sda_io]
