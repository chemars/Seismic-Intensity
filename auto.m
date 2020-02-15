clear all; close all; fclose all; clc;
url = "https://ci.taiwan.gov.tw/dsp/history/eq_cwb/";

str = urlread(url);
zipstr = regexp(str,'\s(\w*.zip)','tokens');
filename = char(zipstr{end})
urlwrite([url filename],filename);
unzip(filename)

tmp = dir([pwd "\\2*\\*.??t"]);
for ii = 1:size(tmp,1)
  movefile([tmp(ii).folder "\\" tmp(ii).name],"data");
endfor
delete *.zip *.dat *.xml
rmdir(tmp(1).folder);

intensity
information