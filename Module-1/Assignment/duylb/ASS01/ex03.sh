#!/bin/bash

display_help() {
    echo "USAGE: $0 [-l location] [--location location] [-e extension] [--extension extension] [-h] [--help]"
    echo "Example:"
    echo "$0 -l /etc/ -e txt -s"
    echo "$0 -e img --stats"
    exit 1
}

# [ $# -eq 0 ] && {
#     display_help
# }

check_file() {
    # echo "SUM: $(find $1 -type f -exec du -ch {} + | grep $)"
    echo "SIZE: $(find $1  -type f -exec ls -l {} \; | awk '{sum += $5} END {print sum/1024} ') KB"
    echo "TOTAL: $(find $1 -type f -name "*.$2" | wc -l) "
}

check_file_ext() {
    echo "SIZE: $(find -type f -name "*.$2" -exec ls -l {} \; | awk '{sum += $5} END {print sum/1024} ') KB"
    echo "TOTAL: $(find -type f -name "*.$2" | wc -l) "
}




while :; do
    case "$1" in
    -h | --help)
        display_help
        exit 0
        ;;
    -l | --location)
        LOCATION="$2"
        check_file $LOCATION
        LOC_SET=1
        exit 0
        ;;
    -e | --extension)
        EXT="$2"
        check_file_ext $1 $EXT
        exit 0
        ;;
    -s | --stats)
        STATS=1
        shift
        ;;
    -*)
        echo "Error: Unknown option: $1" >&2
        exit 1
        ;;
    *) # No more options
        check_file $(pwd)
        break
        ;;
    esac
done
