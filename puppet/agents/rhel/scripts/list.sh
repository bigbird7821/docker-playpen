#!/bin/bash

list=($(cat ciphers_on_pe201984_centos7.csv | cut -f1 -d","))
list2=($(for cipher in "${list[@]}"; do
    echo "\"${cipher}\","
done))
echo "[${list2[@]}]" | sed 's/,]/]/g'