# Common Vivado helpers for the ORIGINAL Digilent ZYBO (XC7Z010-1CLG400C).
# This file intentionally does not target Zybo Z7.

namespace eval zybo {
    variable repo_root [file normalize [file join [file dirname [info script]] .. ..]]
    variable part "xc7z010clg400-1"
    variable bd_name "system"
    variable out_dir ""
    variable project_dir ""
    variable project_name ""
    variable board_part ""
}

proc zybo::env_or {name default_value} {
    if {[info exists ::env($name)] && $::env($name) ne ""} {
        return $::env($name)
    }
    return $default_value
}

proc zybo::latest_vlnv {ip_name} {
    set defs [get_ipdefs -all -filter "VLNV =~ xilinx.com:ip:${ip_name}:*"]
    if {[llength $defs] == 0} {
        error "Required Xilinx IP not installed: $ip_name"
    }

    set vlnvs {}
    foreach def $defs {
        lappend vlnvs [get_property VLNV $def]
    }
    return [lindex [lsort -dictionary -unique $vlnvs] end]
}

proc zybo::create_ip {ip_name instance_name} {
    set vlnv [zybo::latest_vlnv $ip_name]
    puts "ZYBO-LAB: create $instance_name using $vlnv"
    return [create_bd_cell -type ip -vlnv $vlnv $instance_name]
}

proc zybo::find_original_board_part {} {
    set matches {}
    foreach bp [get_board_parts -quiet *zybo*] {
        if {[string match "digilentinc.com:zybo:*" $bp]} {
            lappend matches $bp
        }
    }
    if {[llength $matches] == 0} {
        return ""
    }
    return [lindex [lsort -dictionary $matches] end]
}

proc zybo::new_project {lab_name} {
    variable repo_root
    variable part
    variable bd_name
    variable out_dir
    variable project_dir
    variable project_name
    variable board_part

    set build_root [zybo::env_or ZYBO_BUILD_ROOT [file join $repo_root build]]
    set out_dir [file normalize [file join $build_root $lab_name]]
    set project_dir [file join $out_dir vivado]
    set project_name $lab_name

    if {[file exists $project_dir]} {
        file delete -force $project_dir
    }
    file mkdir $out_dir

    create_project $project_name $project_dir -part $part -force
    set_property target_language Verilog [current_project]

    set board_part [zybo::find_original_board_part]
    if {$board_part ne ""} {
        puts "ZYBO-LAB: using installed original ZYBO board part $board_part"
        set_property board_part $board_part [current_project]
    } else {
        puts "ZYBO-LAB: original ZYBO board file not installed; using in-repo PS7 fallback preset"
    }

    create_bd_design $bd_name
    current_bd_design $bd_name
    return $out_dir
}

proc zybo::apply_fallback_ps7_preset {ps} {
    set_property -dict [list         CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {650}         CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {50.000000}         CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100}         CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1}         CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1}         CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1}         CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1}         CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1}         CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1}         CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1}         CONFIG.PCW_SD0_GRP_CD_ENABLE {1}         CONFIG.PCW_SD0_GRP_CD_IO {MIO 47}         CONFIG.PCW_SD0_GRP_WP_ENABLE {1}         CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50}         CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1}         CONFIG.PCW_USB0_RESET_ENABLE {1}         CONFIG.PCW_USB0_RESET_IO {MIO 46}         CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1}         CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27}         CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1}         CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V}         CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {525}         CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K128M16 JT-125}         CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.176}         CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.159}         CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.162}         CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.187}         CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.073}         CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.034}         CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {-0.030}         CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {-0.082}         CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1}         CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1}         CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1}     ] [get_bd_cells $ps]
}

proc zybo::create_ps7 {{name "ps7"}} {
    variable board_part

    zybo::create_ip processing_system7 $name

    if {$board_part ne ""} {
        apply_bd_automation -rule xilinx.com:bd_rule:processing_system7             -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable"}             [get_bd_cells $name]
    } else {
        zybo::apply_fallback_ps7_preset $name
        apply_bd_automation -rule xilinx.com:bd_rule:processing_system7             -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable"}             [get_bd_cells $name]
    }

    return $name
}

proc zybo::enable_gp0 {ps} {
    set_property -dict [list         CONFIG.PCW_USE_M_AXI_GP0 {1}         CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100}     ] [get_bd_cells $ps]
}

proc zybo::enable_hp0 {ps} {
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1}] [get_bd_cells $ps]
}

proc zybo::enable_fabric_irq {ps} {
    set_property -dict [list         CONFIG.PCW_USE_FABRIC_INTERRUPT {1}         CONFIG.PCW_IRQ_F2P_INTR {1}     ] [get_bd_cells $ps]
}

proc zybo::connect_gp0_axi {ps slave_pin} {
    apply_bd_automation -rule xilinx.com:bd_rule:axi4         -config [list Master "/$ps/M_AXI_GP0" Clk "Auto"]         [get_bd_intf_pins $slave_pin]
}

proc zybo::connect_hp0_first {ps master_pin} {
    set before [get_bd_cells -quiet -filter {VLNV =~ *:axi_interconnect:*}]
    set smart_before [get_bd_cells -quiet -filter {VLNV =~ *:smartconnect:*}]

    apply_bd_automation -rule xilinx.com:bd_rule:axi4         -config [list             Clk_master Auto Clk_slave Auto Clk_xbar Auto             Master "/$master_pin" Slave "/$ps/S_AXI_HP0"             ddr_seg Auto intc_ip "New AXI Interconnect" master_apm 0         ] [get_bd_intf_pins $ps/S_AXI_HP0]

    set after [get_bd_cells -quiet -filter {VLNV =~ *:axi_interconnect:*}]
    foreach cell $after {
        if {[lsearch -exact $before $cell] < 0} {
            return [get_property NAME $cell]
        }
    }

    set smart_after [get_bd_cells -quiet -filter {VLNV =~ *:smartconnect:*}]
    foreach cell $smart_after {
        if {[lsearch -exact $smart_before $cell] < 0} {
            return [get_property NAME $cell]
        }
    }

    error "Could not identify HP0 memory interconnect"
}

proc zybo::connect_hp0_more {ps master_pin interconnect_name} {
    apply_bd_automation -rule xilinx.com:bd_rule:axi4         -config [list             Clk_master Auto Clk_slave Auto Clk_xbar Auto             Master "/$master_pin" Slave "/$ps/S_AXI_HP0"             ddr_seg Auto intc_ip "/$interconnect_name" master_apm 0         ] [get_bd_intf_pins $master_pin]
}

proc zybo::add_xdc {relative_path} {
    variable repo_root
    set xdc [file join $repo_root $relative_path]
    if {![file exists $xdc]} {
        error "Missing constraint file: $xdc"
    }
    add_files -fileset constrs_1 -norecurse $xdc
}

proc zybo::add_rtl {relative_path} {
    variable repo_root
    set rtl [file join $repo_root $relative_path]
    if {![file exists $rtl]} {
        error "Missing RTL file: $rtl"
    }
    add_files -norecurse $rtl
    update_compile_order -fileset sources_1
}

proc zybo::finalize {} {
    variable bd_name
    variable out_dir
    variable project_name

    validate_bd_design
    save_bd_design

    set bd_file [get_files -quiet */${bd_name}.bd]
    if {[llength $bd_file] != 1} {
        error "Expected exactly one $bd_name.bd, got [llength $bd_file]"
    }

    write_bd_tcl -force [file join $out_dir ${bd_name}.generated.tcl]
    generate_target all $bd_file

    set wrappers [make_wrapper -files $bd_file -top]
    if {[llength $wrappers] == 0} {
        error "make_wrapper returned no wrapper"
    }
    add_files -norecurse $wrappers
    update_compile_order -fileset sources_1

    set mode [string tolower [zybo::env_or ZYBO_BUILD_MODE bitstream]]
    set jobs [zybo::env_or ZYBO_JOBS 4]

    if {$mode eq "bd"} {
        puts "ZYBO-LAB: block design validation complete"
        puts "ZYBO-LAB: generated BD Tcl: [file join $out_dir ${bd_name}.generated.tcl]"
        close_project
        return
    }

    launch_runs synth_1 -jobs $jobs
    wait_on_run synth_1
    if {[get_property PROGRESS [get_runs synth_1]] ne "100%"} {
        error "Synthesis did not complete"
    }

    if {$mode eq "synth"} {
        puts "ZYBO-LAB: synthesis complete"
        close_project
        return
    }

    launch_runs impl_1 -to_step write_bitstream -jobs $jobs
    wait_on_run impl_1
    if {[get_property PROGRESS [get_runs impl_1]] ne "100%"} {
        error "Implementation/bitstream did not complete"
    }

    open_run impl_1
    report_timing_summary -file [file join $out_dir timing_summary.rpt]
    report_utilization -file [file join $out_dir utilization.rpt]

    set top_name [get_property TOP [get_filesets sources_1]]
    set run_dir [get_property DIRECTORY [get_runs impl_1]]
    set bit_src [file join $run_dir ${top_name}.bit]
    if {[file exists $bit_src]} {
        file copy -force $bit_src [file join $out_dir ${project_name}.bit]
    }

    if {[llength [info commands write_hw_platform]] > 0} {
        write_hw_platform -fixed -include_bit -force -file [file join $out_dir ${project_name}.xsa]
    }

    puts "ZYBO-LAB: build complete: $out_dir"
    close_project
}
