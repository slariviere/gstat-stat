#!/bin/bash -x

basefolder=$(pwd)/.gstat-stat   # Folder to keep data
disk_idetnifier="ada"           # Disk device identifier 
iterations=10000                # Number of iteration to gather data

i=0

if [ ! -d $basefolder ]; then
    mkdir $basefolder
fi

while [ $i -lt  $iterations ] ;
do
    gstat -b | grep $disk_idetnifier >> $basefolder/stats.out
    i=$(($i+1))
done
