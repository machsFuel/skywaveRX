#!/bin/bash

# $1 = Satellite Name
# $2 = Frequency
# $3 = FileName base
# $4 = TLE File
# $5 = EPOC start time
# $6 = Time to capture

#disable eth0 for cleaner noise floor
sudo ifconfig eth0 down

#record pass
timeout $6 /home/machs/skywave.py --destfile $3 

#restore ethernet comms and set gateway for the intertubes
sudo ifconfig eth0 up
sudo route add -net 0.0.0.0 gw 192.168.1.1 eth0
screen -d -m -S ais rtl_ais -d 0 -p 47 -n -g 36 -h 5.9.207.224 -P 7865

#decode pass
/home/machs/meteor_decoder/medet ${3}.s $3 -q

#if decode sucessful, upload to drive 
if [ -e $3.bmp ]
  then
    /home/machs/gdrive-linux-arm upload --parent 0B7zPlhkVKJtHLV9WWDExOFZzdTg $3.bmp
#    convert $3.bmp $3.png
fi
# clean up working files
rm $3*

