/* Stata code for Figure 5.2.4 */

/* Download data */
* shell curl -o final5.dta http://economics.mit.edu/files/1358

do mmoulton
/* Import data */
use "final5.dta", clear

replace avgmath= avgmath-100 if avgmath>100

gen func1 = c_size  / (floor((c_size - 1) / 40) + 1)
gen func2 = cohsize / (floor(cohsize      / 40) + 1)

replace avgmath  = . if mathsize == 0
replace passmath = . if mathsize == 0

/* Sample restrictions */
keep if 1 < classize & classize < 45 & c_size > 5
keep if c_leom == 1 & c_pik < 3

g byte disc= (c_size>=36 & c_size<=45) | (c_size>=76 & c_size<=85) | ///
	(c_size>=116 & c_size<=125)

g byte all=1
g c_size2= (c_size^2)/100

sum avgmath
sum avgmath if disc == 1
* OLS
mmoulton avgmath classize, cluvar(schlcode)
mmoulton avgmath classize tipuach, cluvar(schlcode)
mmoulton avgmath classize tipuach c_size, clu(schlcode)

* 2SLS
* Full sample
mmoulton avgmath (classize=func1) tipu c_size, clu(schlcode) 2sls
mmoulton avgmath (classize=func1) tipu c_size c_size2, clu(schlcode) 2sls

* Discontinuity sample with 5
mmoulton avgmath (classize=func1) tipu if disc==1, clu(schlcode) 2sls
mmoulton avgmath (classize=func1) tipu c_size if disc==1, clu(schlcode) 2sls

* Discontinuity sample with 3
drop disc
g byte disc= (c_size>=38 & c_size<=43) | (c_size>=78 & c_size<=83) | ///
	(c_size>=118 & c_size<=123)
sum avgmath if disc == 1
* Segment 
g s1 = (c_size>=36 & c_size<=45)
g s2 = (c_size>=76 & c_size<=85) 
* New instruments
g z1 = (c_size>=41 & c_size<=43) 
g z2 = (c_size>=81 & c_size<=83) 
g z3 = (c_size>=121 & c_size<=123) 
* col 8
mmoulton avgmath (classize=z1 z2 z3) s1 s2 if disc==1, clu(schlcode) 2sls
/* End of script */
