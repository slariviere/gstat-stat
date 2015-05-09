#!/bin/bash 

base_folder=$(pwd)/.gstat-stat        # Folder to keep data
disk_idetnifier="ada"                 # Disk device identifier 
iterations=3600                       # Number of iteration to gather data
log_filename=$base_folder/stats.out   # Filename of the file containing gstat data

trap printStats_int INT

i=0

# Get the list of drives used and put it in the $drive array
function getDrives(){
    j=0
    for drive in $(gstat -b | grep $disk_idetnifier | awk '{print $10}')
    do
        drives[$j]=$drive
        j=$((j+1))
    done
}

# Output value of the gathered data
function printStats(){
    j=0
    tot=$(grep -c "$drives" "$log_filename" | sed 's/ //g')
    echo "L(q)  ops/s    r/s   kBps   ms/r    w/s   kBps   ms/w   %busy Name"

    for drive in "${drives[@]}"
    do
        grep "$drive $log_filename" | awk -v tot="$tot" -v disk="$drive" '{a+=$1} {b+=$2} {c+=$3} {d+=$4} {e+=$5} {f+=$6} {g+=$7} {h+=$8} {i+=$9} END {a=a/tot} END {b=b/tot} END {c=c/tot} END {d=d/tot} END {e=e/tot} END {f=f/tot} END {g=g/tot} END {h=h/tot} END {i=i/tot} END {printf "%4.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %5s", a,b,c,d,e,f,g,h,i,disk} '
        j=$((j+1))
        echo ""
    done
}

# Output value of the gathered data
function printStats_int(){
    echo ""
    printStats
    exit 1
}

# Gather data from gstat
function getData(){
    if [ ! -d "$base_folder" ]; then
        mkdir "$base_folder"
    fi

    if [ -f "$log_filename" ]; then
        echo > "$log_filename"
    fi

    while [ $i -lt "$iterations" ] ;
    do
        gstat -b | grep "$disk_idetnifier" >> "$log_filename"
        i=$((i+1))
    done
}

main() {
    getDrives
    getData
    printStats
}

main "$@"
