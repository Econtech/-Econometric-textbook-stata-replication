* Example 15.1: Estimating the Return to Education for Married Women
use MROZ,clear
reg lwage educ
reg educ fatheduc if inlf == 1 // use only working women in the sample 
ivreg lwage (educ = fatheduc )

* Example 15.2: Estimating the Return to Education for Men
use WAGE2,clear
reg educ sibs 
ivreg lwage (educ = sibs) 

* Example 15.3: Estimating the Effect of Smoking on Birth Weight
use BWGHT,clear
reg packs cigprice
ivreg lbwght (packs = cigprice )
ivreg lbwght (packs = cigprice ), first

* Example 15.4: Using College Proximity as an IV for Education
use CARD,clear
reg educ nearc4 exper expersq black smsa south smsa66 reg662-reg669
ivreg lwage (educ = nearc4 ) exper expersq black smsa south smsa66 reg662-reg669,first
reg lwage educ nearc4 exper expersq black smsa south smsa66 reg662-reg669

* Example 15.5: Return to Education for Working Women
use MROZ,clear
reg educ exper expersq motheduc fatheduc
test motheduc fatheduc
ivreg lwage (educ = motheduc fatheduc) exper expersq

* Example 15.6: Using Two Test Scores as Indicators of Ability
use WAGE2,clear
ivreg lwage educ exper tenure married south urban black (IQ =KWW)

* Example 15.6: Using Two Test Scores as Indicators of Ability
use WAGE2,clear
ivreg lwage educ exper tenure married south urban black (IQ =KWW)

* Example 15.7: Return to Education for Working Women
use MROZ,clear
reg educ exper expersq motheduc fatheduc if inlf==1
predict double uhat1, res
reg lwage educ exper expersq uhat1

reg lwage educ exper expersq
ivreg lwage (educ = motheduc fatheduc) exper expersq

* Example 15.8: Return to Education for Working Women
use MROZ,clear
ivreg lwage (educ = motheduc fatheduc) exper expersq 
predict uh,r
reg uh exper expersq motheduc fatheduc if inlf == 1
di 428*0.0009
di 1- chi2(1,428*0.0009) // calculate P-value

ivreg lwage (educ = motheduc fatheduc huseduc) exper expersq
predict uh2,r
reg uh2 motheduc fatheduc huseduc exper expersq if inlf==1
di 428*0.0026
di 1- chi2(2,428*0.0026) // calculate P-value

gen uh2_squared = uh2^2 // for heteroskedasticity test 
reg uh2_squared motheduc fatheduc huseduc exper expersq


* Example 15.9: Return of Education to Fertility
use FERTIL1,clear
ivreg kids (educ = meduc feduc) age agesq black east northcen west farm othrural ///
	town smcity y74 y76 y78 y80 y82 y84
reg kids educ age agesq black east northcen west farm othrural town smcity y74 y76 ///
	y78 y80 y82 y84
	
reg educ meduc feduc age agesq black east northcen west farm othrural town smcity ///
	y74 y76 y78 y80 y82 y84
predict v, r
reg kids educ age agesq black east northcen west farm othrural town smcity y74 y76 ///
	y78 y80 y82 y84 v

	
* Example 15.10: Job Training and Worker Productivity
use JTRAIN,clear
tsset fcode year
sort fcode year
drop if year==1989
reg D.hrsemp D.grant
ivreg D.lscrap (D.hrsemp = D.grant)

reg D.lscrap D.hrsemp

	
	
	
	
	
	
	
	
	
	


