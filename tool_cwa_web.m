clear all; close all; fclose all; clc;
url = "https://www.cwa.gov.tw/V8/C/E/MOD/EQ_ROW.html";
urlcwa = "https://www.cwa.gov.tw";

str = urlread(url);
urlstr = regexp(str,'href="([\w/-]*\.html)"','tokens');

str2 = urlread([urlcwa char(urlstr{1})]);
urltxt = regexp(str2, 'href="([^"]+\.txt(?:\?[^"]*)?)"', 'tokens');
urlname = regexp(str2, 'href="[^"]*/([^/"]+\.txt)(?:\?[^"]*)?"', 'tokens');

urlwrite([urlcwa char(urltxt{1})],char(urlname{1}));
