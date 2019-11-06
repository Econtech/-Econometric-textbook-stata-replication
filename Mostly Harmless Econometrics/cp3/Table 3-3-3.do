***********************************
*Dehejia and Wahba (1999) - Causal Effects in Nonexperimental Studies:
*                           Reevaluating the Evaluation of Training Programs
***********************************

cap log close

cap log using `path'/pischke.log, text replace

clear

local data "nswre74 cps1re74 cps3re74 "
local datashort "cps1re74 cps3re74"

local spec1 ""
local spec2 "age age2 ed black hisp nodeg"
local spec3 "re75"
local spec4 "re75 age age2 ed black hisp nodeg"
local spec5 "re74 re75 age age2 ed black hisp nodeg"
local spec2a "age age2 ed black hisp nodeg married"
local spec4a "re75 age age2 ed black hisp nodeg married"
local spec5a "re74 re75 age age2 ed black hisp nodeg married"

local line1 "Raw Difference"
local line2 "D+W Demographics"
local line3 "and Marriage Dummy"
local line4 "75 Earnings"
local line5 "D+W Demographics 75 Earnings"
local line6 "and Marriage Dummy"
local line7 "D+W Demographics 74,75 Earnings"
local line8 "and Marriage Dummy"
local lastl "Dropped in pscore regs: "
local nswre74 "NSW"
local cps1re74 "CPS-1"
local cps3re74 "CPS-3"
local nearlylastl "Sample sizes in pscore regs (treated/untreated): "

foreach set in `data' {
    local lctr = 0
    u `set', clear
    forvalues t = 1/5 {
        local ++lctr
        reg re78 treat `spec`t''
            local b = _b[treat]
            local se = _se[treat]
            local b = round(`b',1)
            local se = round(`se',1)
            local line`lctr' "`line`lctr''&    `b' &   (`se')  "
        if `t' == 2 | `t' == 4 | `t' == 5 {
            local ++lctr
            reg re78 treat `spec`t'a'
            local b = _b[treat]
            local se = _se[treat]
            local b = round(`b',1)
            local se = round(`se',1)
            local line`lctr' "`line`lctr''&    `b' &   (`se')  "
        }
    }
}

foreach set in `datashort' {
    local lctr = 1
    local line`lctr' "`line`lctr''&         &        "
    u `set', clear
    forvalues t = 2/5 {
        local ++lctr
        probit treat `spec`t''
        preserve
            predict pscore, pr
            keep if pscore >.1 & pscore <.9
            sum treat
            if `r(N)' != 0 {
                sum treat if treat == 1
                local nearlylastl "`nearlylastl' ``set'' Spec `t': `r(N)'"
                sum treat if treat == 0
                local nearlylastl "`nearlylastl'/`r(N)';"
                reg re78 treat `spec`t''
                local dctr = 0
                foreach var in `spec`t'' {
                    if _se[`var'] == 0 {
                        local ++dctr
                        if `dctr' == 1 local lastl "`lastl'; ``set'' Spec `t': `var'"
                        else local lastl "`lastl', `var'"
                    }
                }
                local b = _b[treat]
                local se = _se[treat]
                local b = round(`b',1)
                local se = round(`se',1)
                local line`lctr' "`line`lctr''&    `b' &   (`se')  "
            }
            else {
                local line`lctr' "`line`lctr''&  no   &  obs.   "
                local nearlylastl "`nearlylastl' ``set'' Spec `t': 0/0;"
            }
        restore
        if `t' == 2 | `t' == 4 | `t' == 5 {
            local ++lctr
            probit treat `spec`t'a'
            preserve
                predict pscore, pr
                keep if pscore >.1 & pscore <.9
                sum treat if treat == 1
                local nearlylastl "`nearlylastl' ``set'' Spec `t'a: `r(N)'"
                sum treat if treat == 0
                local nearlylastl "`nearlylastl'/`r(N)';"
                reg re78 treat `spec`t'a'
                local dctr = 0
                foreach var in `spec`t'a' {
                    if _se[`var'] == 0 {
                        local ++dctr
                        if `dctr' == 1 local lastl "`lastl'; ``set'' Spec `t'a: `var'"
                        else local lastl "`lastl', `var'"
                    }
                }
                local b = _b[treat]
                local se = _se[treat]
                local b = round(`b',1)
                local se = round(`se',1)
                local line`lctr' "`line`lctr''&    `b' &   (`se')  "
            restore
        }
    }
}





file open holder using `path'/table.tex, write replace text
file write holder "\documentclass[a4paper,12pt,fleqn]{article} "_n
file write holder "\usepackage{rotating} "_n
file write holder "\begin{document} " _n
file write holder "\begin{sidewaystable} " _n
file write holder "\begin{center} " _n
file write holder "\begin{tabular}{l cc cc cc | cc cc} " _n
file write holder "                 &   \multicolumn{6}{c}{Full Sample}     & \multicolumn{4}{c}{Propensity Selected Sample}    \\"
file write holder "Specification    &   \multicolumn{2}{c}{NSW}  &   \multicolumn{2}{c}{CPS-1}  &   \multicolumn{2}{c}{CPS-3} &   \multicolumn{2}{c}{CPS-1}  &   \multicolumn{2}{c}{CPS-3} \\[.5em]\hline\\[-.5em]" _n
forvalues t = 1/`lctr' {
    file write holder "`line`t''   \\"
    if `t' == 1 | `t' == 3 | `t' == 4 | `t' == 6 {
        file write holder "[1em]"
    }
    if `t' == `lctr' {
        file write holder "[1em]\hline\\[-1em]"
    }
    file write holder _n
}
file write holder "\end{tabular} " _n
file write holder "\end{center} " _n
file write holder "`nearlylastl'" _n _n
file write holder "`lastl'" _n
file write holder "\end{sidewaystable} " _n
file write holder "\end{document} " _n
file close holder
