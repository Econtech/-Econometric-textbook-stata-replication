* Example 13.1: Woman's Fertility Over Time
use FERTIL1,clear  // load dataset 
reg kids educ age agesq black east northcen west ///
	farm othrural town smcity y74 y76 y78 y80 y82 y84 // pooled regression for table 13.1
test y74 y76 y78 y80 y82 y84 // test the significance of time dummy variables
* Example 13.2: Changes in the Return to Education and the Gender Wage Gap
use CPS78_85,clear 
reg lwage y85 educ y85educ exper expersq union female y85fem
* Example 13.3: Effect of a Garbage Incinerator's Location on Housing Prices
* introduce difference-in-differences estimator
use KIELMC,clear
reg rprice nearinc if year==1981
scalar b1=_b[nearinc]
reg rprice nearinc if year==1978
scalar b2=_b[nearinc]
display b1-b2
reg rprice nearinc y81 y81nrinc

reg rprice nearinc y81 y81nrinc age agesq
reg rprice nearinc y81 y81nrinc age agesq intst land area rooms baths

reg lprice nearinc y81 y81nrinc
reg lprice nearinc y81 y81nrinc age agesq lintst lland larea rooms baths

* Example 13.4: Effect of Worker Compensation laws on Duration
use INJURY,clear 
reg ldurat afchnge highearn afhigh if ky

use CRIME2,clear 
reg crmrte unem if year == 87
reg crmrte d87 unem  
* first-differenced estimator 
reg ccrmrte cunem 


* Example 13.5: Sleeping Versus Working
use SLP75_81,clear 
reg cslpnap ctotwrk ceduc cmarr cyngkid cgdhlth
test ceduc cmarr cyngkid cgdhlth

* Example 13.6: Distributed Lag of Crime Rate on Clear-up Rate
use CRIME3,clear
reg clcrime cclrprc1 cclrprc2


use JTRAIN,clear 
tsset fcode year 

gen Lscrap = l.scrap 
gen Lgrant = l.grant 

reg Lscrap Lgrant

xtserial scrap grant,output
xtserial lscrap grant,output


* Example 13.7: Effect of Drunk Driving Laws on Traffic Fatalities
use TRAFFIC1,clear
reg cdthrte copen cadmn

* Example 13.8: Effect of Enterprise Zones on Unemployment Claims
use EZUNEM,clear
reg guclms d82 d83 d84 d85 d86 d87 d88 cez
bpagan d82 d83 d84 d85 d86 d87 d88 cez

* Example 13.9: Country Crime Rates in North Carolina
use CRIME4,clear
reg clcrmrte d83 d84 d85 d86 d87 clprbarr clprbcon clprbpri clavgsen clpolpc
whitetst, fitted















