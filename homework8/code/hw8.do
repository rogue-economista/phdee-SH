// HW8 Environmental Economics II
// Suneye Holmes


// update working directory
cd "C:\Users\sholmes\OneDrive - Spelman College\Desktop\GATech\ECON 7103 Environmental II\phdee-SH\homework8"


// open dataset
use "data\recycling_hw.dta" 

// 1. Generate yearly plot of the recycling rate for NYC and the controls
xtset id year
twoway (tsline recyclingrate if nyc==1) (tsline recyclingrate if nj==1) (tsline recyclingrate if ma==1)


// 2. Estimate the effect of the recycling pause on the recycling rate in NYC using a TWFE regression, clustered at the region level. 
didregress (recyclingrate) (nyc, continuous), nogteffects group(id) time(year) vce(cluster region)


// 3. Use sdid syntax to estimate the synthetic DiD version of the regression in #2.
sdid recyclingrate id year nyc, vce(placebo) graph



// 4. Estimate the event study regression using reg, xtreg or reghdfe syntax
reghdfe recyclingrate munipop2000 incomepercapita collegedegree2000 democratvoteshare2000 democratvoteshare2004 nonwhite, a(year region) vce(cluster region)
coefplot, citype(normal)
graph export "output\coefplot.jpg", as(jpg) name("Graph") quality(90)


// 5. Generate synthetic control estimates of the dynamic treatment effects using synth and synth_runner syntax with placebo inference.

//a. plot of raw outcomes for treated and control groups over time
tsset id year

synth recyclingrate munipop2000 recyclingrate incomepercapita collegedegree2000 democratvoteshare2000 democratvoteshare2004 nonwhite, trunit(5) trperiod(1999)


//b. plot of raw outcomes for treated group and synthetic control group over time



//c. plot of estimated synthetic control effects and placebo effects over time



//d. plot of final synthetic control estimates over time



