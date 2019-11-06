capture log close
log using mc_book, replace

/* Monte Carlo for Small Sample bias of 2SLS
   Figures 4.6.1 to 4.6.3 in MHE */

set more 1
version 10
capture program drop mcb

program define mcb
     tempname sim1 sim2 sim3 sim4 sim5 sim6 sim7 sim8 simf2 simf3 simf5 simf7
     postfile `sim1' b_ols using res1, replace
     postfile `sim2' b_iv using res2, replace
     postfile `sim3' b_2sls using res3, replace
     postfile `sim4' b_liml using res4, replace
     postfile `sim5' b_2sls20 using res5, replace
     postfile `sim6' b_liml20 using res6, replace
     postfile `sim7' b_2slsgr using res7, replace
     postfile `sim8' b_limlgr using res8, replace
     postfile `simf2' f_iv using res9, replace
     postfile `simf3' f_2sls using res10, replace
     postfile `simf5' f_2sls20 using res11, replace
     postfile `simf7' f_2slsgr using res12, replace


     quietly {
         local i = 1
         while `i' <= 100 {                   /* no. of replications, note that 10,000 reps take a while to run */
         drop _all
         set obs 1000                           /*  no. of obs. */

         gen u = 0.8944272*invnorm(uniform())           /* commone error component */
         gen e = u + 0.4472136*invnorm(uniform())       /* 2nd stage error */
         gen v = u + 0.4472136*invnorm(uniform())       /* 1st stage error */

/* create the instruments */

         gen z0 = invnorm(uniform())
         gen z1 = invnorm(uniform())
         gen z2 = invnorm(uniform())
         gen z3 = invnorm(uniform())
         gen z4 = invnorm(uniform())
         gen z5 = invnorm(uniform())
         gen z6 = invnorm(uniform())
         gen z7 = invnorm(uniform())
         gen z8 = invnorm(uniform())
         gen z9 = invnorm(uniform())
         gen z10 = invnorm(uniform())
         gen z11 = invnorm(uniform())
         gen z12 = invnorm(uniform())
         gen z13 = invnorm(uniform())
         gen z14 = invnorm(uniform())
         gen z15 = invnorm(uniform())
         gen z16 = invnorm(uniform())
         gen z17 = invnorm(uniform())
         gen z18 = invnorm(uniform())
         gen z19 = invnorm(uniform())
         gen z20 = invnorm(uniform())

/* create the endogenous regressor */

         gen x = 0.1*z0 + v

/* create the dep. var. */

         gen y = x + e

/* regressions */

         reg y x
         post `sim1' (_b[x])

         ivregress 2sls y (x=z0)
         post `sim2' (_b[x])

         reg x z0
         post `simf2' (e(F))

         ivregress 2sls y (x=z0 z1)
         post `sim3' (_b[x])

         reg x z0 z1
         post `simf3' (e(F))

         ivregress liml y (x=z0 z1)
         post `sim4' (_b[x])

         ivregress 2sls y (x=z0 z1 z2 z3 z4 z5 z6 z7 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18 z19)
         post `sim5' (_b[x])

         reg x z0 z1 z2 z3 z4 z5 z6 z7 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18 z19
         post `simf5' (e(F))

         ivregress liml y (x=z0 z1 z2 z3 z4 z5 z6 z7 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18 z19)
         post `sim6' (_b[x])

         ivregress 2sls y (x=z1 z2 z3 z4 z5 z6 z7 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18 z19 z20)
         post `sim7' (_b[x])

         reg x z1 z2 z3 z4 z5 z6 z7 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18 z19 z20	
         post `simf7' (e(F))

         ivregress liml y (x=z1 z2 z3 z4 z5 z6 z7 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18 z19 z20)
         post `sim8' (_b[x])

         noisily disp in gr "replication  " in yel `i'

         local i = `i' + 1

         }
    }
     postclose `sim1'
     postclose `sim2'
     postclose `sim3'
     postclose `sim4'
     postclose `sim5'
     postclose `sim6'
     postclose `sim7'
     postclose `sim8'
     postclose `simf2'
     postclose `simf3'
     postclose `simf5'
     postclose `simf7'


end


mcb

/* compute the empirical distribution function for each estimator */

use res1, clear
sort b_ols
gen p_ols = _n/_N
rename b_ols x
kdensity x if x > 0 & x < 2.5, gen(x2 d_ols)
save res1, replace

use res2
sort b_iv
gen p_iv = _n/_N
rename b_iv x
kdensity x if x > 0 & x < 2.5, gen(x2 d_iv)
save res2, replace

use res3
sort b_2sls
gen p_2sls = _n/_N
rename b_2sls x
kdensity x if x > 0 & x < 2.5, gen(x2 d_2sls)
save res3, replace

use res4
sort b_liml
gen p_liml = _n/_N
rename b_liml x
kdensity x if x > 0 & x < 2.5, gen(x2 d_liml)
save res4, replace

use res5
sort b_2sls20
gen p_2sls20 = _n/_N
rename b_2sls20 x
kdensity x if x > 0 & x < 2.5, gen(x2 d_2sls20)
save res5, replace

use res6
sort b_liml20
gen p_liml20 = _n/_N
rename b_liml20 x
kdensity x if x > 0 & x < 2.5, gen(x2 d_liml20)
save res6, replace

use res7
sort b_2slsgr
gen p_2slsgr = _n/_N
rename b_2slsgr x
kdensity x if x > 0 & x < 2.5, gen(x2 d_2slsgr)
save res7, replace

use res8
sort b_limlgr
gen p_limlgr = _n/_N
rename b_limlgr x
kdensity x if x > 0 & x < 2.5, gen(x2 d_limlgr)
save res8, replace


/* put all the distribution functions together in one dataset */

append using res1
append using res2
append using res3
append using res4
append using res5
append using res6
append using res7


label var p_ols "OLS"
label var p_iv "IV"
label var p_2sls "2SLS"
label var p_liml "LIML"
label var p_2sls20 "2SLS"
label var p_liml20 "LIML"
label var p_2slsgr "2SLS"
label var p_limlgr "LIML"

keep if x > 0 & x < 2.5
/* create the figures in the book */
* Figure 4.6.1
twoway (line p_ols x, xline(1)) ///
(line p_iv x, lpattern("-")) ///
(line p_2sls x, lpattern("-")) ///
(line p_liml x, lpattern("-") ///
yline(0.5,lpattern("-")) ylabel(0(0.25)1))

* Figure 4.6.2
twoway (line p_ols x, xline(1)) ///
(line p_2sls20 x, lpattern("-")) ///
(line p_liml20 x, lpattern("-") ///
yline(0.5,lpattern("-")) ylabel(0(0.25)1))

* Figure 4.6.3
twoway (line p_ols x, xline(1)) ///
(line p_2slsgr x, lpattern("-")) ///
(line p_limlgr x, lpattern("-") ///
yline(0.5,lpattern("-")) ylabel(0(0.25)1))

save res, replace

set more 0
log close
