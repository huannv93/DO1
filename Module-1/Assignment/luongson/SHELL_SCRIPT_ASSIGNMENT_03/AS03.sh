#!/bin/bash

LOCATION="."
EXT_STATS=0

function usage {
    echo "USAGE: $0 [-l location] [--location location] [-e extension] [--extension extension] [-h] [--help]"
    echo "Example:"
    echo "$0 -l /etc/ -e txt -s"
    echo "$0 -e img --stats"
    exit 1
}

function folder_statistics_all {
    echo "ALL"
    # echo $LOCATION
    echo $(find $LOCATION)
}

function folder_statistics_filter_by_ext {
    echo "EXT"
    echo $LOCATION
    echo $1
}

#Is not have any argument
if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

#Is have some arguments and now start to check ^.^
while [ $# -gt 0 ]; do
    case $1 in
    -l | --location)
        LOCATION="$2"
        if ! [ -d "$LOCATION" ]; then
            usage
        fi

        shift
        shift
        ;;
    -e | --extension)
        EXT="$2"
        if [ -z $EXT ]; then
            usage
        fi
        EXT_STATS=1
        shift
        shift
        ;;
    -s | --stats)
        STATS=1
        shift
        ;;
    -h | --help)
        shift
        usage
        ;;
    "")
        usage
        ;;
    *)
        usage
        ;;
    esac
done

if [ $EXT_STATS -eq 0 ]; then
    folder_statistics_all
elif [ $EXT_STATS -eq 1 ]; then
    folder_statistics_filter_by_ext $EXT
fi
