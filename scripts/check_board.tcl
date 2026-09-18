puts "Vivado version: [version -short]"
puts "Target part available: [llength [get_parts xc7z010clg400-1]]"

set zybo_parts [get_board_parts -quiet *zybo*]
puts "Installed board parts matching zybo:"
foreach p $zybo_parts { puts "  $p" }

if {[llength [get_parts xc7z010clg400-1]] == 0} {
  error "xc7z010clg400-1 is not installed"
}

if {[llength $zybo_parts] == 0} {
  puts "NOTE: no Digilent board file found. Labs can still use the FPGA part directly."
}
