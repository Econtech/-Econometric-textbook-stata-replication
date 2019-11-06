/* Stata code for Table 4-1-2   */
/* Import data */
infile lwklywge educ yob qob pob using asciiqob.txt, clear

/* Create binary instrument */
recode qob (1/2  = 0 "Born in the 1st or 2nd quarter of year") ///
           (3/4  = 1 "Born in the 3rd or 4th quarter of year") ///
           (else = .), gen(z)

/* Compare means (and differences) */
ttest lwklywge, by(z)
ttest educ, by(z)

/* Compute Wald estimate */
sureg (educ z) (lwklywge z) if !missing(z)
nlcom [lwklywge]_b[z] / [educ]_b[z]

/* OLS estimate */
regress lwklywge educ if !missing(z)

/* End of script */
