* Example 11.4: Efficient Market Hypothesis
use NYSE,clear
tset t
reg return return_1
gen return_2 = L2.return
reg return return_1 return_2

* Example 11.5: Expectation Augmented Phillips Curve
use PHILLIPS,clear
reg cinf unem if year<=1996
display _b[_cons]/-_b[unem]

* Example 11.6: Fertility Equation
use FERTIL3,clear
reg gfr gfr_1
reg pe pe_1
reg cgfr cpe
reg cgfr cpe cpe_1 cpe_2

* Example 11.7: Wages and Productivity
use EARNS,clear
reg lhrwage loutphr t
reg ghrwage goutphr

* Example 11.8: Fertility Equation
use FERTIL3,clear
reg cgfr cpe cpe_1 cpe_2 cgfr_1











