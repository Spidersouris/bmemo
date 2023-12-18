#!/bin/bash

FILE=""
SEP="="
P=0
N=0
T=0

# https://stackoverflow.com/a/33826763
while [[ "$#" -gt 0 ]]; do
    if [[ "$1" =~ ^- ]]; then
      case $1 in
          -s|--sep) SEP="$2"; shift;;
          (*) echo "Unknown parameter passed: $1"; exit 1;;
      esac
    else
      FILE="$1"
    fi
    shift
done

if [ -z "$FILE" ]; then echo "Missing file"; exit 1; else readarray -t vocab < $FILE; fi;
if [ -z "$SEP" ]; then echo "Missing separator. If space, indicate \" \""; exit 1; fi;

case $SEP in
    *)
      ! [[ ${vocab[*]} =~ $SEP ]] && echo "Separator not found" && exit 1;;
esac

while true; do
    index=$(($RANDOM % ${#vocab[@]}))
    line=${vocab[$index]}
    sep_index=${line%%$SEP*}}
    sep_index=${#sep_index}

    question=${line:$sep_index}
    answer=${line:0:$sep_index-1}

    echo "P: ${P} | N: ${N} | T: ${T}"
    echo $question
    read
    echo $answer
    read user_ans
    if [[ $user_ans == [yY] ]]; then ((P++)) elif [[ $user_ans == [Nn] ]]; then ((N++)) fi; ((T++))
done