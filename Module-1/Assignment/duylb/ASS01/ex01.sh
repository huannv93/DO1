#!/bin/bash

# dir = "$1"

[ $# -eq 0 ] && {
    echo "Usage: $0 dir-name"
    exit 1
}

arrfolder=(img txt pdf)

is_directory() {
    if [ -d "${1}" ]; then
        return $(true)
    else
        return $(false)
    fi
}

if is_directory $1; then
    # check folder loop
    if ! $(is_directory $1/loop); then
        mkdir ./$1/loop
    fi

    # create folder by array
    for i in "${arrfolder[@]}"; do
        sub_folder="$1/loop/$i"
        if ! $(is_directory $sub_folder); then
            mkdir $sub_folder
        fi

        # create file and set permission
        if [ $i == "img" ]; then
            touch $sub_folder/file{01..20}.img
            find $sub_folder -type f -exec chmod 400 {} \;
        elif [ $i == "txt" ]; then
            touch $sub_folder/file{1..10}.txt
            find $sub_folder -type f -exec chmod 200 {} \;
        else
            touch $sub_folder/file{20..40}.pdf
            find $sub_folder -type f -exec chmod 700 {} \;
        fi
    done

    #  excute command ls -a and redirect the output to first 5 txt files.
    echo "----------------------------"
    cd code/loop/img
    ls -a | head -n +7 | tail -n+3

    # Inside txt directory execute commnad ls -lhr
    # and redirect output to all of pdf files.
    echo "----------------------------"
    cd ../txt
    ls -lhr ../pdf

    # With img directory must contain ouput of command ls -la
    # that was execute from 2 directory [txt] and [pdf]
    echo "----------------------------"
    cd ../img
    ls -la ../txt
    echo "----------------------------"
    ls -la ../pdf

    # Next you should backup every directories to path /root/backup
    echo "----------------------------"
    backup_folder="/root/$(date +%Y-%m-%d-%H-%M-%S)"
    cd ../../
    sudo cp -R ./loop $backup_folder

    rm -rf $backup_folder/img

    #count
    cd  $backup_folder
    for d in */ ; do
        echo "$d : $(find $d -type f | wc -l)"
    done

else
    echo "Error: $1 is not a folder."
fi
