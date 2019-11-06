version 9
set more 1
capture log close
log using krueger, text replace

/* create Krueger scaled scores */

/* reading score */
clear
use webstar

keep if cltypek > 1			/* regular classes */
keep if treadssk ~= .

sort treadssk
gen pread0 = 100*_n/_N

egen pread = mean(pread0), by(treadssk)	/* percentile score in reg. classes */

keep treadssk pread
sort tread
keep if tread ~= tread[_n-1]
save tempr, replace

/* math score */

use webstar

keep if cltypek > 1			/* regular classes */
keep if tmathssk ~= .

sort tmathssk
gen pmath0 = 100*_n/_N
egen pmath = mean(pmath0), by(tmathssk)

keep tmathssk pmath
sort tmath
keep if tmath ~= tmath[_n-1]
save tempm, replace

/* merge percentile scores back on */

use webstar

keep if stark == 1

sort treadssk
merge treadssk using tempr
ipolate pread treadssk, gen(pr) epolate
drop _merge

sort tmathssk
merge tmathssk using tempm
ipolate pmath tmathssk, gen(pm) epolate
replace pm = 0 if pm < 0
drop _merge

egen pscore = rowmean(pr pm)

/* make class ids */

egen classid1 = group(schidkn cltypek)
egen cs1 = count(classid1), by(classid1)

egen classid2 = group(classid1 totexpk hdegk cladk) if cltypek==1 & cs >= 20
egen classid3 = group(classid1 totexpk hdegk cladk) if cltypek>1 & cs >= 30

gen temp = classid1*100
egen classid = rowtotal(temp classid2 classid3)
egen cs = count(classid), by(classid)

gen female = ssex == 2
gen nwhite = srace >= 2 & srace <= 6 if srace ~= .

keep if cs <= 27 & pscore ~= .
keep pscore cs schidkn classid female nwhite
gen n = 1

save temp, replace

* Robust(HC1)
reg pscore cs, robust
local se = _se[cs]
local t = _b[cs]/`se'
predict r, res
loneway r classid
local rho = r(rho)

collapse cs, by(classid)
sum cs

dis r(Var)
local m = 1 + (r(Var)/r(mean) + r(mean) - 1)*`rho'
dis `m'
dis sqrt(`m')
dis `se'
dis sqrt(`m')*`se'
dis `t'/sqrt(`m')


use temp, clear

* Robust(HC1)
reg pscore cs, robust
* Parametric Moulton Correction using Moulton intraclass coef
moulton pscore cs, cluster(classid) moulton
* Parametric Moulton Correction using ANOVA coef
moulton pscore cs, cluster(classid)
* Clustered
reg pscore cs, cluster(classid)
* brl pscore cs, cluster(classid)

* Block Bootstrap
set seed 123456789
bootstrap "reg pscore cs" _b, reps(1000) cluster(classid)

* Estimation using group means
areg pscore, absorb(classid)
predict hat
gen ry = pscore - hat + _b[_cons]
collapse (mean) ry cs (sum) n, by(classid)

reg ry cs [aw=n]


log close
set more 0
