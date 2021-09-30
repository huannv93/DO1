#!/bin/bash

function usage {
    echo "* MiniTool: Fix Tab and Space at FRONT and END every lines *"
    echo "USAGE: $0 [-h] [--help] [-f file-path] [--file file-path]"
    exit 1
}

function fix_file {
    #fisrt expression: remove any Tab and Space at front of line
    #second expression: remove any Tab and Space at end of line
    sed -e 's/^[[:blank:]]*//g' -e 's/[[:blank:]]*$//g' $1 >result.txt
    echo "Done!, please check result.txt"
}

#Is not have any argument
if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

#Is have some arguments and now start to check ^.^
while [ "$#" -gt 0 ]; do
    case "$1" in
    -h | --help)
        usage
        shift # throw away paramater
        exit 1
        ;;

    -f | --file)
        FILE=$2

        # IF file not exists
        if ! [ -f "$FILE" ]; then
            echo "File does not exist"
            exit 2
        fi

        # IF file exists, fix it
        fix_file $FILE

        shift
        shift
        exit 1
        ;;
    *)
        usage
        ;;
    esac
done
