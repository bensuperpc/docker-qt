#!/usr/bin/env bash
#//////////////////////////////////////////////////////////////
#//                                                          //
#//  Script, 2020                                            //
#//  Created: 21, November, 2020                             //
#//  Modified: 08, October, 2023                             //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

if (( $# >= 2 )); then
    DOCKER_IMAGE="$1"
    OUTPUT_FILE="$2"
    install -Dv /dev/null "$DOCKER_IMAGE".tar.xz && docker pull "$DOCKER_IMAGE" && docker save "$DOCKER_IMAGE" | xz -e7 -v -T0 > "$OUTPUT_FILE".tar.xz
else
    echo "Usage: ${0##*/} <docker image> <output file>"
    exit 1
fi


