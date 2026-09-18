source [file join [file dirname [info script]] common zybo_common.tcl]

zybo::new_project lab05
set ps [zybo::create_ps7 ps7]
zybo::enable_gp0 $ps
zybo::enable_fabric_irq $ps

zybo::create_ip axi_gpio axi_gpio_0
set_property -dict [list \
    CONFIG.C_GPIO_WIDTH {4} \
    CONFIG.C_ALL_INPUTS {1} \
    CONFIG.C_ALL_OUTPUTS {0} \
    CONFIG.C_IS_DUAL {0} \
    CONFIG.C_INTERRUPT_PRESENT {1} \
] [get_bd_cells axi_gpio_0]

zybo::connect_gp0_axi $ps axi_gpio_0/S_AXI

create_bd_port -dir I -from 3 -to 0 btn
connect_bd_net [get_bd_ports btn] [get_bd_pins axi_gpio_0/gpio_io_i]

zybo::create_ip xlconcat irq_concat
set_property -dict [list CONFIG.NUM_PORTS {1}] [get_bd_cells irq_concat]
connect_bd_net [get_bd_pins axi_gpio_0/ip2intc_irpt] [get_bd_pins irq_concat/In0]
connect_bd_net [get_bd_pins irq_concat/dout] [get_bd_pins $ps/IRQ_F2P]

create_bd_addr_seg -range 0x00010000 -offset 0x41200000 \
    [get_bd_addr_spaces $ps/Data] \
    [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] \
    SEG_axi_gpio_0_Reg

zybo::add_xdc labs/05-axi-interrupt/zybo.xdc
zybo::finalize
