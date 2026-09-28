#!/usr/bin/env bash

# path as a variable
SYS_FILE="/tmp/system_status.txt"

# Collecting data via commands ( Command substitution )
DATE=$(date)
USERNAME=$USER
HOSTNAME=$(hostname)
UP=$(uptime -p)
PROCESSES=$(ps -ef | wc -l)

if [ "$#" -gt 1 ]; then
	echo "usage ./sysreport.sh [OPTION]";
	echo "Options:";
	echo "info | show  - shows report on terminal";
	echo "save	   - Stores report in /tmp/system_status.txt";
	exit 1;

fi 

case $1 in
	info|show)
		cat <<EOF
Date: $DATE
User: $USER
Hostname: $HOSTNAME
Uptime: $UP
Number of processes: $PROCESSES
EOF
;;
	save)
		cat <<EOF > "$SYS_FILE"
Date: $DATE
User: $USER
Hostname: $HOSTNAME
Uptime: $UP
Number of processes: $PROCESSES
EOF

echo "Report saved in /tmp/system_status.txt";
	;;

	*)
		echo "usage ./sysreport.sh [OPTION]";
        echo "Options:";
        echo "info | show  - shows report on terminal";
        echo "save         - Stores report in /tmp/system_status.txt";
        exit 1;

	;;
esac




		

