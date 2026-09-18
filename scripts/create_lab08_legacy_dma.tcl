set repo_root [file normalize [file join [file dirname [info script]] ..]]
set build_root [expr {[info exists ::env(ZYBO_BUILD_ROOT)] && $::env(ZYBO_BUILD_ROOT) ne "" ? $::env(ZYBO_BUILD_ROOT) : [file join $repo_root build]}]
set out_dir [file normalize [file join $build_root lab08-legacy-dma]]
set legacy_root [file join $repo_root third_party Digilent-ZYBO]
set source_project [file join $legacy_root Projects dma]

if {![file exists [file join $source_project proj create_project.tcl]]} {
    error "Missing pinned Digilent reference. Run: make legacy-ip"
}

if {[file exists $out_dir]} { file delete -force $out_dir }
file mkdir $out_dir

set work [file join $out_dir dma]
file copy -force $source_project $work

puts "ZYBO-LAB: rebuilding pinned Original ZYBO dma reference"
puts "ZYBO-LAB: source commit 834fd71ed0349b8be6594a75f63a5f0c1f6ba615"
set vivado_ver [version -short]
puts "ZYBO-LAB: Vivado version $vivado_ver"
if {![regexp {^(2015|2016|2017)\.} $vivado_ver]} {
    puts "WARNING: dma is a pinned legacy backend exported by old Vivado."
    puts "WARNING: Modern Vivado may require IP upgrade/porting."
}

source [file join $work proj create_project.tcl]

set bd [get_bd_designs]
if {[llength $bd] == 0} { error "Legacy project did not create a block design" }
validate_bd_design
save_bd_design

set mode [string tolower [expr {[info exists ::env(ZYBO_BUILD_MODE)] ? $::env(ZYBO_BUILD_MODE) : "bitstream"}]]
if {$mode eq "bd"} {
    puts "ZYBO-LAB: dma block design validation complete"
    close_project
    exit 0
}

set jobs [expr {[info exists ::env(ZYBO_JOBS)] ? $::env(ZYBO_JOBS) : 4}]
launch_runs impl_1 -to_step write_bitstream -jobs $jobs
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] ne "100%"} { error "Legacy implementation did not complete" }

set top_name [get_property TOP [get_filesets sources_1]]
set run_dir [get_property DIRECTORY [get_runs impl_1]]
set bit_src [file join $run_dir ${top_name}.bit]
if {[file exists $bit_src]} { file copy -force $bit_src [file join $out_dir lab08-legacy-dma.bit] }
puts "ZYBO-LAB: legacy build complete: $out_dir"
close_project
