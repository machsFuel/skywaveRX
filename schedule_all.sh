# Update Satellite Information

wget -qr https://www.celestrak.com/NORAD/elements/weather.txt -O /home/machs/skywaveRX/weather.txt
grep "NOAA 15" /home/machs/skywaveRX/weather.txt -A 2 > /home/machs/skywaveRX/weather.tle
grep "NOAA 18" /home/machs/skywaveRX/weather.txt -A 2 >> /home/machs/skywaveRX/weather.tle
grep "NOAA 19" /home/machs/skywaveRX/weather.txt -A 2 >> /home/machs/skywaveRX/weather.tle
grep "METEOR-M 2" /home/machs/skywaveRX/weather.txt -A 2 >> /home/machs/skywaveRX/weather.tle

#Remove all AT jobs

for i in `atq | awk '{print $1}'`;do atrm $i;done

#Schedule Satellite Passes:

/home/machs/skywaveRX/schedule_satellite.sh "NOAA 19" 137.1000
/home/machs/skywaveRX/schedule_satellite.sh "NOAA 18" 137.9125
/home/machs/skywaveRX/schedule_satellite.sh "NOAA 15" 137.6200
/home/machs/skywaveRX/schedule_meteor.sh "METEOR-M 2" 137.9125
