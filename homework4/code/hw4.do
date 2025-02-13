// HW 4 Suneye Holmes
// Environmental Economics II
// Spring 2025



// update working directory
cd "C:\Users\sholmes\OneDrive - Spelman College\Desktop\GATech\ECON 7103 Environmental II\phdee-SH\homework4"


// import .csv and save as .dta
import delimited "raw\fishbycatch.csv"
save "raw\fishbycatch.dta"

// reshape data
reshape long shrimp salmon bycatch, i(firm) j(catch)

// generate firm dummies
tabulate firm, generate(dummyfirm)

save "raw\fishbycatch_long.dta"
clear all

// run equation (6) the OLS regression controlling for fixed effects
use "raw\fishbycatch_long.dta"
xtset firm
xtreg bycatch treated firmsize shrimp* salmon* dummyfirm*, re level(95)


// run equation (6) the within estimator
xtreg bycatch treated firmsize shrimp* salmon* dummyfirm*, fe level(95)

//export LaTeX table
estimates store m1, title (Eq. 6)
estimates store m2, title (Eq. 6, Modifications for Controlling for Fixed Effects)
esttab m1 m2 using "output\hw4stata", replace	
