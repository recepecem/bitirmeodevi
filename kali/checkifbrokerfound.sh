#!/bin/bash

file_path="/home/analyst/bitirme/bip"
rm -f $file_path
ip_regex='([0-9]{1,3}\.){3}[0-9]{1,3}'

while true; do
	text=$(cat "$file_path")
	if [[ $text =~ $ip_regex ]]; then
		break
	else
  		/home/analyst/bitirme/mactoip.sh e0:0a:f6:74:0a:e9 2>&1>> $file_path
  	fi
done
