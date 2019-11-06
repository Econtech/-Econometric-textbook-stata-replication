/* Import data */
infile lwklywge educ yob qob pob using asciiqob.txt, clear

/* Column 1: OLS */
regress lwklywge educ, robust

/* Column 2: OLS with YOB, POB dummies */
regress lwklywge educ i.yob i.pob, robust

/* Column 3: 2SLS with instrument QOB = 1 */
tabulate qob, gen(qob)
ivregress 2sls lwklywge (educ = qob1), robust

/* Column 4: 2SLS with instrument (QOB = 1 | QOB = 2) */
gen qob1or2 = (inlist(qob, 1, 2)) if !missing(qob)
ivregress 2sls lwklywge (educ = qob1or2), robust

/* Column 5: 2SLS with YOB, POB dummies and instrument QOB = 1 */
ivregress 2sls lwklywge i.yob i.pob (educ = qob1), robust

/* Column 6: 2SLS with YOB, POB dummies and full QOB dummies */
ivregress 2sls lwklywge i.yob i.pob (educ = i.qob), robust

/* Column 7: 2SLS with YOB, POB dummies and full QOB dummies interacted with YOB */
ivregress 2sls lwklywge i.yob i.pob (educ = i.qob#i.yob), robust

/* Column 8: 2SLS with age, age squared, YOB, POB dummies and with full QOB dummies interacted with YOB */
gen age = 80.25 - yob - qob/4
gen age2 = age^2
ivregress 2sls lwklywge age age2 i.yob i.pob (educ = i.qob#i.yob), robust

/* End of script */
