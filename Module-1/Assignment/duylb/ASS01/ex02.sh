#!/bin/bash

[ $# -eq 0 ] && {
    echo "USAGE: $0 [file-path] [-f | --fix] [-h | --help]"
    exit 1
}


display_help() {
    echo "Usage: $0 [file-path] [-f | --fix] [-h | --help]" >&2
    echo
    echo "   -f, --fix           fix content file"
    echo "   -h, --help          display help "
    echo
    exit 1
}

fix_file(){
    # -e 's/^ *//' --> xoa khoang trang dau dong
    # -e 's/[[:space:]]*$//' --> xoa khoang trang cuoi dong
    # -e "s/[[:space:]]\+/ /g --> xoa tab 
    cat $1 | sed -e 's/^ *//' -e 's/[[:space:]]*$//' -e "s/[[:space:]]\+/ /g" > new.txt
    echo
}

while :; do
    case "$2" in
    -h | --help)
        display_help 
        exit 0
        ;;
    -f | --fix)
        fix_file $1
        exit 0
        ;;
    -*)
        echo "Error: Unknown option: $2" >&2
        exit 1
        ;;
    *) # No more options
        cat $1
        echo
        break
        ;;
    esac
done
