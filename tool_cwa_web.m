clear all; close all; fclose all; clc;
url = "https://www.cwb.gov.tw/V8/C/E/MOD/EQ_ROW.html";
urlcwb = "https://www.cwb.gov.tw";

str = urlread(url);
urlstr = regexp(str,'href="([\w-/]*\.html)"','tokens');
str2 = urlread([urlcwb char(urlstr{1})]);
txtstr = regexp(str2,'title="\W+\s(\w*\.txt)"','tokens');
urlstr2 = regexp(str2,'href="([\w-/]*\.txt[\w\?=]*)"','tokens');
urlwrite([urlcwb char(urlstr2{1})],char(txtstr{1}));