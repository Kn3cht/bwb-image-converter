#!/bin/bash
#
# Assumes the "magick" command has been installed
#

clear=$1

cat "./script/header.txt"

## Imports
source "./script/utils.sh"
source "./script/constants.sh"
source "./script/progress.sh"

now=$(date)

## Folder structure
declare -a folders=("landung" "backup" "instagram" "facebook" "logo")

if [ ! -d "${src_folder}" ];
   then
		mkdir "${src_folder}"
		echo "Folder ${src_folder} created"
	fi

for subfolder in "${folders[@]}"
do
   if [ ! -d "${src_folder}${subfolder}" ];
   then
		mkdir "${src_folder}${subfolder}"
		echo "Folder ${src_folder}${subfolder} created"
	fi
done

# create log file
if [[ ! -e ./log ]]; then
    mkdir ./log
fi

## Check if folder empty
no_files=$(countElements ${landung})
echo "${no_files} file(s) found in ${landung}"

if [ ! $no_files -gt 0 ];
then
	exit 1
fi

echo "Starting backup from ${landung} to ${backup}"
cp "${landung}/"* $backup
echo "Backup complete"

cd ${landung}
for f in *; do mv "$f" `echo $f | tr ' ' '_'`; done
cd ../..

ITER=0

for img in $landung/*;
do
	ProgressBar ${ITER} ${no_files}
	
	# FB conversion
	createFbImages $img

	# Insta conversion
	createInstaImage $img

	ITER=$(expr $ITER + 1)
done
ProgressBar ${no_files} ${no_files}

echo " Complete."

if [ -z "$1" ] & [ "$1" = "--clear" ];
then
    ## Delete content in landung
	echo "Purging ${landung}"
	rm "${landung}"/*
fi