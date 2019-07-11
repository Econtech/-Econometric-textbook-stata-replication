* Example 8.1: Log Wage Equation with Heteroscedasticity-Robust Standard Errors
use WAGE1,clear
gen single=(~married)
gen male=(~female)
gen marrmale=male*married
gen marrfem=female*married
gen singfem=single*female
reg lwage marrmale marrfem singfem educ exper expersq tenure tenursq, robust
reg lwage marrmale marrfem singfem educ exper expersq tenure tenursq


* Example 8.2: Heteroscedastisity-Robust F Statistics
use GPA3,clear
reg cumgpa sat hsperc tothrs female black white if term==2, robust
test black white
reg cumgpa sat hsperc tothrs female black white if term==2
test black white


* Example 8.3: Heteroskedasticity-Robust LM Statistic
use CRIME1,clear
gen avgsensq=avgsen^2
reg narr86 pcnv avgsen avgsensq ptime86 qemp86 inc86 black hispan, robust
reg narr86 pcnv avgsen avgsensq ptime86 qemp86 inc86 black hispan

di abs(_b[avgsen]/(2*_b[avgsensq]))

reg narr86 pcnv ptime86 qemp86 inc86 black hispan
predict ubar2, resid
reg ubar2 pcnv avgsen avgsensq ptime86 qemp86 inc86 black hispan
scalar lm1 = e(N)*e(r2)
scalar pvalue = chi2tail(2,lm1)
display _n "LM statistic:" %6.3f lm1 "P-value:" %6.3f pvalue

reg narr86 pcnv ptime86 qemp86 inc86 black hispan
predict ubar1, resid
qui reg avgsen pcnv ptime86 qemp86 inc86 black hispan
predict r1, r
qui reg avgsensq pcnv ptime86 qemp86 inc86 black hispan
predict r2, r
qui gen ur1 = ubar1*r1
qui gen ur2 = ubar1*r2
gen iota = 1
reg iota ur1 ur2, noconstant
scalar hetlm = e(N)-e(rss)
scalar pval = chi2tail(2,hetlm)
display _n "Robust LM statistic : " %6.3f hetlm _n "Under H0, distrib Chi2(2), p-value: " %5.3f pval

* Example 8.4: Heteroscedasticity in Housing Price Equation
use HPRICE1,clear
reg price lotsize sqrft bdrms
predict uh, r
gen u2 = uh^2
reg u2 lotsize sqrft bdrms
scalar lm1 = e(N)*e(r2)
scalar pvalue = chi2tail(3,lm1)
display _n "LM statistic:" %6.3f lm1 "  P-value:" %6.3f pvalue

use HPRICE1,clear
reg lprice llotsize lsqrft bdrms
predict uh, r
gen u2 = uh^2
reg u2 llotsize lsqrft bdrms
scalar lm1 = e(N)*e(r2)
scalar pvalue = chi2tail(3,lm1)
display _n "LM statistic:" %6.3f lm1 "  P-value:" %6.3f pvalue

* Example 8.5: Special Form of the White Test in the Log Housing Price Equation
use HPRICE1,clear
reg lprice llotsize lsqrft bdrms
predict uh, r
predict y
gen y2 = y^2
gen u2 = uh^2
reg u2 y y2
scalar lm1 = e(N)*e(r2)
scalar pvalue = chi2tail(2,lm1)
display _n "LM statistic:" %6.3f lm1 "  P-value:" %6.3f pvalue

* Example 8.6: Financial Wealth Equation
use 401KSUBS if fsize==1,clear
gen age25 = (age - 25)^2
reg nettfa inc,r
reg nettfa inc [aw = 1/inc]
reg nettfa inc age25 male e401k,r
reg nettfa inc age25 male e401k [aw = 1/inc]

* Example 8.7: Demand for Cigarettes
use SMOKE,clear
reg cigs lincome lcigpric educ age agesq restaurn

display _b[lincome]*10/100
display _b[age]/2/_b[agesq]
predict uh,r
gen u2 = uh^2
reg u2 lincome lcigpric educ age agesq restaurn
scalar lm1 = e(N)*e(r2)
scalar pvalue = chi2tail(6,lm1)
display _n "LM statistic:" %6.5f lm1 "  P-value:" %6.5f pvalue

gen lu2=log(u2)
qui reg lu2 lincome lcigpric educ age agesq restaurn
predict cigsh, xb
gen cigse = exp(cigsh)
reg cigs lincome lcigpric educ age agesq restaurn [aw=1/cigse]

* Example 8.8: Labor Force Participation of Married Women
use MROZ,clear
reg inlf nwifeinc educ exper expersq age kidslt6 kidsge6
reg inlf nwifeinc educ exper expersq age kidslt6 kidsge6, robust

* Example 8.9: Determinants of Personal Computer Ownership
use GPA1,clear
gen parcoll = (mothcoll | fathcoll)
reg PC hsGPA ACT parcoll
reg PC hsGPA ACT parcoll,r

predict phat
gen h=phat*(1-phat)
reg PC hsGPA ACT parcoll [aw=1/h]



