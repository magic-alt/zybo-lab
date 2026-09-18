## Teaching constraints for the ORIGINAL Digilent ZYBO.
## Source of pin facts: Digilent ZYBO_Master.xdc.
## Do NOT use this file for Zybo Z7.

## 125 MHz PL clock
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 8.000 -waveform {0 4} [get_ports clk]

## Switches
set_property -dict { PACKAGE_PIN G15 IOSTANDARD LVCMOS33 } [get_ports {sw[0]}]
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports {sw[1]}]
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports {sw[2]}]
set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports {sw[3]}]

## PL buttons
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports {btn[0]}]
set_property -dict { PACKAGE_PIN P16 IOSTANDARD LVCMOS33 } [get_ports {btn[1]}]
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports {btn[2]}]
set_property -dict { PACKAGE_PIN Y16 IOSTANDARD LVCMOS33 } [get_ports {btn[3]}]

## PL LEDs
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports {led[0]}]
set_property -dict { PACKAGE_PIN M15 IOSTANDARD LVCMOS33 } [get_ports {led[1]}]
set_property -dict { PACKAGE_PIN G14 IOSTANDARD LVCMOS33 } [get_ports {led[2]}]
set_property -dict { PACKAGE_PIN D18 IOSTANDARD LVCMOS33 } [get_ports {led[3]}]

## Original-board SSM2603 audio codec
set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports ac_bclk]
set_property -dict { PACKAGE_PIN T19 IOSTANDARD LVCMOS33 } [get_ports ac_mclk]
set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports ac_muten]
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports ac_pbdat]
set_property -dict { PACKAGE_PIN L17 IOSTANDARD LVCMOS33 } [get_ports ac_pblrc]
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports ac_recdat]
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports ac_reclrc]
set_property -dict { PACKAGE_PIN N18 IOSTANDARD LVCMOS33 } [get_ports ac_scl]
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports ac_sda]

## Original-board HDMI dual-role
set_property -dict { PACKAGE_PIN H17 IOSTANDARD TMDS_33 } [get_ports hdmi_clk_n]
set_property -dict { PACKAGE_PIN H16 IOSTANDARD TMDS_33 } [get_ports hdmi_clk_p]
set_property -dict { PACKAGE_PIN D20 IOSTANDARD TMDS_33 } [get_ports {hdmi_d_n[0]}]
set_property -dict { PACKAGE_PIN D19 IOSTANDARD TMDS_33 } [get_ports {hdmi_d_p[0]}]
set_property -dict { PACKAGE_PIN B20 IOSTANDARD TMDS_33 } [get_ports {hdmi_d_n[1]}]
set_property -dict { PACKAGE_PIN C20 IOSTANDARD TMDS_33 } [get_ports {hdmi_d_p[1]}]
set_property -dict { PACKAGE_PIN A20 IOSTANDARD TMDS_33 } [get_ports {hdmi_d_n[2]}]
set_property -dict { PACKAGE_PIN B19 IOSTANDARD TMDS_33 } [get_ports {hdmi_d_p[2]}]
set_property -dict { PACKAGE_PIN E19 IOSTANDARD LVCMOS33 } [get_ports hdmi_cec]
set_property -dict { PACKAGE_PIN E18 IOSTANDARD LVCMOS33 } [get_ports hdmi_hpd]
set_property -dict { PACKAGE_PIN F17 IOSTANDARD LVCMOS33 } [get_ports hdmi_out_en]
set_property -dict { PACKAGE_PIN G17 IOSTANDARD LVCMOS33 } [get_ports hdmi_scl]
set_property -dict { PACKAGE_PIN G18 IOSTANDARD LVCMOS33 } [get_ports hdmi_sda]
