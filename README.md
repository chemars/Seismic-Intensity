# 震度
以民生公共物聯網的地震測站資料計算中央氣象局地震震度並繪製震度圖。

## 使用軟體
* [GNU Octave](https://www.gnu.org/software/octave/) 5.1.0 Windows-64
* [Generic Mapping Tools](https://www.generic-mapping-tools.org/) 6.0.0

## 資料來源
民生公共物聯網-資料服務平台 [感測資料-中央氣象局地震監測站](https://ci.taiwan.gov.tw/dsp/dataset_eq_cwb.aspx)、[感測資料-國家地震工程研究中心地震監測站](https://ci.taiwan.gov.tw/dsp/dataset_eq_ncree.aspx)

## 說明
### 計算
選擇一個地震，下載歷史資料並解壓縮，將裡面的`*.dat`或`*.txt`放入`data`資料夾中，執行`intensity.m`及`information.m`，產生`intensity.csv`（測站資訊與震度資料）及`information.csv`（地震資訊），檔案格式如下
* `intensity.csv`：測站代碼,測站名稱,測站經度,測站緯度,中央氣象局地震震度（舊制）,最大地動加速度（舊制）,中央氣象局地震震度,最大地動加速度,最大地動速度,最大合成地動加速度（未濾波）
* `information.csv`：地震時間,震央經度,震央緯度,地震深度,地震規模

### 繪圖
繪圖程式可於 Ubuntu 18.04 執行，讀取`csv`檔案繪製震度圖，圖片說明如下
* `intensity_plot.sh`：顯示中央氣象局地震震度（舊制）分布、海岸線
* `intensity_map_2000.sh`：顯示中央氣象局地震震度（舊制）分布、海岸線、直轄市及縣市界線
* `intensity_map.sh`：顯示中央氣象局地震震度分布、海岸線、直轄市及縣市界線

圖片皆有顯示對應的地震資訊，震度所用的顏色為[中央氣象局地震報告](https://scweb.cwb.gov.tw/zh-tw/earthquake/data)使用的顏色。

## 授權條款
* [MIT 授權條款](https://github.com/chemars/Seismic-Intensity/blob/master/LICENSE)
* `twmap.gmt`
  * 內政部國土測繪中心 [2020] [直轄市、縣市界線(TWD97經緯度)1090820]
  * 此開放資料依政府資料開放授權條款 (Open Government Data License) 進行公眾釋出，使用者於遵守本條款各項規定之前提下，得利用之。
  * 政府資料開放授權條款：https://data.gov.tw/license

  原始資料來自[國土測繪圖資e商城](https://whgis.nlsc.gov.tw/Opendata/Files.aspx)，使用 [GDAL](https://gdal.org/) 將 SHP 轉換為 GMT 格式，座標系統轉換為 WGS84。

## 其他
計算結果與相關圖片僅供參考，地震震度應以中央氣象局為準。
* 更多說明：[Wiki](https://github.com/chemars/Seismic-Intensity/wiki)
* 參考資料：[交通部中央氣象局有感地震報告發布作業要點](https://www.cwb.gov.tw/Data/service/notice/download/notice_20191210113759.pdf)
