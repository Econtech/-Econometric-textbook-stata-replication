* Example 5.2: Standard Errors in a Birth Weight Equation
use BWGHT,clear
reg lbwght cigs lfaminc in 1/694
gen se_cigs = _se[cigs]
reg lbwght cigs lfaminc
gen se_cigs_all = _se[cigs]
di se_cigs_all/se_cigs
di sqrt(694/1388)

* Example 5.3: Economic Model of Crime
use CRIME1,clear
reg narr86 pcnv ptime86 qemp86
predict uh, r
reg uh pcnv ptime86 qemp86 avgsen tottime
gen LM = 2725*0.0015
di "LM statistic is:" LM
di invchi2(2,0.9)
di "P-value is:" 1- chi2(2,LM)

test avgsen tottime // F-test









