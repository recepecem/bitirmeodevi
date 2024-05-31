# "CROWD DETECTION USING IMSI AND IEEE 802.11 DATA"

Within this project I aimed to detect number of people in an area using radio signals. There are 3 files, one that named "kali" includes main features.

You need an rtl-sdr device to capture GSM data and a wifi adaptor that supports monitor mode to capture 802.11 data.

You may read the "speech" file to in order to understand my motivation and some essentials.

flaws and improvable featues:

  1) You may assign static IP to broker. I added additional codes to whom cannot assign static IP addresses.
  2) Instead of manual arping service, I might use binary search to find broker's IP address.
  3) Both IEEE 802.11 and IMSI signals have a field named 'decibel' which indicates power of the signal. By adjusting this value you may fine tune the program according to your use case.
  4) After capturing enough amount of data, data analysis can be done to indicate crowd of a place by time.
  5) The web-site has XSS vulnerability. By hijacking IOT devices and sending your desired data, a DOM XSS might be performed by an adversary.
