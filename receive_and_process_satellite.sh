#!/bin/bash

# $1 = Satellite Name
# $2 = Frequency
# $3 = FileName base
# $4 = TLE File
# $5 = EPOC start time
# $6 = Time to capture

#disable eth0 for cleaner noise floor
#user needs ifconfig NOPASSWD permissions in sudoers
sudo ifconfig eth0 down

# gain setting, device ID are installation dependant.
timeout $6 rtl_fm -f ${2}M -s 60k -d 067 -g 27 -p 67 -E deemp -F 9 - | sox -b16 -c1 -V1 -es -r 60000 -t raw - $3.wav rate 11025

#restore eth connection and setup defualt gateway to outside world
sudo ifconfig eth0 up
sudo route add -net 0.0.0.0 gw 192.168.1.1 eth0
screen -d -m -S ais rtl_ais -d 0 -p 47 -n -g 36 -h 5.9.207.224 -P 7865

PassStart=`expr $5 + 90`

if [ -e $3.wav ]
  then
    /usr/local/bin/wxmap -T "${1}" -H $4 -p 0 -l 0 -o $PassStart ${3}-map.png
    /usr/local/bin/wxtoimg -m ${3}-map.png -e MCIR -v $3.wav $3-MCIR.png
    /home/machs/gdrive-linux-arm upload --parent 0B7zPlhkVKJtHLV9WWDExOFZzdTg $3-MCIR.png
   rm $3*
fi
