#!/usr/bin/env bash

# Zadatak - simulacija dnf install dijela gdje se trazi N ili y
answer="N"
exit_status=0
read -r -p "Nastaviti?(y/N): " answer
echo ""
[[ -z "$answer" ]] && answer="N"
case $answer in
	[nN])
		echo "Odgovor je N, gasim. . ."
		exit_status=1
		exit $exit_status
		;;
	[yY])
		echo "Now installing cmatrix. . ."
		exit $exit_status
		;;
	*)
		echo "ERROR, wrong option"
		exit_status=1
		exit $exit_status
		;;
	esac
