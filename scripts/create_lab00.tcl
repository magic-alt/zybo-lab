set origin [file normalize [file join [file dirname [info script]] ..]]
set build_dir [file join $origin build vivado_lab00]
file mkdir $build_dir

create_project lab00 $build_dir -part xc7z010clg400-1 -force
set_property target_language Verilog [current_project]

add_files [file join $origin labs 00-pl-gpio src top.v]
add_files -fileset constrs_1 [file join $origin labs 00-pl-gpio zybo.xdc]

update_compile_order -fileset sources_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

set bitfile [file join $build_dir lab00.runs impl_1 top.bit]
puts "BITSTREAM: $bitfile"
