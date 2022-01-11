#!/bin/sh
#
# Assumes the "magick" command has been installed
#

source "./script/logger.sh"

function countElements {
    if [ $# -ne 1 ];
    then 
        echo "utils.sh countElements: Wrong number of parameters"
        exit 2
    fi
    ret= echo `ls $1 | wc -l`
    echo $ret 
} 

function getFileNameWithExtension {
    filename=$(basename -- "$img")
	ext="${filename##*.}"
	filename="${filename%.*}"
	filename_ext="${filename}.${ext}"
    echo $filename_ext
}

function getFileName {
    filename=$(basename -- "$img")
	filename="${filename%.*}"
    echo $filename
}

function getFileExtension {
	filename=$(basename -- "$img")
	ext="${filename##*.}"
    echo $ext
}

function createFbImages {
	filename=$(getFileName $img)
	ext=$(getFileExtension $img)

    width=$(identify -format '%w' "$img")
    height=$(identify -format '%h' "$img")

    xOffset=0
    yOffset=0

    if [ $width -lt $height ]
    then
        log_info "Image $img cannot be converted to facebook formats due to a wrong format ([width=$width] < [height=$height])"
    else
        if [ $width -gt 720 ] # & [ $height -gt 1080 ] 
        then
            # Facebook conversion s 720px
            xOffset=50
            yOffset=38
            logo=$logo_bergwacht_49
            # logo=$logo_bergwacht_svg
            fb_dest_file="${facebook}/${filename}_${fb_res_s}.${ext}"
            convert $img -resize $fb_res_s $fb_dest_file
            add_logo=$fb_dest_file
            image_with_logo=$fb_dest_file
            addLogo $add_logo $image_with_logo $xOffset $yOffset
            #logo2
            xOffset=50
            yOffset=38
            logo2=$logo_bergwacht_muenchen_98
            add_logo2=$fb_dest_file
            image_with_logo2=$fb_dest_file
            addLogo2 $add_logo $image_with_logo2 $xOffset $yOffset $logo
        else 
            log_info "Image $img too small for facebook conversion: $fb_res_s"
        fi

        if [ $width -gt 960 ] # & [ $height -gt 1080 ] 
        then
            # Facebook conversion m 960 px
            xOffset=60
            yOffset=55
            logo=$logo_bergwacht_49
            # logo=$logo_bergwacht_svg

            fb_dest_file="${facebook}/${filename}_${fb_res_m}.${ext}"
            convert $img -resize $fb_res_m $fb_dest_file
            add_logo=$fb_dest_file
            image_with_logo=$fb_dest_file
            addLogo $add_logo $image_with_logo $xOffset $yOffset
            #logo2
            xOffset=60
            yOffset=55
            logo2=$logo_bergwacht_muenchen_98
            add_logo2=$fb_dest_file
            image_with_logo2=$fb_dest_file
            addLogo2 $add_logo $image_with_logo2 $xOffset $yOffset $logo
        else 
            log_info "Image $img too small for facebook conversion: $fb_res_m"
        fi
        
        if [ $width -gt 2048 ] # & [ $height -gt 1080 ] 
        then
            # Facebook conversion x 2048 px
            xOffset=99
            yOffset=110
            logo=$logo_bergwacht_98
            fb_dest_file="${facebook}/${filename}_${fb_res_l}.${ext}"
            convert $img -resize $fb_res_l $fb_dest_file
            add_logo=$fb_dest_file
            image_with_logo=$fb_dest_file
            addLogo $add_logo $image_with_logo $xOffset $yOffset $logo
            #logo2
            xOffset=99
            yOffset=110
            logo2=$logo_bergwacht_muenchen_197
            add_logo2=$fb_dest_file
            image_with_logo2=$fb_dest_file
            addLogo2 $add_logo $image_with_logo2 $xOffset $yOffset $logo
        else
            log_info "Image $img too small for facebook conversion: $fb_res_l"
        fi
    fi
}


function createInstaImage {
    filename_ext=$(getFileNameWithExtension $img)
    ext=$(getFileExtension $img)

    insta_dest_file="${insta}/${filename_ext}"

    width=$(identify -format '%w' "$img")
    height=$(identify -format '%h' "$img")

    if [ $width -gt 1080 ] & [ $height -gt 1080 ]
    then
        # Resize
        convert $img -resize $insta_res $insta_dest_file
            # Crop
        xOffset=50
        yOffset=38
        # logo=$logo_bergwacht_muenchen
        logo=$logo_bergwacht_98
        #logo2
        xOffset=50
        yOffset=38
        logo2=$logo_bergwacht_muenchen_197
        convert $insta_dest_file -crop "${insta_res}"+0+0 +repage $insta_dest_file
        add_logo=$insta_dest_file
        #addlogo2
        add_logo2=$insta_dest_file
        image_with_logo=$insta_dest_file
        addLogo $insta_dest_file $insta_dest_file $xOffset $yOffset
        #logo2
        addLogo2 $insta_dest_file $insta_dest_file $xOffset $yOffset
    else 
        log_info "Image ${img} too small for instagram conversion"
    fi
}

function addLogo {
    # Add logo in the upper right corner 
	convert $add_logo $logo -gravity northeast -geometry +"${xOffset}"+"${yOffset}" -composite $image_with_logo
}
#logo2
function addLogo2 {
    #Add logo_bergwacht_muenchen in the lower left corner
    # convert $add_logo2 $logo2 -gravity southwest -geometry +110+116 -composite $image_with_logo
    convert $add_logo2 $logo2 -gravity southwest -geometry +"${xOffset}"+"${yOffset}" -composite $image_with_logo
}
