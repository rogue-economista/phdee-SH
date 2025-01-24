// Suneye Holmes
// ECON 7103 Homework 2, Part 2-Stata

cd "C:\Users\sholmes\OneDrive - Spelman College\Desktop\GATech\ECON 7103 Environmental II\phdee-SH\homework2"

// 0-Import the raw data and save
import delimited "raw\kwh.csv"
save "kwh.dta"


// 1-Balance Table
// 1.1-Create the table
table (command)(result), ///
	command(Control = r(mu_1) r(sd_1) Treatment = r(mu_2) r(sd_2) ///
	Diff = (r(mu_2)-r(mu_1)) pvalue = r(p) ///
	: ttest electricity, by(retrofit)) ///
	command(Control = r(mu_1) r(sd_1) Treatment = r(mu_2) r(sd_2) ///
	Diff = (r(mu_2)-r(mu_1)) pvalue = r(p) ///
	: ttest sqft, by(retrofit)) ///
	command(Control = r(mu_1) r(sd_1) Treatment = r(mu_2) r(sd_2) ///
	Diff = (r(mu_2)-r(mu_1)) pvalue = r(p) ///
	: ttest temp, by(retrofit)) ///
	nformat(%6.2f Control Treatment SD Diff) nformat(%6.0f pvalue)
	
// 1.2-relabel rows
	collect label levels command 1 "electricity" ///
								 2 "sqft" ///
								 3 "temp", modify

// 1.3-relabel columns
	collect label levels result Control "Control Mean", modify
	collect label levels result "Standard deviation for the first variable" "Control s.d.", modify
	collect label levels result Treatment "Treatment Mean", modify
	collect label levels result "Standard deviation for the second variable" "Treatment s.d.", modify
	
collect preview





// 2-Twoway Scatterplot
twoway (scatter electricity sqft), ytitle(`"Electicity Usage (kWh)"') xtitle(`"Household Size (Sq. Feet)"') title(`"Electricity Consumption and Home Size"') subtitle(`"Homework 2, #2"') scheme(sj)
graph save "Graph" "output\scatter.gph"
graph export "output\scatter.jpg", as(jpg) name("Graph") quality(90)



// 3-Regression
regress electricity sqft retrofit temp, vce(robust)

// 3.1-outreg syntax
outreg2 using "output\hw2-regression, replace
 



