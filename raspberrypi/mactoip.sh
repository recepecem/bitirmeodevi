#!/bin/bash

ip route | grep -Eo '([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}' > cidr
/home/ahududu2/bitirme/cidr-to-iplist /home/ahududu2/bitirme/cidr > iplist
IP_LIST="/home/ahududu2/bitirme/iplist"

# Check if the file exists
if [ ! -f "$IP_LIST" ]; then
    echo "IP list file not found: $IP_LIST"
    exit 1
fi

# Read each IP address from the file and ping it
while IFS= read -r ip; do

    ping -c 2 "$ip" >/dev/null 2>&1 &

done < "$IP_LIST"



if [ $1 ]; then

	arp | awk -F ' ' '{print $1,$3}' | grep $1 | grep -Eo '([0-9]{1,3}\.){3}[0-9]{3}'
else

	echo "parametre alınamadı"
fi



