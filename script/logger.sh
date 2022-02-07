#!/bin/bash
#
# Assumes the "magick" command has been installed
#

function log_info {
    echo "$now [INFO]: $1 " >> "./log/info.log"
}