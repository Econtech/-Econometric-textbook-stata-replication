/* Import data */
* infile lwklywge educ yob qob pob using asciiqob.txt, clear
use NEW7080 ,clear
* Rename the variables
rename v1 AGE
rename v2 AGEQ
rename v4 EDUC
rename v5 ENOCENT
rename v6 ESOCENT
rename v9 LWKLYWGE
rename v10 MARRIED
rename v11 MIDATL
rename v12 MT
rename v13 NEWENG
rename v16 CENSUS
rename v18 QOB
rename v19 RACE
rename v20 SMSA
rename v21 SOATL
rename v24 WNOCENT
rename v25 WSOCENT
rename v27 YOB

keep if RACE == 0 & AGE>=40 & AGE<=49 

/* Panel A */
/* Old-fashioned standard errors */
regress LWKLYWGE EDUC  
regress LWKLYWGE EDUC, robust

/* Collapse data for Panel B (counting only if in sample) */
gen count = 1 if e(sample)
collapse (sum) count (mean) LWKLYWGE, by(EDUC)
regress LWKLYWGE EDUC [aweight = count]
regress LWKLYWGE EDUC [aweight = count],robust

/* End of file */

