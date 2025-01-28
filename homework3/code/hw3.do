// Suneye Holmes
// ECON 7103 Homework 3 using Stata

cd "C:\Users\sholmes\OneDrive - Spelman College\Desktop\GATech\ECON 7103 Environmental II\phdee-SH\homework3"

use "data\kwh.dta"

// 1 - Create logged variables
gen logy = log( electricity)
gen logz1 = log( sqft)
gen logz2 = log( temp)


// 2 - OLS regression on the log-transformed variables and storing coefficient estimates
regress logy retrofit logz1 logz2



// 3 - Save the average marginal effects
quietly regress logy retrofit logz1 logz2
estimates store logreg
margins, dydx(*) atmean
estimates store ame


// 4 - Bootstrap the 95% CIs
program savemargins, rclass
eststo: regress logy retrofit logz1 logz2
estimates store logreg1
eststo: margins, dydx(*) atmean
estimates store ame1
end

bootstrap _b, saving(margins, replace) reps(1000): savemargins regress logy retrofit logz1 logz2
estat bootstrap, all


// 5 - Generate Table of Results for LaTeX
esttab using hw3.tex


// 6 - Graph of Average ME of square foot of the home
quietly regress logy retrofit#sqft logz2 
margins sqft
marginsplot


// 7 - Graph of Average ME of outdoor temperature
quietly regress logy retrofit temp logz1 
margins i.temp#retrofit
marginsplot