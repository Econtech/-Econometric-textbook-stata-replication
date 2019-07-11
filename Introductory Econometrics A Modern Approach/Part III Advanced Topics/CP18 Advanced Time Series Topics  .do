* Example 18.1: Housing Investment and Residential Price Inflation
use HSEINV,clear
tsset year
reg linvpc t
predict elinvpc,r
reg elinvpc gprice L.elinvpc
scalar lrpGDL = _b[gprice]/(1-_b[L.elinvpc])
display _n "long run propensity : " lrpGDL

reg elinvpc gprice L.elinvpc L.gprice
scalar lrpRDL = (_b[gprice]+_b[L.gprice])/(1-_b[L.elinvpc])
display _n "long run propensity : " lrpRDL
test gprice+L.gprice==0 // test whether LRP is different from zero 

* Example 18.2: Unit Root Test for Three-Month T-Bill Rates
use INTQRT,clear
reg cr3 r3_1
display "rho=" 1+_b[r3_1]

* Example 18.3: Unit Root Test for Annual U.S. Inflation
use PHILLIPS,clear
tset year
reg cinf inf_1 L.cinf if year<=1996
display "rho=" 1+_b[inf_1]

reg cinf inf_1 if year<=1996
display "rho=" 1+_b[inf_1]

* Example 18.4: Unit Root in the Log of U.S. Real Gross Domestic Product
use INVEN,clear
tsset year
gen lgdp=log(gdp)
reg D.lgdp year L.lgdp L.D.lgdp
display "rho=" 1+_b[L.lgdp]

reg D.lgdp L.lgdp L.D.lgdp
display "rho=" 1+_b[L.lgdp]

* Example 18.5: Cointegration Between Fertility and Personal Exemption
use FERTIL3,clear
tsset year
reg gfr pe year
predict uh, res

reg D.gfr D.pe
reg D.gfr L.gfr L.D.gfr year
reg D.pe L.pe L.D.pe year

reg D.uh L.uh L.D.uh year
reg D.gfr D.pe L.D.pe L2.D.pe

* Example 18.6: Cointegrated Parameter for Interest Rates
use INTQRT,clear
gen cr3_2 = cr3[_n-2]
gen cr3_1p = cr3[_n+1]
gen cr3_2p = cr3[_n+2]
reg r6 r3 cr3 cr3_1 cr3_2 cr3_1p cr3_2p
di (_b[r3]-1)/(_se[r3])
di (1.038-1)/0.0081 // in textbook, the values are all rounded

reg r6 r3

* Example 18.7: Error Correction Model for Holding Yields
use INTQRT,clear
gen del = hy6_1 - hy3[_n-2]
reg chy6 chy3_1 del

* Example 18.8: Forecasting the U.S. Unemployment Rate
use PHILLIPS,clear
reg unem unem_1 if year<=1996
list unem if year ==1996
display "Forecast for 1997: " _b[_cons] +_b[unem_1]*5.4
reg unem unem_1 inf_1 if year<=1996
list inf if year == 1996
display "Forecast for 1997: " _b[_cons] +_b[unem_1]*5.4 +_b[ inf_1]*3
gen un1 = unem_1-5.4
gen inf1 = inf_1-3
reg unem un1 inf1 if year<=1996
scalar down = _b[ _cons]-1.96*sqrt(_se[_cons]^2+e(rmse)^2)
scalar up= _b[_cons]+1.96*sqrt(_se[_cons]^2+e(rmse)^2)
display "95% forecast interval: [" down ","up "]"


* Example 18.9: Out-of -Sample Comparison of Unemployment Forecasts
use PHILLIPS,clear
reg unem unem_1 if year<=1996
* calculate RMSE
predict eps, r
replace eps = eps^2
summ eps,meanonly
di "RMSE : " %9.3f  r(mean)^(1/2)
di "Value in the textbook is MSE:" %9.3f r(mean) 

* calculate MAE
predict eps2, r
replace eps2 = abs(eps2)
summ eps2,meanonly
display "MAE:" %9.3f r(mean)

reg unem unem_1 inf_1 if year<=1996
* calculate RMSE
predict epss, r
replace epss = epss^2
summ epss,meanonly
di "RMSE : " %9.3f  r(mean)^(1/2)
di "Value in the textbook is MSE:" %9.3f r(mean)

* calculate MAE
predict epss2, r
replace epss2 = abs(epss2)
summ epss2,meanonly
display "MAE:" %9.3f r(mean)

* Example 18.10: Two-Year-Ahead Forecast for the Unemployment Rate
use PHILLIPS,clear
reg inf inf_1 if year<=1996
list inf if year==1996
scalar inf1997 = _b[_cons]+_b[inf_1]*3
display "Forecast for inflation in 1997: " %9.2f inf1997
reg unem unem_1 inf_1 if year<=1996
list unem inf if year == 1996
display "Forecast for unemployment in 1997: " _b[_cons] +_b[unem_1]*5.4 +_b[ inf_1]*3
display "Forecast for unemployment in 1998: " %9.2f  _b[_cons]+_b[unem_1]*5.35+_b[inf_1]*inf1997

* One step ahead forecast, we use data in 1997 to predict value in 1998
list unem if year == 1997
list inf if year == 1997
reg unem unem_1 inf_1 if year<=1997
display "Forecast for unemployment in 1998 by(18.49): " %9.2f  _b[_cons]+_b[unem]*4.5+_b[inf_1]*2.3
reg unem unem_1 if year<=1997
display "Forecast for unemployment in 1998 by(18.48): " %9.2f  _b[_cons]+_b[unem]*4.5

list unem if year == 1998 // as we can see, one step ahead forecast by first model is the best


















