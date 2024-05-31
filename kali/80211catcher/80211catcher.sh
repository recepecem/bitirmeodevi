#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

ifconfig wlan1 down 
iwconfig wlan1 mode managed 
ifconfig wlan1 up 
systemctl restart networking NetworkManager 
sleep 5

airodump-ng wlan1 --output-format csv -w /home/analyst/bitirme/80211catcher/tmpwln &
PID=$!
sleep 40
kill -9 $PID
clear


awk -F ', ' '{print $4, $1}' /home/analyst/bitirme/80211catcher/tmpwln-01.csv | sort | awk ' $1 > -53' | awk ' $1 < 0' | uniq | wc -l > /home/analyst/bitirme/80211catcher/X
Xx=$(< /home/analyst/bitirme/80211catcher/X)
echo "kali-80211: $Xx" > /home/analyst/bitirme/80211catcher/sum
rm -f /home/analyst/bitirme/80211catcher/tmpwln*
sleep 3
python3 /home/analyst/bitirme/80211catcher/publisher.py












