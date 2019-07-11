* Example 14.1: Effect of Job Training on Firm Scrap Rates
use JTRAIN,clear
tsset fcode year 
xtreg lscrap d88 d89 grant grant_1, fe
display exp(_b[grant_1])-1
xtreg lscrap d88 d89 grant, fe

* Example 14.2: Has the Return to Education Changed Over Time
use WAGEPAN,clear 
tsset nr year 
gen edd81 = educ*d81
gen edd82 = educ*d82
gen edd83 = educ*d83
gen edd84 = educ*d84
gen edd85 = educ*d85
gen edd86 = educ*d86
gen edd87 = educ*d87
xtreg lwage expersq union married d81-d87 edd81-edd87, fe // if you add experience, it's not right
test edd81 edd82 edd83 edd84 edd85 edd86 edd87
xtreg lwage union married d81-d87 edd81-edd87, fe
test edd81 edd82 edd83 edd84 edd85 edd86 edd87

xtreg lwage union married d*##educ,fe // weird result 


* Example 14.3: Effect of Job Training on Firm Scrap Rates
use JTRAIN,clear
iis fcode
tis year
xtreg lscrap d88 d89 grant grant_1 lsales lemploy, fe

* Example 14.4: Has the Return to Education Changed Over Time
use WAGEPAN,clear
iis nr
tis year
reg lwage educ black hisp exper expersq married union d81-d87
xtreg lwage educ black hisp exper expersq married union d81-d87, re
xtreg lwage expersq married union d81-d87, fe

* CRE approach 
AIRFARE

























