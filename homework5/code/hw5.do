// HW 5 - Suneye Holmes
// Environmental Econ II



// update working directory and open data file
cd "C:\Users\sholmes\OneDrive - Spelman College\Desktop\GATech\ECON 7103 Environmental II\phdee-SH\homework5"
use "raw\energy_staggered.dta"


// 1-Hourly data
// generate a time variable using clock syntax
gen double date = clock( datetime, "DM20Yhms")

xtset id date, clocktime


// generate a treatment cohort variable and report the number of cohorts
egen cohort = group( devicegroup treatment)
sum cohort treatment if treatment ==1


// 2-install and use twowayfeweights and report results
//ssc install gtools, replace
//ssc install fetwowayweights

count if !missing( energy, cohort, date, treatment )
twowayfeweights energy id devicegroup treatment, type(feTR)


// 3-run xtdidregress 
xtdidregress (energy temperature precipitation relativehumidity id) (treatment), group(cohort) time(date) vce(cluster zip)	// this syntax says "id not nested within cohort"


save "raw\energy_staggered.dta", replace







// 2-Daily data
// collapse to daily data
gen daily = dofc(date)
format daily %td
collapse energy temperature precipitation relativehumidity treatment cohort zip id, by(daily)


// 1-estimate 2wfe on the daily data and report on the ATT and clustered SE



// estimate the event-study regression
reghdfe energy temperature precipitation relativehumidity, absorb(id daily) group(cohort) vce(cluster zip)

save "energy_staggered_daily.dta", replace




