* LOAD DATASET
use cwhsc_new,clear

keep if year>=81
g tctr=1 if type=="TAXAB"
	replace tctr=2 if type=="ADJ"
	replace tctr=3 if type=="TOTAL"
	
* YEAR DUMMIES
qui tab year, ge(yrdum)
qui tab byr, ge(byrdum)

g ps_r50= ps_r*(byr==50)
g ps_r51= ps_r*(byr==51)
g ps_r52= ps_r*(byr==52)
g ps_r53= ps_r*(byr==53)

* ONLY KEEP WHITES
keep if race==1
* ONLY W2 EARNINGS
keep if type=="TOTAL"

* GET RESIDUALS
* 1) EARNINGS
xi: reg earnings i.year i.byr 
	predict ernres, r
	* AVERAGE OVER 4 YEARS
	egen ernres2= mean(ernres), by(byr interval)
	
* 2) PROBABILITIES
xi: reg ps_r i.byr
	predict pres, r
	
keep if year==81

sort pres
twoway scatter ernres2 pres, msymbol(o) msize(medium) || lfit ernres2 pres, xtitle("Probability Residual") ytitle("Earnings Residual") legend(off) ///
		note("Figure 3. Earnings and the Probability of Veteran Status by Lottery Number", pos(7) size(Medium)) ///
		title("Notes: The figure plots mean W-2 compensation in 1981-4 against probabilities of veteran status by" /// 
			"cohort and groups of five consecutive lottery numbers for white men born 1950-3. Plotted points consist" ///
			"of the average residuals (over four years of earnings) from regressions on period and cohort effects." ///
			" The slope of the least-squares regression line drawn through the points is -2,384, with a standard error " ///
			"of 778, and is an estimate of a in the equation yctj=Bc+Dt+Pcja+uctj.", pos(7) size(small)) ///
			ylabel(-3000(1000)3000) xlabel(-.08(.02).16) 
			
* log close

			