source [file join [file dirname [info script]] common zybo_common.tcl]

zybo::new_project lab04
set ps [zybo::create_ps7 ps7]
zybo::enable_gp0 $ps

zybo::create_ip axi_gpio axi_gpio_0
set_property -dict [list \
    CONFIG.C_GPIO_WIDTH {4} \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_ALL_INPUTS {0} \
    CONFIG.C_IS_DUAL {0} \
] [get_bd_cells axi_gpio_0]

zybo::connect_gp0_axi $ps axi_gpio_0/S_AXI

create_bd_port -dir O -from 3 -to 0 led
connect_bd_net [get_bd_pins axi_gpio_0/gpio_io_o] [get_bd_ports led]

create_bd_addr_seg -range 0x00010000 -offset 0x41200000 \
    [get_bd_addr_spaces $ps/Data] \
    [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] \
    SEG_axi_gpio_0_Reg

zybo::add_xdc labs/04-axi-gpio/zybo.xdc
zybo::finalize
