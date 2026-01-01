clear all; close all; fclose all; clc;
authorization = "";
if isempty(authorization)
    error("Require Authorization Key. See https://opendata.cwa.gov.tw/about/application/general")
endif

json_name = "E-A0015-004.json";
urlwrite(["https://opendata.cwa.gov.tw/fileapi/v1/opendataapi/E-A0015-004?Authorization=" authorization "&downloadType=WEB&format=JSON"],json_name);
jsonStr = fileread(json_name);
jsonData = jsondecode(jsonStr);
file_name = [jsonData.cwaopendata.Dataset.Resource.ResourceDesc ".zip"]
if isfile(file_name)
    error("Already Download")
endif

urlwrite(jsonData.cwaopendata.Dataset.Resource.ProductURL,file_name);
unzip(file_name);
tmp = dir([pwd "\\2*\\*.??t"]);
for ii = 1:size(tmp,1)
  movefile([tmp(ii).folder "\\" tmp(ii).name],"data");
endfor
rmdir(tmp(1).folder);

eqyr = jsonData.cwaopendata.Dataset.Resource.ResourceDesc(1:4);
eqnum = jsonData.cwaopendata.Dataset.Resource.ResourceDesc(1:7);
urlwrite(["https://scweb.cwa.gov.tw/zh-tw/earthquake/download?file=%2FdrawTrace%2Foutcome%2F" eqyr "%2F" eqnum ".txt"],[eqnum ".txt"]);

tool_cwa_parameters
intensity
information
