#!/bin/bash

PREFIX="garbageday"
MQTT_HOST="192.0.1.0"
URL="http://192.0.1.2/audio/garbageman-in.wav"
WAV="/tmp/garbageman-in.wav"
DSDIR="${HOME}/deepspeech"

wget -q -O "${WAV}" "${URL}"

if [ -s "${WAV}" ]
then
	TEXT=$(${DSDIR}/bin/deepspeech_text "${WAV}" | cut -c -200)
	mosquitto_pub -h "${MQTT_HOST}" -t "${PREFIX}/text" -r -m "${TEXT}"
	DELAY=0
	echo "${TEXT}" |grep -q "delaying" && DELAY=1
	mosquitto_pub -h "${MQTT_HOST}" -t "${PREFIX}/delay" -r -m "${DELAY}"
else
	mosquitto_pub -h "${MQTT_HOST}" -t "${PREFIX}/delay" -r -m "0"
fi

rm -f "${WAV}"
