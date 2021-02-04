#!/bin/bash

if [ "$#" -lt 1 ] && [ "$#" -gt 2 ]; then
    echo "USAGE: $0 link [slide deck name]"
    exit
fi
BASE_LINK=$(sed 's|\(.*\)/.*|\1|' <<< $1)
MAX_SLIDES=1024

if [ "$#" -eq 2 ]; then 
    BASE_NAME=$2
else
    BASE_NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
fi

echo "Downloading slide deck from BBB, output file names will start with \"$BASE_NAME\""

for i in $(seq 1 $MAX_SLIDES); do
	echo "Downloading slide $i"
	curl "$BASE_LINK$i" \
		--silent \
		--compressed \
		--fail \
		--output "${BASE_NAME}_$i.svg" 
	if [[ $? -ne 0 ]]; then
	    echo "Slide $i could not be found, assuming slide deck ended"
	    exit
	fi
done
