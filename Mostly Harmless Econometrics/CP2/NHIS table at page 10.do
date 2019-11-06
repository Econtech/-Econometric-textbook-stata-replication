/* create NHIS table on page 10 of MHE */
cd d:/Data
* load dataset
use nhis_13,clear
* generate the table
keep if phstat <= 5 & phospy <= 2
ttest phstat, by(phospy) 
