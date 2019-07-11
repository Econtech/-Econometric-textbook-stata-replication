* Example 16.5: Labor Supply of Married, Working Women
use MROZ, clear
ivreg hours (lwage = exper expersq ) educ age kidslt6 nwifeinc
reg hours lwage educ age kidslt6 nwifeinc

reg lwage educ age kidslt6 nwifeinc exper expersq
predict v2,r 
reg hours lwage educ age kidslt6 nwifeinc v2 // lwage seems to be endogenous

ivreg lwage (hours = age kidslt6 nwifeinc) educ exper expersq
reg lwage educ exper expersq

* Example 16.6: Inflation and Openness
use OPENNESS, clear
reg open lpcinc lland
ivreg inf (open = lland) lpcinc
reg inf open lpcinc

* Example 16.7: Testing the Permanent Income Hypothesis
use CONSUMP, clear
tsset year
ivreg gc (gy r3 = L.gc L.gy L.r3)
predict uh,r
ivreg gc (gy r3 = L.gc L.gy L.r3) L.uh 

* Example 16.8: Effect of Prison Population on Violent Crime Rates
use PRISON, clear
tsset state year
reg gcriv y81-y89 y90-y93 cag0_14 cag15_17 cag18_24 cag25_34 cunem cblack cmetro gincpc gpolpc gpris
ivreg gcriv y81-y89 y90-y93 cag0_14 cag15_17 cag18_24 cag25_34 cunem cblack cmetro gincpc gpolpc (gpris = final1 final2)












