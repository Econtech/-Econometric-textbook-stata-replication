* Example 6.1: Effect of Pollution on Housing Prices
use HPRICE2,clear
reg price nox crime rooms dist stratio, beta

* Example 6.2: Effect of Pollution on Housing Prices
use HPRICE2,clear
gen rooms2=rooms^2
gen ldist=log(dist)
reg lprice lnox ldist rooms rooms2 stratio

display abs(_b[rooms]/(2*_b[rooms2]))
display 100*(_b[rooms]+2*_b[rooms2]*5)
display 100*(_b[rooms]+2*_b[rooms2]*6)
display 100*(_b[rooms]+2*_b[rooms2]*6.45)
display 100*(_b[rooms]+2*_b[rooms2]*7)

reg lprice lnox ldist rooms  stratio

* Example 6.3: Effect of Attendance on Final Exam Performance
use ATTEND,clear
summ priGPA
gen priGPA2=priGPA^2
gen ACT2=ACT^2
gen priatn=priGPA*atndrte
reg stndfnl atndrte priGPA ACT priGPA2 ACT2 priatn
test atndrte priatn
display _b[atndrte]+_b[priatn]*2.59
gen priatn_mean=(priGPA-2.59)*atndrte
reg stndfnl atndrte priGPA ACT priGPA2 ACT2 priatn_mean


* Example 6.4: CEO Compensation and Firm Performance
use CEOSAL1,clear
reg salary sales roe
reg lsalary lsales roe

* Example 6.5: Confidence Interval for Predicted College GPA 
use GPA2,clear
gen hsize2=hsize^2
reg colgpa sat hsperc hsize hsize2

display _b[_cons]+_b[sat]*1200+_b[hsperc]*30+_b[hsize]*5+_b[hsize2]*25

gen sat0=sat-1200
gen hsperc0=hsperc-30
gen hsize0=hsize-5
gen hsize20=hsize2-25
reg colgpa sat0 hsperc0 hsize0 hsize20

* Example 6.6: Confidence Interval for Future College GPA
use GPA2,clear
gen hsize2=hsize^2
reg colgpa sat hsperc hsize hsize2

display _b[_cons]+_b[sat]*1200+_b[hsperc]*30+_b[hsize]*5+_b[hsize2]*25

gen sat0=sat-1200
gen hsperc0=hsperc-30
gen hsize0=hsize-5
gen hsize20=hsize2-25
reg colgpa sat0 hsperc0 hsize0 hsize20
gen se_0 =sqrt( _se[_cons]^2+e(rmse)^2)
gen down_CI = _b[_cons]-1.96*se_0
gen up_CI = _b[_cons]+1.96*se_0
di "the confidence interval is:" "[" down_CI "  " up_CI "]"

* Example 6.7: Predicting CEO Salaries
use CEOSAL2,clear
reg lsalary lsales lmktval ceoten
predict lsal, xb
gen mhat=exp(lsal)
display _b[_cons]+_b[lsales]*log(5000)+_b[lmktval]*log(10000)+_b[ceoten]*10
di exp(7.013)
reg salary mhat, noconstant
display _b[mhat]*exp(7.013)

* Example 6.8: Predicting CEO Salaries
use CEOSAL2,clear
reg lsalary lsales lmktval ceoten
predict lsal, xb
gen mhat=exp(lsal)
corr salary mhat
di r(rho)^2
reg salary sales mktval ceoten 























