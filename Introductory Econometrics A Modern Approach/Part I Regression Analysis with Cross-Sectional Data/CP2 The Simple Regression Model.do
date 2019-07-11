* Example 2.3: CEO Salary and Return on Equity
use CEOSAL1,clear
reg salary roe
display _b[roe]*30+_b[_cons]

* Example 2.4: Wage and Education
use WAGE1,clear
reg wage educ 
display _b[educ]*8+_b[_cons]

* Example 2.5: Voting Outcomes and Campaign Expenditures
use VOTE1,clear
reg voteA shareA

* Example 2.6: CEO Salary and Return on Equity
use CEOSAL1,clear
reg salary roe
predict salhat, xb
gen uhat=salary-salhat
list roe salary salhat uhat in 1/15

* Example 2.7: Wage and Education
use WAGE1,clear
summ wage educ
reg wage educ 
display _b[educ]*12.56+_b[_cons]

* Example 2.8: CEO Salary and Return on Equity
use CEOSAL1,clear
reg salary roe

* Example 2.9: Voting Outcomes and Campaign Expenditures
use VOTE1,clear
reg voteA shareA

* Example 2.10: A Log Wage Equation
use WAGE1
reg lwage educ

* Example 2.11: CEO Salary and Firm Sales
use CEOSAL1,clear
reg lsalary lsales

* Example 2.12: Student Math Performance and the School Lunch Program
use MEAP93,clear
reg math10 lnchprg












