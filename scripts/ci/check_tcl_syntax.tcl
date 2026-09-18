if {[llength $argv] == 0} {
    puts stderr "usage: tclsh check_tcl_syntax.tcl file.tcl ..."
    exit 2
}

set failed 0
foreach path $argv {
    set f [open $path r]
    set data [read $f]
    close $f

    if {![info complete $data]} {
        puts stderr "INCOMPLETE TCL: $path"
        set failed 1
    } else {
        puts "TCL COMPLETE: $path"
    }
}
exit $failed
