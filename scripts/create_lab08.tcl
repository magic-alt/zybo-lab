source [file join [file dirname [info script]] common zybo_common.tcl]

zybo::new_project lab08
zybo::add_rtl labs/08-audio-i2s-dma/src/i2s_tone_gen.v

set ps [zybo::create_ps7 ps7]
zybo::enable_gp0 $ps

zybo::create_ip axi_iic axi_iic_0
zybo::connect_gp0_axi $ps axi_iic_0/S_AXI

create_bd_addr_seg -range 0x00010000 -offset 0x41600000 \
    [get_bd_addr_spaces $ps/Data] \
    [get_bd_addr_segs axi_iic_0/S_AXI/Reg] \
    SEG_axi_iic_0_Reg

set iic_port [make_bd_intf_pins_external [get_bd_intf_pins axi_iic_0/IIC]]
if {[llength $iic_port] == 1} {
    set_property name audio_iic $iic_port
}

zybo::create_ip clk_wiz audio_clk
set_property -dict [list \
    CONFIG.PRIM_IN_FREQ {100.000} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {12.288} \
    CONFIG.USE_RESET {false} \
    CONFIG.USE_LOCKED {false} \
] [get_bd_cells audio_clk]
connect_bd_net [get_bd_pins $ps/FCLK_CLK0] [get_bd_pins audio_clk/clk_in1]

create_bd_cell -type module -reference i2s_tone_gen i2s_tone_gen_0
connect_bd_net [get_bd_pins audio_clk/clk_out1] [get_bd_pins i2s_tone_gen_0/mclk]

set resets [get_bd_cells -quiet -filter {VLNV =~ *:proc_sys_reset:*}]
if {[llength $resets] == 0} {
    error "No proc_sys_reset created by AXI automation"
}
set rst [lindex $resets 0]
connect_bd_net [get_bd_pins $rst/peripheral_aresetn] [get_bd_pins i2s_tone_gen_0/reset_n]

foreach p {ac_bclk ac_pblrc ac_pbdat ac_muten ac_mclk} {
    create_bd_port -dir O $p
}
connect_bd_net [get_bd_pins i2s_tone_gen_0/ac_bclk] [get_bd_ports ac_bclk]
connect_bd_net [get_bd_pins i2s_tone_gen_0/ac_pblrc] [get_bd_ports ac_pblrc]
connect_bd_net [get_bd_pins i2s_tone_gen_0/ac_pbdat] [get_bd_ports ac_pbdat]
connect_bd_net [get_bd_pins i2s_tone_gen_0/ac_muten] [get_bd_ports ac_muten]
connect_bd_net [get_bd_pins audio_clk/clk_out1] [get_bd_ports ac_mclk]

zybo::add_xdc labs/08-audio-i2s-dma/zybo.xdc
zybo::finalize
