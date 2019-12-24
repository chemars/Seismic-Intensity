# 震度
以民生公共物聯網的地震儀資料計算中央氣象局地震震度並繪圖。

## 使用軟體
1. [GNU Octave](https://www.gnu.org/software/octave/) 5.1.0（Windows-64）
2. [Generic Mapping Tools](https://www.generic-mapping-tools.org/) 6.0.0（Ubuntu 18.04）

## 資料來源
民生公共物聯網-資料服務平台，[感測資料-中央氣象局地震監測站](https://ci.taiwan.gov.tw/dsp/environmental_eq_cwb.aspx)、[感測資料-國家地震工程研究中心地震監測站](https://ci.taiwan.gov.tw/dsp/environmental_eq_ncree.aspx)。

## 說明
下載歷史資料，將解壓縮後的`*.dat`或`*.txt`放入`data`資料夾中，執行`intensity.m`及`information.m`

## 授權條款
程式：[MIT 授權條款](https://github.com/chemars/Seismic-Intensity/blob/master/LICENSE)

`twmap.gmt`：原始資料來自[政府資料開放平臺](https://data.gov.tw/dataset/7442)，使用[GDAL](https://gdal.org/)將SHP轉換為GMT格式，座標系統轉換為WGS84。
> 內政部國土測繪中心 [2019] [直轄市、縣市界線(TWD97經緯度)]  
> 此開放資料依政府資料開放授權條款 (Open Government Data License) 進行公眾釋出，使用者於遵守本條款各項規定之前提下，得利用之。  
> 政府資料開放授權條款：https://data.gov.tw/license
