#!/bin/bash
case "$1" in

  disk)
    disks=($(cat /proc/diskstats | awk '{print $3}' | grep -v 'ram\|loop\|sr\|fd\|dm-\|md' | grep -v '[0-9]'))
    counter=${#disks[@]}
    echo "{"
    echo -e "\t\"data\":[\n"
    for (( i=0; ${counter}>i; i++ ))
    do
       if (( $i == $counter-1 )); then
         echo -e "\t{ \"{#DISKDEV}\":\"${disks[$i]}\" }"
       else
         echo -e "\t{ \"{#DISKDEV}\":\"${disks[$i]}\" },"
       fi
    done
    echo -e "\n\t]\n"
    echo "}"
  ;;

  partition)
    partitions=($(cat /proc/diskstats | awk '{print $3}' | grep -v 'ram\|loop\|sr\|fd\|dm-\|md' | grep '[0-9]'))
    counter=${#partitions[@]}
    echo "{"
    echo -e "\t\"data\":[\n"
    for (( i=0; ${counter}>i; i++ ))
    do
       if (( $i == $counter-1 )); then
         echo -e "\t{ \"{#DISKPART}\":\"${partitions[$i]}\" }"
       else
         echo -e "\t{ \"{#DISKPART}\":\"${partitions[$i]}\" },"
       fi
    done
    echo -e "\n\t]\n"
    echo "}"
  ;;

  mdraid)
    mddevices=($(cat /proc/diskstats | awk '{print $3}' | grep 'md'))
    counter=${#mddevices[@]}
    echo "{"
    echo -e "\t\"data\":[\n"
    for (( i=0; ${counter}>i; i++ ))
    do
       if (( $i == $counter-1 )); then
         echo -e "\t{ \"{#MDDEV}\":\"${mddevices[$i]}\" }"
       else
         echo -e "\t{ \"{#MDDEV}\":\"${mddevices[$i]}\" },"
       fi
    done
    echo -e "\n\t]\n"
    echo "}"
  ;;

  netif)
    interfaces=($(basename -a /sys/class/net/*))
    counter=${#interfaces[@]}
    echo "{"
    echo -e "\t\"data\":[\n"
    for (( i=0; i<${counter}; i++ ))
    do
       if (( $i == $counter-1 )); then
         echo -e "\t{ \"{#NETIF}\":\"${interfaces[$i]}\" }"
       else
         echo -e "\t{ \"{#NETIF}\":\"${interfaces[$i]}\" }",
       fi
    done
    echo -e "\n\t]\n"
    echo "}"
  ;;

  ping)
    echo 0
  ;;


  *)
    echo "wrong argument"

esac
