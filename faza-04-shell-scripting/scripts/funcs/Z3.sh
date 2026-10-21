#!/usr/bin/env bash

# Zadatak - narpaviti funk koja vraca tri vrijednosti preko nameref ili printf -v (koristit cemo nameref)
# -onda pozvati hiljadu puta petljom u glavnom bashu pa onda kao $(f) i izmjeriti vrijeme


# funkcija neka lagana gdje se daju vrijednosti sa local -n
f(){
	# sintaksa je sljedeca:
	#	-- $1 $2 i $3 su ulazne varijable
	#	-- sa local -n kreiramo reference na njih tri (dobro za vracanje vise vrijednosti)
	#	-- mijenjamo vrijednost _ip _mac i _host onda ce varijable PRI POZICVU FUNKCIJE DOBITI TE VRIJEDN
	local -n _ip=$1
	local -n _mac=$2
	local -n _host=$3

	_ip="192.168.121.2"
	_mac="00:11:22:33:44:55"
	_host="FEDORA"
}

f_stdout() {
	echo "ovo ide na es ti di aut"
}

# sada ce my_ip my_mac i my_host dobiti te vrijednosti iz funkcije
count=0
time {
while [[ $count -lt 1000 ]]; do
	f my_ip my_mac my_host
	((++count))
#	echo "$my_ip $my_mac $my_host"
done
}
echo "---"

count=0
time {
while [[ $count -lt 1000 ]]; do
        read -r er ar ur <<< "$(f_stdout)"
        ((++count))
done
}






