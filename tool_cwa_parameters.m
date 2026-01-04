clear all; close all; fclose all; clc;
filename = dir("*.txt");
if size(filename,1) == 0
  error("No Data")
endif
output = [filename(1).name(1:end-4) "_new.csv"];

fileID = fopen(filename(1).name,"r");
rawdata = textscan(fileID,["%s%s%s%s" repmat("%s%f",[1,10]) "%s%s%s%f%s%f"],"Delimiter",{",","="},"HeaderLines",5);
station_code = rawdata{2};
station_name = rawdata{4};
station_lon = rawdata{6};
station_lat = rawdata{8};
I_new = rawdata{26};
pga = rawdata{28};
pgv = rawdata{30};
fclose(fileID);

[nrows,ncols] = size(station_code);
fid = fopen(output,"w");
header = "Station Code,Station Name,Station Longitude (E),Station Latitude (N),CWA Intensity,PGA (gal),PGV (cm/s)";
fprintf(fid,"%s\n",header);
formatSpec = "%s,%s,%.2f,%.2f,%s,%.2f,%.2f\n";
for row = 1:nrows-1
    fprintf(fid,formatSpec,station_code{row,1},station_name{row,1},station_lon(row,1),station_lat(row,1),I_new{row,1},pga(row,1),pgv(row,1));
endfor
fclose(fid);