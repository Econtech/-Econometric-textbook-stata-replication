* Example 17.1: Married Woman's Labor Force Participation
use MROZ, clear
regress inlf nwifeinc educ exper expersq age kidslt6 kidsge6,r

logit inlf nwifeinc educ exper expersq age kidslt6 kidsge6
margins,dydx(*)

probit inlf nwifeinc educ exper expersq age kidslt6 kidsge6
margins,dydx(*)

* Example 17.2: Married Women's Annual Labor Supply
use MROZ, clear
regress hours nwifeinc educ exper expersq age kidslt6 kidsge6,r
tobit hours nwifeinc educ exper expersq age kidslt6 kidsge6, ll(0)

* Example 17.3: Poisson Regression for Number of Arrests
use CRIME1, clear
reg narr86 pcnv avgsen tottime ptime86 qemp86 inc86 black hispan born60
poisson narr86 pcnv avgsen tottime ptime86 qemp86 inc86 black hispan born60

* Example 17.4: Duration of Recidivism
use RECID, clear
cnreg ldurat workprg priors tserved felon alcohol drugs black married educ age,censored(cens)
reg ldurat workprg priors tserved felon alcohol drugs black married educ age

* Example 17.5: Wage Offer Equation for Married Women
use MROZ, clear
reg lwage educ exper expersq
heckman lwage educ exper expersq, sel(inlf = nwifeinc educ exper expersq age kidslt6 kidsge6) twostep












