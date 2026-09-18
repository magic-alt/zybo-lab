source [file join [file dirname [info script]] common zybo_common.tcl]

zybo::new_project lab06
set ps [zybo::create_ps7 ps7]
zybo::enable_gp0 $ps
zybo::enable_hp0 $ps
zybo::enable_fabric_irq $ps

zybo::create_ip axi_dma axi_dma_0
set_property -dict [list \
    CONFIG.c_include_sg {0} \
    CONFIG.c_include_mm2s {1} \
    CONFIG.c_include_s2mm {1} \
    CONFIG.c_m_axi_mm2s_data_width {32} \
    CONFIG.c_m_axis_mm2s_tdata_width {32} \
    CONFIG.c_s_axis_s2mm_tdata_width {32} \
    CONFIG.c_m_axi_s2mm_data_width {32} \
    CONFIG.c_mm2s_burst_size {16} \
    CONFIG.c_s2mm_burst_size {16} \
] [get_bd_cells axi_dma_0]

zybo::create_ip axis_data_fifo axis_fifo_0
set_property -dict [list \
    CONFIG.TDATA_NUM_BYTES {4} \
    CONFIG.FIFO_DEPTH {1024} \
    CONFIG.HAS_TLAST {1} \
] [get_bd_cells axis_fifo_0]

connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_fifo_0/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins axis_fifo_0/M_AXIS] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]

zybo::connect_gp0_axi $ps axi_dma_0/S_AXI_LITE

set mem_ic [zybo::connect_hp0_first $ps axi_dma_0/M_AXI_MM2S]
zybo::connect_hp0_more $ps axi_dma_0/M_AXI_S2MM $mem_ic

connect_bd_net [get_bd_pins $ps/FCLK_CLK0] [get_bd_pins axis_fifo_0/s_axis_aclk]

set resets [get_bd_cells -quiet -filter {VLNV =~ *:proc_sys_reset:*}]
if {[llength $resets] == 0} {
    error "No proc_sys_reset created by AXI automation"
}
set rst [lindex $resets 0]
connect_bd_net [get_bd_pins $rst/peripheral_aresetn] [get_bd_pins axis_fifo_0/s_axis_aresetn]

zybo::create_ip xlconcat irq_concat
set_property -dict [list CONFIG.NUM_PORTS {2}] [get_bd_cells irq_concat]
connect_bd_net [get_bd_pins axi_dma_0/mm2s_introut] [get_bd_pins irq_concat/In0]
connect_bd_net [get_bd_pins axi_dma_0/s2mm_introut] [get_bd_pins irq_concat/In1]
connect_bd_net [get_bd_pins irq_concat/dout] [get_bd_pins $ps/IRQ_F2P]

create_bd_addr_seg -range 0x00010000 -offset 0x40400000 \
    [get_bd_addr_spaces $ps/Data] \
    [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] \
    SEG_axi_dma_0_Reg

zybo::finalize
