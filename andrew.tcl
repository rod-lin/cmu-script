#! /usr/bin/expect

# auto login script for cmu linux timeshare

set CONST_LOG_FILE "~/.ssh/andrew.log"
set CONST_SERVER "linux.andrew.cmu.edu"

proc help {} {
	puts "Usage: $::argv0 \[andrew_id password\]"
}

if { $argc < 2 } {
	# try to find log file
	if { [ catch { set log [open $CONST_LOG_FILE r] } err ] } {
		puts "No arguments or log file"
		help
		exit 1
	}

	gets $log line
	set info_pair [split $line]
	close $log
} else {
	set info_pair $argv
}

set andrew_id [lindex $info_pair 0]
set password [lindex $info_pair 1]

# create log
if { [ catch { set log [open $CONST_LOG_FILE w] } ] } {
	puts "Warning: unable to save log"
} else {
	puts $log "$andrew_id $password"
	close $log
}

spawn ssh $andrew_id@$CONST_SERVER {*}[join [lrange $argv 2 end]]

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


