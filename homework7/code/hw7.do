// HW 7
// Suneye Holmes
// Environmental Econ II\phdee-SH\homework7


// update working directory
cd "C:\Users\sholmes\OneDrive - Spelman College\Desktop\GATech\ECON 7103 Environmental II\phdee-SH\homework7"


// open dataset
use "\data\instrumentalvehicles.dta"


// run sharp RD
rdrobust price length, c(225) bwselect(mserd)
eststo model1
etable, estimates(model1) title("HW 7 Shard RD Plot") export(output\hw7.docx, replace)


// run rdplot
rdplot price length, c(225)
graph save "Graph" "\output\rdplot.gph"
graph export "\output\rdplot.jpg", as(jpg) name("Graph") quality(90)