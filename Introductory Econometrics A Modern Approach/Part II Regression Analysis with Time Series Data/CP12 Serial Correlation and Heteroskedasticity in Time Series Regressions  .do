* Example 12.1: Testing for AR(1) Serial Correlation in the Phillips Curve
use PHILLIPS,clear
tsset year
// For the static Phillips curve
reg inf unem if year<=1996
predict double uh, resid
reg uh L.uh if year<=1996 
reg inf unem if year<=1996,r // use heteroskedasticity-robust residual 
reg inf unem if year<=1996 // The Durbin-Watson Test
dwstat

// For the expectations augmented curve
reg cinf unem if year<=1996
predict double uh2, resid
reg uh2 L.uh2 if year<=1996
reg cinf unem if year<=1996 // The Durbin-Watson Test
dwstat

* Example 12.2: Testing for AR(1) Serial Correlation in the Minimum Wage Equation
use PRMINWGE,clear
tsset year
reg lprepop lmincov lprgnp lusgnp t
predict uh,r
reg uh lmincov lprgnp lusgnp t L.uh
reg uh L.uh

* Example 12.3: Testing for AR(3) Serial Correlation
use BARIUM,clear
tsset t
reg lchnimp lchempi lgas lrtwex befile6 affile6 afdec6
predict uh, res
reg uh lchempi lgas lrtwex befile6 affile6 afdec6 L(1/3).uh
test L1.uh L2.uh L3.uh

reg uh L12.uh // seasonally serial correlation
reg uh lchempi lgas lrtwex befile6 affile6 afdec6 L12.uh

* Example 12.4: Cohrane-Orcutt Estimation in the Event Study
use BARIUM,clear
reg lchnimp lchempi lgas lrtwex befile6 affile6 afdec6
tsset t
prais lchnimp lchempi lgas lrtwex befile6 affile6 afdec6

* Example 12.5: Static Phillips Curve
use PHILLIPS,clear
reg inf unem if year<=1996
tsset year
prais inf unem if year<=1996


* Example 12.6: Differencing the Interest Rate Equation
use INTDEF,clear
tsset year
reg i3 inf def
predict uh,r
reg uh L.uh

reg ci3 cinf cdef
corr(i3 L.i3)
predict uh2, r
reg uh2 L.uh2

* Example 12.7: The Puerto Rican Minimum Wage
use PRMINWGE,clear
tsset t
reg lprepop lmincov lprgnp lusgnp t
newey lprepop lmincov lprgnp lusgnp t, lag(2)
prais lprepop lmincov lprgnp lusgnp t

* Example 12.8: Heteroscedasticity and the Efficient Markets Hypothesis
use NYSE,clear
reg return return_1
predict uh, res
gen uh2=uh^2
reg uh2 return_1

* Example 12.9: ARCH in Stock Returns
use NYSE,clear
tsset t
reg return return_1
predict uh1, res
gen uh21=uh1^2
gen uh21_1=uh1[_n-1]^2
reg uh21 uh21_1
reg uh1 L.uh1


























