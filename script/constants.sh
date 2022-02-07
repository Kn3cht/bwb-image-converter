#!/bin/bash
#
# Assumes the "magick" command has been installed
#

# fb_res_s="720x630"
# fb_res_m="960x633"
# fb_res_l="2048x1005"

fb_res_s="720"
fb_res_m="960"
fb_res_l="2048"

force_image_conversion=1

insta_res="1080^x1080"

## Folders
src_folder="./fotos/"

landung="${src_folder}landung"
backup="${src_folder}backup"
facebook="${src_folder}facebook"
insta="${src_folder}instagram"
logo="${src_folder}logo"

# Logos
logo_bergwacht_svg="${src_folder}logo/logo_bergwacht_svg.svg"

# create scaled images if not existent
FILE="${src_folder}logo/logo_bergwacht_49.png"
if [ ! -f "$FILE"  ] | [ $force_image_conversion = 1 ]; then
    echo "Creating logo_bergwacht_49.png"
    convert -density 288 $logo_bergwacht_svg -resize 5% "${src_folder}logo/logo_bergwacht_49.png"
fi

FILE="${src_folder}logo/logo_bergwacht_98.png"
if [ ! -f "$FILE" ] | [ $force_image_conversion = 1 ]; then
    echo "Creating logo_bergwacht_98.png"
    convert -density 288 $logo_bergwacht_svg -resize 10% "${src_folder}logo/logo_bergwacht_98.png"
fi

FILE="${src_folder}logo/logo_bergwacht_197.png"
if [ ! -f "$FILE" ] | [ $force_image_conversion = 1 ]; then
    echo "Creating logo_bergwacht_197.png"
    convert -density 288 $logo_bergwacht_svg -resize 50% "${src_folder}logo/logo_bergwacht_197.png"
fi

logo_bergwacht_49="${src_folder}logo/logo_bergwacht_49.png"
logo_bergwacht_98="${src_folder}logo/logo_bergwacht_98.png"
logo_bergwacht_197="${src_folder}logo/logo_bergwacht_197.png"

#logo_bergwacht_muenchen_350="${src_folder}logo/logo_bergwacht_muenchen_350.png"
#logo_bergwacht_muenchen_294="${src_folder}logo/logo_bergwacht_muenchen_294.png"
logo_bergwacht_muenchen_197="${src_folder}logo/logo_bergwacht_muenchen_197.png"
logo_bergwacht_muenchen_98="${src_folder}logo/logo_bergwacht_muenchen_98.png"