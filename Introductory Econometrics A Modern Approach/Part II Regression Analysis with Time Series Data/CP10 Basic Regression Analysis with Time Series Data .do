* Example 10.1: Static Phillips Curve
use PHILLIPS,clear
reg inf unem if year<=1996

* Example 10.2: Effects of Inflation and Deficits on Interst Rates
use INTDEF,clear
reg i3 inf def

* Example 10.3: Puerto Rican Employment and the Minimum Wage
use PRMINWGE,clear
reg lprepop lmincov lusgnp

* Example 10.4: Effects of Personal Exemption on Fertility Rates
use FERTIL3,clear
reg gfr pe ww2 pill
reg gfr pe ww2 pill pe_1 pe_2
test pe pe_1 pe_2
test pe_1 pe_2

display _b[pe]+_b[pe_1]+_b[pe_2]
gen dif1=pe_1-pe
gen dif2=pe_2-pe
reg gfr pe dif1 dif2 ww2 pill

* Example 10.5: Antidumping Filings and Chemical Import
use BARIUM,clear
reg lchnimp lchempi lgas lrtwex befile6 affile6 afdec6
display 100*(exp(_b[afdec6])-1)

* Example 10.6: Election Outcomes and Economic Performance
use FAIR,clear
reg demvote partyWH incum pWHgnews pWHinf if year<1996
display _b[_cons]+_b[partyWH]+_b[incum]+_b[pWHgnews]*3+_b[pWHinf]*3.019

* Example 10.7: Housing Investment and Prices
use HSEINV,clear
reg linvpc lprice
reg linvpc t 
reg linvpc lprice t

* Example 10.8: Fertility Equation
use FERTIL3,clear
reg gfr pe ww2 pill
reg gfr pe ww2 pill t
reg gfr pe ww2 pill t tsq

* Example 10.9: Puerto Rican Employment
use PRMINWGE,clear
reg lprepop lmincov lusgnp
reg lprepop lmincov lusgnp t

* Example 10.10: Housing Investment
use HSEINV,clear
reg linvpc t
predict linvpch, res
reg linvpch lprice t

* Example 10.11: Effects of Antidumping Filings
use BARIUM,clear
reg lchnimp lchempi lgas lrtwex befile6 affile6 afdec6 feb mar apr may jun jul aug sep oct nov dec
test feb mar apr may jun jul aug sep oct nov dec




















