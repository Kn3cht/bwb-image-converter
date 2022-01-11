#!/bin/sh
#
# Assumes the "magick" command has been installed
#

cat "./script/header.txt"

## Imports
source "./script/utils.sh"
source "./script/constants.sh"
source "./script/progress.sh"

now=$(date)

## Folder structure
declare -a folders=("landung" "backup" "instagram" "facebook" "logo" "log")

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

## Scale images
ITER=0

for img in "${landung}"/*;
do
	ProgressBar ${ITER} ${no_files}

	# FB conversion
	createFbImages $img

	# Insta conversion
	createInstaImage $img

	ITER=$(expr $ITER + 1)
done
ProgressBar ${no_files} ${no_files}


## Delete content in landung
# echo "Purging ${landung}"
# rm "${landung}"/*

echo "\nComplete."