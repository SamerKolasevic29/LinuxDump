#!/usr/bin/env bash

# Zadatak - simulacija bubble sorta

arr=("2" "8" "5" "3" "9" "4" "1")

echo "Unsorted: ${arr[@]}"

# u n cemo strpat broj elemenata da je lakse dalje
n="${#arr[@]}"


# c-olika for petlja
for (( i=0; i<n-1; i++ )); do
	for (( j=i+1;j<n; j++ )); do
		if [[ ${arr[i]} -gt ${arr[j]} ]]; then
 		 	tmp="${arr[i]}"
		 	arr[i]="${arr[j]}"
		 	arr[j]="$tmp"
		fi
	done
done

echo "Sorted: ${arr[@]}"
