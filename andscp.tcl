#! /usr/bin/expect

# auto scp for cmu linux timeshare

set CONST_LOG_FILE "~/.ssh/andrew.log"
set CONST_SERVER "linux.andrew.cmu.edu"

proc help {} {
	puts "Usage: $::argv0 \[arguments that will be sent to scp\]"
}

if { $argc < 2 } {
	puts "Insufficient arguments"
	help
	exit 1
}

if { [ catch { set log [open $CONST_LOG_FILE r] } err ] } {
	puts "Can't open log file. Make sure to use andrew to log in first"
	exit 1
}

gets $log line
set info_pair [split $line]
close $log

set andrew_id [lindex $info_pair 0]
set password [lindex $info_pair 1]

set arglst [split [regsub {:} [join $argv] "$andrew_id@$CONST_SERVER:" ]]

spawn scp {*}$arglst

expect {
	"*password:*" {
		send "$password\r"
		interact
	}

	"*yes/no)?*" {
		send "yes\r"
		exp_continue
    }

	timeout {
		puts "connection timeout"
		exit 3
	}
}


