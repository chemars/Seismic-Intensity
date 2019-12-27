# 震度
以民生公共物聯網的地震測站資料計算中央氣象局地震震度並繪製震度圖。

## 使用軟體
* [GNU Octave](https://www.gnu.org/software/octave/) 5.1.0 Windows-64
* [Generic Mapping Tools](https://www.generic-mapping-tools.org/) 6.0.0

## 資料來源
民生公共物聯網-資料服務平台 [感測資料-中央氣象局地震監測站](https://ci.taiwan.gov.tw/dsp/environmental_eq_cwb.aspx)、[感測資料-國家地震工程研究中心地震監測站](https://ci.taiwan.gov.tw/dsp/environmental_eq_ncree.aspx)

## 說明
下載歷史資料，將解壓縮後的`*.dat`或`*.txt`放入`data`資料夾中，執行`intensity.m`及`information.m`，產生`intensity.csv`（測站資訊與震度資料）及`information.csv`（地震資訊）。

繪圖程式可於 Ubuntu 18.04 執行，利用上述兩個檔案繪製震度圖，說明如下
* `plot.sh`：中央氣象局地震震度（2000年版本）、海岸線，圖片名稱為`plot.png`
* `intensity_map_2000.sh`：中央氣象局地震震度（2000年版本）、海岸線、直轄市及縣市界線，圖片名稱為`intensity_map_2000.png`
* `intensity_map.sh`：中央氣象局地震震度、海岸線、直轄市及縣市界線，圖片名稱為`intensity_map.png`

## 授權條款
* [MIT 授權條款](https://github.com/chemars/Seismic-Intensity/blob/master/LICENSE)
* `twmap.gmt`
  * 內政部國土測繪中心 [2019] [直轄市、縣市界線(TWD97經緯度) mapdata201911261001.zip]
  * 此開放資料依政府資料開放授權條款 (Open Government Data License) 進行公眾釋出，使用者於遵守本條款各項規定之前提下，得利用之。
  * 政府資料開放授權條款：https://data.gov.tw/license

  原始資料來自[政府資料開放平臺](https://data.gov.tw/dataset/7442)，使用 [GDAL](https://gdal.org/) 將 SHP 轉換為 GMT 格式，座標系統轉換為 WGS84。

## 其他
* [地震震度計算](https://github.com/chemars/Seismic-Intensity-Scales)
* [測站震度輸出](https://github.com/chemars/Seismic-Intensity-Output)
* [震度分布繪圖](https://github.com/chemars/Seismic-Intensity-Plot)
