#!/bin/bash
sudo /home/analyst/bitirme/checkifbrokerfound.sh
run_imsi() {
	while true; do
		/home/analyst/bitirme/imsicatcher/imsicatcher.sh
	done
}

run_80211() {
	while true; do
		/home/analyst/bitirme/80211catcher/80211catcher.sh
	done
}

run_80211 &
run_imsi &

wait
