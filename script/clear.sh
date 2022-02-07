#!/bin/bash
#
# Assumes the "magick" command has been installed
#
# DEV only dont execute!!!!!
find ./fotos/ ! -name 'logo' -type f -exec rm -f {} +
