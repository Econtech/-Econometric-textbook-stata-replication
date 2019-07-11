* Example 3.1: Determinants of College GPA
use GPA1,clear
su colGPA hsGPA ACT
reg colGPA hsGPA ACT
reg colGPA ACT

* Example 3.2: Hourly Wage Equation
use WAGE1,clear
su lwage educ exper tenure
reg lwage educ exper tenure

* Example 3.3: Participation in 401(K) Pension Plan
use 401K,clear
su prate mrate age
reg prate mrate age
reg prate mrate


* Example 3.4: Determinants of College GPA
use GPA1,clear
reg colGPA hsGPA ACT

* Example 3.5: Explaining Arrest Records
use CRIME1,clear
su narr86 pcnv avgsen ptime86 qemp86
reg narr86 pcnv ptime86 qemp86
display _b[pcnv]*.5
display 100*_b[pcnv]*.5
display _b[ptime86]*12
display _b[qemp86]*100
reg narr86 pcnv avgsen ptime86 qemp86

* Example 3.6: Hourly Wage Equation
use WAGE1,clear
su lwage educ
reg lwage educ








