#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

sudo tshark -i lo -Y 'e212.imsi and not icmp' > /home/analyst/bitirme/imsicatcher/tshark_e212_output &
process_pid=$!

grep -E -o '[0-9]{3}\.[0-9]{1}M' /home/analyst/bitirme/imsicatcher/temp1999 > /home/analyst/bitirme/imsicatcher/available_stations

for VAR in $(cat /home/analyst/bitirme/imsicatcher/available_stations)
do
	timeout 50 grgsm_livemon -f $VAR
done
kill -9 $process_pid

grep -E -o '286[0-9]{12}' /home/analyst/bitirme/imsicatcher/tshark_e212_output > /home/analyst/bitirme/imsicatcher/temp2999
cat /home/analyst/bitirme/imsicatcher/temp2999 /home/analyst/bitirme/imsicatcher/TR_IMSIs > /home/analyst/bitirme/imsicatcher/merged
cat /home/analyst/bitirme/imsicatcher/merged | sort | uniq > /home/analyst/bitirme/imsicatcher/TR_IMSIs

fl="/home/analyst/bitirme/imsicatcher/TR_IMSIs"
lns=$(wc -l < "$fl")
echo "kali-imsi: $lns" > /home/analyst/bitirme/imsicatcher/sum


CF="/home/analyst/bitirme/imsicatcher/counter.txt"
TF="/home/analyst/bitirme/imsicatcher/TR_IMSIs"

if [ ! -f $CF ]; then
	echo "0" > $CF

fi

COUNTER=$(cat $CF)

if [ "$COUNTER" -ge 3 ]; then
	echo "Deleting $TF"
	echo "" > $TF
	echo "0" > $CF
else
	COUNTER=$((COUNTER + 1))
	echo $COUNTER > $CF
fi

python3 /home/analyst/bitirme/imsicatcher/publisher.py
