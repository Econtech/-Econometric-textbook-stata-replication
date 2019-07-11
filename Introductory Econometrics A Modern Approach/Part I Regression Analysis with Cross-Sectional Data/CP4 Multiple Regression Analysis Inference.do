* Example 4.1: Hourly Wage Equation
use WAGE1,clear
reg lwage educ exper tenure
display _b[exper]*3

* Example 4.2: Student Performance and School Size
use MEAP93,clear
reg math10 totcomp staff enroll
reg math10 ltotcomp lstaff lenroll
display _b[lenrol]/100

* Example 4.3: Determinants of College GPA
use GPA1
reg colGPA hsGPA ACT skipped

* Example 4.4: Campus Crime and Enrollment
use campus,clear
su crime enroll
reg lcrime lenroll
scalar tvalue=(_b[lenrol]-1)/_se[lenrol]
scalar pvalue=ttail(120,tvalue)
display "T-value: " tvalue ", P-value: " pvalue

* Example 4.5: Housing Prices and Air Pollution
use HPRICE2,clear
gen ldist=log(dist)
reg lprice lnox ldist rooms stratio
scalar tvalue=(_b[lnox]+1)/_se[lnox]
scalar pvalue=2*(ttail(501,tvalue))
display "T-value: " tvalue ", P-value: " pvalue

test lnox =-1


* Example 4.6: Participation Rates in 401K Plans
use 401K,clear
reg prate mrate age totemp
display _b[totemp]*10000

* Example 4.7: Effect of Job Training Grants on Firm Scrap Rates
use JTRAIN if year ==1987&union==0,clear
reg lscrap hrsemp lsales lemploy

display _b[hrsemp]*1
display _b[hrsemp]*5

* one side t test on H0:Beta>=0
scalar tvalue=(_b[hrsemp])/_se[hrsemp]
scalar pvalue=1-(ttail(25,tvalue))
display "T-value: " tvalue ", P-value: " pvalue

* Example 4.8: Model of R&D Expenditures
use RDCHEM,clear
reg lrd lsales profmarg
di invttail(29,0.025)
gen down_CI = _b[lsales]-_se[lsales]*invttail(29,0.025)
gen up_CI = _b[lsales]+_se[lsales]*invttail(29,0.025)
di "The confidence interval is:" "["down_CI " " up_CI "]"

replace down_CI = _b[profmarg]-_se[profmarg]*invttail(29,0.025)
replace up_CI = _b[profmarg]+_se[profmarg]*invttail(29,0.025)
di "The confidence interval is:" "["down_CI " " up_CI "]"

scalar tvalue=(_b[profmarg])/_se[profmarg]
scalar pvalue=(ttail(29,tvalue))
display "T-value: " tvalue ", P-value: " pvalue

di _b[profmarg]*100

* Example 4.9: Parents Education in a Birth Weight Equation
use BWGHT,clear
reg bwght cigs parity faminc motheduc fatheduc
test motheduc fatheduc

* Example 4.10: Salary-Pension Tradeoff for Teachers
use MEAP93,clear
su bensal 
reg lsalary bensal
scalar tvalue=(_b[bensal]+1)/_se[bensal]
scalar pvalue=2*(ttail(406,tvalue))
display "T-value: " tvalue ", P-value: " pvalue
test bensal=-1

reg lsalary bensal lenrol lstaff
scalar tvalue=(_b[bensal]+1)/_se[bensal]
scalar pvalue=2*(ttail(404,tvalue))
display "T-value: " tvalue ", P-value: " pvalue
test bensal=-1

reg lsalary bensal lenrol lstaff droprate gradrate
scalar tvalue=(_b[bensal]+1)/_se[bensal]
scalar pvalue=2*(ttail(402,tvalue))
display "T-value: " tvalue ", P-value: " pvalue
test bensal=-1









