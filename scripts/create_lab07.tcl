source [file join [file dirname [info script]] common zybo_common.tcl]

zybo::new_project lab07
set ps [zybo::create_ps7 ps7]
zybo::enable_gp0 $ps

zybo::create_ip xadc_wiz xadc_wiz_0
set_property -dict [list \
    CONFIG.INTERFACE_SELECTION {Enable_AXI} \
    CONFIG.DCLK_FREQUENCY {100} \
    CONFIG.XADC_STARUP_SELECTION {channel_sequencer} \
    CONFIG.SEQUENCER_MODE {Continuous} \
    CONFIG.CHANNEL_ENABLE_TEMPERATURE {true} \
    CONFIG.CHANNEL_ENABLE_VCCINT {true} \
    CONFIG.CHANNEL_ENABLE_VCCAUX {true} \
    CONFIG.CHANNEL_ENABLE_VP_VN {false} \
    CONFIG.CHANNEL_ENABLE_VAUXP6_VAUXN6 {true} \
    CONFIG.CHANNEL_ENABLE_VAUXP7_VAUXN7 {true} \
    CONFIG.CHANNEL_ENABLE_VAUXP14_VAUXN14 {true} \
    CONFIG.CHANNEL_ENABLE_VAUXP15_VAUXN15 {true} \
    CONFIG.ENABLE_EXTERNAL_MUX {false} \
] [get_bd_cells xadc_wiz_0]

zybo::connect_gp0_axi $ps xadc_wiz_0/s_axi_lite

foreach ch {6 7 14 15} {
    create_bd_port -dir I vauxp$ch
    create_bd_port -dir I vauxn$ch
    connect_bd_net [get_bd_ports vauxp$ch] [get_bd_pins xadc_wiz_0/vauxp$ch]
    connect_bd_net [get_bd_ports vauxn$ch] [get_bd_pins xadc_wiz_0/vauxn$ch]
}

create_bd_addr_seg -range 0x00010000 -offset 0x43C30000 \
    [get_bd_addr_spaces $ps/Data] \
    [get_bd_addr_segs xadc_wiz_0/s_axi_lite/Reg] \
    SEG_xadc_wiz_0_Reg

zybo::add_xdc labs/07-xadc/zybo.xdc
zybo::finalize
