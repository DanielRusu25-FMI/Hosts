#!/bin/bash

verify-IP(){
	file_ip=$1
	host_name=$2

	actual_ip=$(nslookup "$host_name" | grep -A 1 "^Name:" | grep "^Address:" | grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")

	if [ "$actual_ip" != "$file_ip" ]; then
		echo "Bogus IP for $host_name in \$HOME/etc/hosts !"
		return 1
	fi

	return 0
}

while read -r ip name; do
	if [ -n "$ip" ] && [ -n "$name" ]; then
		verify-IP "$ip" "$name"
	fi

done < "$HOME/etc/hosts"



