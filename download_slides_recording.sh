#!/bin/bash

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "USAGE: $0 link [slide deck name]"
	echo "Found $# parameters"
    exit
fi
BASE_LINK=$(sed 's|\(.*\)/.*|\1|' <<< $1)
MAX_SLIDES=1024

RANDOM_BASE_NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

if [ "$#" -eq 2 ]; then 
    BASE_NAME=$2
else
    BASE_NAME=$RANDOM_BASE_NAME
fi

echo "Base link is \"$BASE_LINK\""

if [[ -d "$RANDOM_BASE_NAME" ]]; then
    echo "Output folder \"$RANDOM_BASE_NAME\" already exists, exiting."
    exit
fi
mkdir $RANDOM_BASE_NAME || exit
cd $RANDOM_BASE_NAME

for i in $(seq 1 $MAX_SLIDES); do
	echo "Downloading slide $i"
	curl "$BASE_LINK/slide-$i.png" \
		--silent \
		--compressed \
		--fail \
		--output "${RANDOM_BASE_NAME}_$i.png"
	if [[ $? -ne 0 ]]; then
	    echo "Slide $i could not be found, assuming slide deck ended"
	    break
	fi
done

echo "Download finished, converting and merging pdf"
find -name "*.png" -exec convert {} {}.pdf \;
pdfunite $(ls -v $RANDOM_BASE_NAME_*.pdf) $BASE_NAME.pdf || exit
mv $BASE_NAME.pdf ..
cd ..
rm -r $RANDOM_BASE_NAME || echo "Could not delete temporary output folder \
\"$RANDOM_BASE_NAME\""

echo "PDF creation successful, output file is \"$BASE_NAME.pdf\"."
