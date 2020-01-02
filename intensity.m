clear all; close all; fclose all; clc;
pkg load signal
output = "intensity.csv";
delimiter = "";
ignore_row = 22;
ns_column = 3;
ew_column = 4;
ud_column = 2;

file_list = dir([pwd "\\data\\*.??t"]);
if size(file_list,1) == 0
  error("No Data")
endif

fid = fopen(output,"w");
header = "Station code,Station name,Station longitude (E),Station latitude (N),CWB Intensity 2000,PGA 2000 (gal),CWB Intensity,PGA (gal),PGV (cm/s)";
fprintf(fid,"%s\n",header);
fclose(fid);

for ii = 1:size(file_list,1)
  disp(ii)
  filename = [file_list(ii).folder "\\" file_list(ii).name];
  fileID = fopen(filename,"r");
  row8 = textscan(fileID,"%s %s",1,"HeaderLines",7);
  row9 = textscan(fileID,"%[^:] %*s %s",1);
  row10 = textscan(fileID,"%[^:] %*s %[^\r\n]",1);
  row11 = textscan(fileID,"%[^:] %*s %f",1);
  row12 = textscan(fileID,"%[^:] %*s %f",1);
  row13 = textscan(fileID,"%[^:] %*s %[^\r\n]",1);
  row14 = textscan(fileID,"%[^:] %*s %s",1);
  row15 = textscan(fileID,"%[^:] %*s %f",1);
  row16 = textscan(fileID,"%[^:] %*s %f",1);
  row17 = textscan(fileID,"%[^:] %*s %[^\r\n]",1);
  station_code = char(row9{2});
  station_name = char(row10{2});
  station_lon = row11{2};
  station_lat = row12{2};
  sample_rate = row16{2};
  fclose(fileID);  
  disp("")
  if strncmp(char(row16{1}),"#SampleRate(Hz)",15) == 0
    disp("Sample Rate Error")
    disp(file_list(ii).name)
    break;
  endif
  if isnumeric(sample_rate) == 0
    disp("Sample Rate Number Error")
    disp(file_list(ii).name)
    break;
  endif
  if strncmp(char(row17{2}),"gal.",4) == 0
    disp("Unit Error")
    disp(file_list(ii).name)
    break;
  endif

  data = dlmread(filename,delimiter,ignore_row,0);
  ns = data(:,ns_column);
  ew = data(:,ew_column);
  ud = data(:,ud_column);
  pga_ns = max(abs(ns));
  pga_ew = max(abs(ew));
  pga_ud = max(abs(ud));
  pga_2k = max([pga_ns pga_ew pga_ud]);
  if (pga_2k < 0.8)
    I_2k = 0;
  elseif (pga_2k >= 0.8 && pga_2k < 2.5)
    I_2k = 1;
  elseif (pga_2k >= 2.5 && pga_2k < 8.0)
    I_2k = 2;
  elseif (pga_2k >= 8.0 && pga_2k < 25.0)
    I_2k = 3;
  elseif (pga_2k >= 25.0 && pga_2k < 80.0)
    I_2k = 4;
  elseif (pga_2k >= 80.0 && pga_2k < 250.0)
    I_2k = 5;
  elseif (pga_2k >= 250.0 && pga_2k < 400.0)
    I_2k = 6;
  elseif (pga_2k >= 400.0)
    I_2k = 7;
  endif

  [b,a] = butter(4,10/(sample_rate/2),"low");
  ns_f = filter(b,a,ns);
  ew_f = filter(b,a,ew);
  ud_f = filter(b,a,ud);
  tf = sqrt(ns_f.^2 + ew_f.^2 + ud_f.^2);
  pga_new = max(tf);
  num = size(ns,1);
  n = [0:(num-1)]';
  t = n / sample_rate;
  ns_v = cumtrapz(t,ns);
  ew_v = cumtrapz(t,ew);
  ud_v = cumtrapz(t,ud);
  [bb,aa] = butter(4,0.075/(sample_rate/2),"high");
  ns_vf = filter(bb,aa,ns_v);
  ew_vf = filter(bb,aa,ew_v);
  ud_vf = filter(bb,aa,ud_v);
  tvf = sqrt(ns_vf.^2 + ew_vf.^2 + ud_vf.^2);
  pgv = max(tvf);
  if (pga_new < 0.8)
    I_new = "0";
  elseif (pga_new >= 0.8 && pga_new < 2.5)
    I_new = "1";
  elseif (pga_new >= 2.5 && pga_new < 8.0)
    I_new = "2";
  elseif (pga_new >= 8.0 && pga_new < 25.0)
    I_new = "3";
  elseif (pga_new >= 25.0 && pga_new < 80.0)
    I_new = "4";
  elseif (pga_new >= 80.0)
    if (pgv < 15)
      I_new = "4";
    elseif (pgv >= 15 && pgv < 30)
      I_new = "5-";
    elseif (pgv >= 30 && pgv < 50)
      I_new = "5+";
    elseif (pgv >= 50 && pgv < 80)
      I_new = "6-";
    elseif (pgv >= 80 && pgv < 140)
      I_new = "6+";
    elseif (pgv >= 140)
      I_new = "7";
    endif
  endif

  fid = fopen(output,"a");
  fprintf(fid,"%s,%s,%.4f,%.4f,%.0f,%.3f,%s,%.3f,%.3f\n",station_code,station_name,station_lon,station_lat,I_2k,pga_2k,I_new,pga_new,pgv);
  fclose(fid);
endfor