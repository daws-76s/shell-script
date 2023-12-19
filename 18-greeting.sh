#!/bin/bash

NAME=""
WISHES=""

USAGE(){
    echo "USGAE:: $(basename $0) -n <name> -w <wishes>"
    echo "Options::"
    echo " -n, Specify the name (mandatory)"
    echo " -w, Specify the wishes. ex, Good Morning"
    echo " -h, Display Help and exit"
}

while getopts ":n:w:h" opt; do
    case $opt in
        n) NAME="$OPTARG";;
        w) WISHES="$OPTARG";;
        \?) echo "invalid options: -"$OPTARG"" >&2; USAGE; exit;;
        :) USAGE; exit;;
        h) USAGE; exit;;
    esac
done
