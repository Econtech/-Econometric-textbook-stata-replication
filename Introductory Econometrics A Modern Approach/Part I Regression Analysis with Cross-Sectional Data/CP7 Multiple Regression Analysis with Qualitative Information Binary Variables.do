* Example 7.1: Hourly Wage Equation
use WAGE1,clear
reg wage female educ exper tenure
reg wage female
lincom female+_cons

* Example 7.2: Effects of Computer Ownership on College GPA
use GPA1,clear
reg colGPA PC hsGPA ACT
reg colGPA PC

* Example 7.3: Effects of Training Grants on Hours of Training in 1988
use JTRAIN,clear
reg hrsemp grant lsales lemploy if year==1988

* Example 7.4: Housing Price Regression
use HPRICE1,clear
reg lprice llotsize lsqrft bdrms colonial

* Example 7.5: Log Hourly Wage Equation
use WAGE1,clear
reg lwage female educ exper expersq tenure tenursq
di exp(_b[female]*1)-1

* Example 7.6: Log Hourly Wage Equation
use WAGE1,clear
gen male = (!female)
gen single = (~married)
gen marrmale = (married & ~female)
gen marrfem = (married & female)
gen singfem = (female & ~married)
gen singmale = (~female & ~married)
reg lwage marrmale marrfem singfem educ exper expersq tenure tenursq
lincom singfem-marrfem
reg lwage marrmale singmale singfem educ exper expersq tenure tenursq

* Example 7.8: Effects of Law School Rankings on Starting Salaries
use LAWSCH85,clear
gen r61_100 = (rank>60 & rank<101)
reg lsalary top10 r11_25 r26_40 r41_60 r61_100 LSAT GPA llibvol lcost
di exp(_b[top10]*1)-1
test LSAT GPA llibvol lcost
reg lsalary rank LSAT GPA llibvol lcost
test LSAT GPA llibvol lcost

* Example 7.10: Log Hourly Wage Equation
use WAGE1,clear
gen femed = female*educ
reg lwage female educ femed exper expersq tenure tenursq
gen se_0 = _se[female]
reg lwage female educ exper expersq tenure tenursq
di se_0/_se[female]

replace femed = female*(educ-12.5)
reg lwage female educ femed exper expersq tenure tenursq
test female femed

* Example 7.11: Effects of Race on Baseball Player Salaries
use MLB1,clear
reg lsalary years gamesyr bavg hrunsyr rbisyr runsyr fldperc allstar black hispan blckpb hispph if hisppb<.
test black hispan blckpb hispph
lincom _b[black]+_b[blckpb]*10
lincom _b[black]+_b[blckpb]*20
di _b[hispan]*-1/_b[hispph]
su blckpb hispph
reg lsalary years gamesyr bavg hrunsyr rbisyr runsyr fldperc allstar if hisppb<.

* Example 7.12: A Linear Probability Model of Arrests
use CRIME1,clear
gen arr86=(~~narr86)
reg arr86 pcnv avgsen tottime ptime86 qemp86
test avgsen tottime 

lincom _b[pcnv]*.5
lincom _b[ptime86]*6
lincom _b[_cons]+_b[ptime86]*12
lincom 0.277+_b[ptime86]*12
lincom _b[qemp86]*4

reg arr86 pcnv avgsen tottime ptime86 qemp86 black hispan












