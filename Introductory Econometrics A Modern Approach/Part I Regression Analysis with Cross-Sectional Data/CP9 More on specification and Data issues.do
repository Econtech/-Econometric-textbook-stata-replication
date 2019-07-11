* Example 9.1: Economic Model of Crime
use CRIME1,clear
reg narr86 pcnv avgsen tottime ptime86 qemp86 inc86 black hispan
reg narr86 pcnv pcnvsq avgsen tottime ptime86 pt86sq qemp86 inc86 inc86sq black hispan

* Example 9.2: Housing Price Equation
use HPRICE1,clear
reg price lotsize sqrft bdrms
predict uh
gen uh2 = uh^2
gen uh3 = uh^3
reg price lotsize sqrft bdrms uh2 uh3
test uh2 uh3 

reg lprice llotsize lsqrft bdrms
predict luh
gen luh2 = luh^2
gen luh3 = luh^3
reg lprice llotsize lsqrft bdrms luh2 luh3
test luh2 luh3

* Example 9.3: IQ as a Price for Ability
use WAGE2,clear
gen educIQ=educ*IQ
reg lwage educ exper tenure married south urban black
reg lwage educ exper tenure married south urban black IQ
reg lwage educ exper tenure married south urban black IQ educIQ

* Example 9.4: City Crime Rates
use CRIME2,clear
reg lcrmrte unem llawexpc if d87==1
reg lcrmrte unem llawexpc lcrmrt_1

scalar tvalue=(_b[lcrmrt_1]-1)/_se[lcrmrt_1]
scalar pvalue=ttail(e(df_r),tvalue)
display "T-value: " tvalue ", P-value: " pvalue

* Example 9.8: R&D Intensity and Firm Size
use RDCHEM,clear
reg rdintens sales profmarg
reg rdintens sales profmarg if sales<20000
scalar tvalue=(_b[sales])/_se[sales]
scalar pvalue=ttail(e(df_r),tvalue)
display "T-value: " tvalue ", P-value: " pvalue

* Example 9.9: R&D Intensity
use RDCHEM,clear
reg lrd lsales profmarg
scalar tvalue=(_b[lsales]-1)/_se[lsales]
scalar pvalue=ttail(e(df_r),tvalue)
display "T-value: " tvalue ", P-value: " pvalue

use RDCHEM,clear
reg lrd lsales profmarg if sales<20000
scalar tvalue=(_b[lsales]-1)/_se[lsales]
scalar pvalue= ttail(e(df_r),tvalue)
display "T-value: " tvalue ", P-value: " pvalue

* Example 9.10: State Infant Mortality Rates
use INFMRT,clear
reg infmort lpcinc lphysic lpopul if year==1990
reg infmort lpcinc lphysic lpopul if infmort<20 & year==1990



