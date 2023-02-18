#!/bin/bash

CALL="/root/garbageman.call"
WAV="/var/spool/asterisk/monitor/garbageman-in.wav"

cp -p "${CALL}" /var/spool/asterisk/outgoing

sleep 60

if [ -f "${WAV}" ]
then
	mv "${WAV}" /var/www/html/audio
fi
