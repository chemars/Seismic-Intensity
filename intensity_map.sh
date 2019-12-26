#!/usr/bin/env -S bash -e
export GMT_SESSION_NAME=$$	# Set a unique session name

data=intensity.csv
info=information.csv

gmt begin intensity_map png A+m1c
gmt basemap -Jm3c -R119/123/21/26 -Ba1 -B+t"Intensity Map"
gmt coast -R119/120/25/26 -Di -W -M | gmt plot -W0.3p
gmt plot twmap.gmt -W0.3p
gawk 'BEGIN {FS=","}; {if ($7 == 1) print $3, $4, $7}' $data | gmt text -F+f12p,,black+jMC
gawk 'BEGIN {FS=","}; {if ($7 == 2) print $3, $4, $7}' $data | gmt text -F+f12p,,blue+jMC
gawk 'BEGIN {FS=","}; {if ($7 == 3 || $7 == 4) print $3, $4, $7}' $data | gmt text -F+f12p,,0/128/0+jMC
gawk 'BEGIN {FS=","}; {if (NR > 1 && $7 != 1 && $7 != 2 && $7 != 3 && $7 != 4) print $3, $4, $7}' $data | gmt text -F+f12p,,red+jMC
gawk 'BEGIN {FS=","}; {if (NR > 1) print $2, $3}' $info | gmt plot -Gred -Sa0.5c
gawk 'BEGIN {FS=","}; {if (NR > 1) print 119.2, 21.30, "Origin time: "$1}' $info | gmt text -F+f10p,,black+jML
gawk 'BEGIN {FS=","}; {if (NR > 1) print 119.2, 21.15, "Magnitude: M@-L@-"$5"  Depth: "$4" km"}' $info | gmt text -F+f10p,,black+jML
echo 119.2 21.45 "Intensity scale: CWB" | gmt text -F+f10p,,black+jML
gmt end