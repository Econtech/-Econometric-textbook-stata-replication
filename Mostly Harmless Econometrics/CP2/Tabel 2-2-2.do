/* Change working directory */
cd d:/Data
/* Load downloaded data */
use webstar.dta, clear

/* Create variables in table */
/* Create Free lunch */
gen Free_lunch = (inlist(sesk,1)) if !missing(sesk)
gen White_Asian = (inlist(srace, 1,3)) if !missing(srace)

/* Show fraction for different classes */
foreach var in Free_lunch White_Asian{
forvalue x = 1/3{
di "Present for `var'"
ta  `var' if cltypek == `x'
oneway `var' cltypek if `x' == 3
}
}

/* Create age,attrition rate, and percentage score */
gen age = 1985 - sbirthy 

gen attrition = 0
replace attrition = 1 if stark == 1 & missing(cltype3)

foreach var in treadssk tmathssk {
	xtile pct_`var' = `var', nq(100)
}

egen avg_pct = rowmean(pct_*)

* Show the fraction
foreach var in age attrition avg_pct{
forvalue x = 1/3 {
di "Present for `var'"
su  `var' if cltypek == `x'
oneway `var' cltypek if `x' == 3
}
}

/* End of file */

