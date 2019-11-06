/* Change working directory */
cd d:/Data

/* Import data */
infile lwklywge educ yob qob pob using asciiqob.txt, clear
/* Get fitted line */
regress lwklywge educ
predict yhat, xb

/* Calculate means by collapsing the data */
collapse lwklywge yhat, by(educ)

/* Graph the figures */
graph twoway (connected lwklywge educ, lcolor(black) mcolor(black)) ///
			 (line yhat educ, lcolor(black) lpattern("-")),         ///
			 ylabel(4.8(0.2)6.6) ymtick(4.9(0.2)6.5)                ///
			 xlabel(0(2)20) xmtick(1(2)19)                          ///
             ytitle("Log weekly earnings, $2003")                   ///
             xtitle("Years of completed education")                 ///
             legend(off)                                            ///
			 scheme(s1mono)

graph export "Figure 3-1-2-Stata.pdf", replace

/* End of file */




