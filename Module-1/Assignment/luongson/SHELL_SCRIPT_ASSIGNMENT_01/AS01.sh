#!/bin/bash

#Write a shellscript require input arguments from user [This case argument was directory]
MAIN_DIR="loop"
SUB_DIR=("img" "txt" "pdf")
BACKUP_DIR="backup"
DATE=$(date)

#=================#
#*** Functions ***#
#=================#

function usage {
    echo "USAGE: $0 [-h] [--help] [-d] [--directory]"
    exit 1
}

#CREATE a sub-directory with name loop
#Inside loop create 3 sub-directory with name following these [img ; txt ; pdf]
function create_folder {
    for DIR in ${SUB_DIR[@]}; do
        mkdir -p $MAIN_DIR"/"$DIR
    done
}

# OPTIONS:
#   - extension's name
#   - start number
#   - end number
function create_files_with_options {
    # $1: $DIR
    # $2: $START_NUM
    # $3: $END_NUM

    for i in $(seq $2 $3); do
        touch $MAIN_DIR"/"$1/"file"$i"."$1
    done
}

function create_separate_files {
    for DIR in ${SUB_DIR[@]}; do
        case $DIR in
        img)
            START_NUM=1
            END_NUM=20
            ;;
        txt)
            START_NUM=1
            END_NUM=10
            ;;
        pdf)
            START_NUM=21
            END_NUM=40
            ;;
        esac

        create_files_with_options $DIR $START_NUM $END_NUM
    done
}

function add_permissions {
    for DIR in ${SUB_DIR[@]}; do
        case $DIR in
        img)
            chmod 444 $MAIN_DIR"/"$DIR"/"*
            ;;
        txt)
            chmod 555 $MAIN_DIR"/"$DIR"/"*
            ;;
        pdf)
            chmod 777 $MAIN_DIR"/"$DIR"/"*
            ;;
        esac
    done
}

function excute_command_ls_img {
    RESULT_LS=$(ls -a $MAIN_DIR"/img")
    RESULT_5_FILES=$(ls loop/txt | head -5)
    for FILE in ${RESULT_5_FILES[@]}; do
        chmod +w $MAIN_DIR"/txt/"$FILE
        echo $RESULT_LS >$MAIN_DIR"/txt/"$FILE
        chmod -w $MAIN_DIR"/txt/"$FILE
    done
}

function excute_command_ls_txt {
    ls -lhr $MAIN_DIR"/txt" | tee $MAIN_DIR"/pdf/"*
}

function ouput_of_command_ls {
    ls -la $MAIN_DIR"/txt" >$MAIN_DIR"/img/ouput_of_command_ls_txt.txt"
    ls -la $MAIN_DIR"/pdf" >$MAIN_DIR"/img/ouput_of_command_ls_pdf.txt"
}

function backup {
    mkdir -p "$BACKUP_DIR/$DATE"
    cp -r $MAIN_DIR"/"* "$BACKUP_DIR/$DATE"
    rm -rf $MAIN_DIR"/img/"*
}

function countfile {
    COUNT_IMG=$(ls "$BACKUP_DIR/$DATE/img" | grep .img | wc -l)
    COUNT_TXT=$(ls "$BACKUP_DIR/$DATE/txt" | grep .txt | wc -l)
    COUNT_PDF=$(ls "$BACKUP_DIR/$DATE/pdf" | grep .pdf | wc -l)

    echo "==Total files in every directory in backup folder=="
    echo "img: $COUNT_IMG files"
    echo "txt: $COUNT_TXT files"
    echo "pdf: $COUNT_PDF files"
}

#=== END FUNCTIONS ===#

#============#
#*** MAIN ***#
#============#
#FIRST check if argument that user input is Directory or not.

#is not have any argument
if [ "$#" -eq 0 ]; then
    echo "USAGE: $0 [-h] [--help] [-d] [--directory]"
    exit 1
fi

#is have some arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
    -h | --help)
        echo "USAGE: $0 [-h] [--help] [-d] [--directory]"
        shift # throw away paramater
        exit 1
        ;;
    -c | --clear)
        # delete all directory and subdirectories inside it (DEV run only)
        rm -rf loop
        rm -rf backup
        shift
        exit 1
        ;;
    -d | --directory)
        # argument that user input is Directory

        # Function create folders and files
        create_folder
        create_separate_files

        # Function check total file

        # Function add permission read and write
        add_permissions

        # Function redirect output
        excute_command_ls_img
        excute_command_ls_txt
        ouput_of_command_ls

        # Function backup
        backup

        # Function countfile
        countfile

        shift
        exit 1
        ;;
    *)
        usage
        ;;
    esac
done
