* Load dataset
use graderep,clear
* Generate Y and X
gen rp2 = repeat2/stud2
gen endyear = year + 1
* Generate SSY States and Bavaria control group indicator
drop if bula=="ns"
gen treat = 1                                           /* short school year states */
replace treat = 2 if bula=="bay"                        /* Bavaria with no transition */
replace treat = 3 if bula=="ber" | bula=="hh"           /* Berlin/Hamburg with no short school years */
* Aggregate Y over X
collapse rp2, by(endyear treat)
* Generate the plot
twoway (line rp2 endyear if treat == 1)  ///
(line rp2 endyear if treat == 2, lpattern("-")), /// 
xlabel(1962(1)1973) xtitle("School year ending") ytitle("Fraction repeating") ///
legend(label(1 "SSY States")label(2 "Bavaria(control)"))
