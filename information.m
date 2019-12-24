clear all; close all; fclose all; clc;
output = "info.csv";

file_list = dir([pwd "\\data\\*.*"]);
if size(file_list,1) == 0
  error("No Data")
endif

fid = fopen(output,"a");
header = "Origin Time (GMT+08),Epicenter Longitude (E),Epicenter Latitude (N),Depth (km),Magnitude (Ml)";
fprintf(fid,"%s\n",header);
fclose(fid);

for ii = 1:size(file_list,1)
  filename = [file_list(ii).folder "\\" file_list(ii).name];
  fileID = fopen(filename,"r");
  row2 = textscan(fileID,"%[^:] %*s %s",1,"HeaderLines",1);
  row3 = textscan(fileID,"%[^:] %*s %f",1);
  row4 = textscan(fileID,"%[^:] %*s %f",1);
  row5 = textscan(fileID,"%[^:] %*s %f",1);
  row6 = textscan(fileID,"%[^:] %*s %f",1);
  if (ii >= 2)
    if (row3{2} ~= longitude || row4{2} ~= latitude || row5{2} ~= depth || row6{2} ~= magnitude)
      disp("Error")
      disp(file_list(ii).name)
      break;
    endif
    continue;
  endif
  origin_time = char(row2{2});
  longitude = row3{2};
  latitude = row4{2};
  depth = row5{2};
  magnitude = row6{2};
  fclose(fileID);
  if strncmp(char(row3{1}),"#EpicenterLongitude(E)",22) == 0
    disp("Longitude Error")
    disp(file_list(ii).name)
    break;
  endif
  if strncmp(char(row4{1}),"#EpicenterLatitude(N)",21) == 0
    disp("Latitude Error")
    disp(file_list(ii).name)
    break;
  endif

  fid = fopen(output,"a");
  fprintf(fid,"%s,%.2f,%.2f,%.1f,%.1f",origin_time,longitude,latitude,depth,magnitude);
  fclose(fid);
endfor
disp("Finished")