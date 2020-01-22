#!/usr/bin/env -S bash -e
export GMT_SESSION_NAME=$$	# Set a unique session name

data=intensity.csv
info=information.csv
ts=12p
tt=0

gmt begin intensity_map_2000 png A+m1c
gmt basemap -Jm3c -R119/123/21/26 -Ba1 -B+t"Intensity Map"
gmt coast -R119/120/25/26 -Di -W -M | gmt plot -W0.3p
gmt plot twmap.gmt -W0.3p
gawk 'BEGIN {FS=","}; {if ($5 == 0 || $5 == 1) print $3, $4, $5}' $data | gmt text -F+f$ts,$tt,black+jMC
gawk 'BEGIN {FS=","}; {if ($5 == 2) print $3, $4, $5}' $data | gmt text -F+f$ts,$tt,blue+jMC
gawk 'BEGIN {FS=","}; {if ($5 == 3 || $5 == 4) print $3, $4, $5}' $data | gmt text -F+f$ts,$tt,0/128/0+jMC
gawk 'BEGIN {FS=","}; {if (NR > 1 && $5 >= 5) print $3, $4, $5}' $data | gmt text -F+f$ts,$tt,red+jMC
gawk 'BEGIN {FS=","}; {if (NR > 1) print $2, $3}' $info | gmt plot -Gred -Sa0.5c
gawk 'BEGIN {FS=","}; {if (NR > 1) print 119.2, 21.30, "Origin time: "$1}' $info | gmt text -F+f10p,,black+jML
gawk 'BEGIN {FS=","}; {if (NR > 1) print 119.2, 21.15, "Magnitude: M@-L@-"$5"  Depth: "$4" km"}' $info | gmt text -F+f10p,,black+jML
echo 119.2 21.45 "Intensity scale: CWB (2000)" | gmt text -F+f10p,,black+jML
gmt end