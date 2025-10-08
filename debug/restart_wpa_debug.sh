#!/bin/sh

# set wpa_supplicant debug level to 1, disable timestamps, disable show_keys

[ "$UID" == 0 ] || { echo "Only root can run this"; exit 0;}

LOG="/var/log/wpa_supplicant.log"

echo "Stopping NetworkManager"
service NetworkManager stop
sleep 1

echo "Killing current wpa_supplicant"
pkill -9  wpa_supplicant$
sleep 1

echo "Starting wpa_supplicant in DBUS & DEBUG mode, log is in $LOG"
/home/xoadmin/Sources/wpa-supplicant/wpa-2.10/wpa_supplicant/wpa_supplicant -i wlp0s20f3 -c /etc/wpa_supplicant/wpa_supplicant.conf -dd -B -f $LOG -u -s -O "DIR=/run/wpa_supplicant GROUP=netdev"
sleep 1

#echo "Starting NetworkManager"
#service NetworkManager start
