#!/usr/bin/env bash

# perm_check.sh target_p

# 1. provjeriti da li je fajl/dri/symlink
# 2. ispisati da li je r w x
# 3. da li je prazno

exit_code=0
target_p="$1"

resolve_type() {
	if [[ -f $target_p ]]; then 
	  	echo "type: file";
	elif [[ -d $target_p ]]; then
		echo "type: directory";
	elif [[ -h $target_p ]]; then
                echo "type: symlink";
	elif [[ -b $target_p ]]; then
                echo "type: block device";
	elif [[ -c $target_p ]]; then
                echo "type: char device";
	elif [[ -p $target_p ]]; then
                echo "type: pipe";
	elif [[ -S $target_p ]]; then
                echo "type: socket";
	fi
}

resolve_perm() {
	[[ -r $target_p ]] && echo "file is readable"  || echo "Reading denied"
	[[ -w $target_p ]] && echo "file is writeable" || echo "Writing denied"
	[[ -x $target_p ]] && echo "file is executable" || echo "Executing denied"
}

if [[ -e $target_p ]]; then
	resolve_type
	echo "---"
	resolve_perm
	[[ -s $target_p ]] && echo "non-Empty" || echo "empty"
	exit $exit_code
else 
	echo "UNKNOWN" 
	exit $exit_code 
fi



