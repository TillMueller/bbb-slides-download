#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "USAGE: $0 [LINK]"
    exit
fi
BASE_LINK=$1
MAX_SLIDES=1024

UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
for i in $(seq 1 $MAX_SLIDES); do
	echo "Downloading slide $i"
	curl "$BASE_LINK$i" \
		--compressed \
		--fail \
		--output "${UUID}_$i.svg"
	if [[ $? -ne 0 ]]; then
	    echo "Done, last slide was $i"
	    exit
	fi
done
