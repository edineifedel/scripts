#!/bin/bash

# script linux that notifies when tomcat is ready (started) 
# needs curl and libnotify-bin (notifications) installed

status_ok="200"

while true
do
	sleep 5
	server_status=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost:8080)
	if [ $server_status -ne $status_ok ] 
	then
		notify-send --expire-time=2000 --icon=/usr/share/icons/gnome/scalable/status/error.svg Tomcat down
		break
	fi
	if [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:8080 | grep 'Coyote'`" != "" ] 
	then
		notify-send --expire-time=2000 --icon=/usr/share/icons/gnome/scalable/emotes/face-monkey.svg Tomcat ready
		break
	fi
done