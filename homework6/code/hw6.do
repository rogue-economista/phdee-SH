// HW 6 Environmental Economics II
// Suneye R. Holmes



// update working directory
cd "C:\Users\sholmes\OneDrive - Spelman College\Desktop\GATech\ECON 7103 Environmental II\phdee-SH\homework6\"

// import, format and save the .csv file
import delimited "raw\instrumentalvehicles.csv"

label variable price "sales price in USD"
label variable car "make of the vehicle"
label values car make
label define make 1 "Sedan" 2 "SUV"
label variable mpg "Fuel efficiency"
label variable weight "vehicle weight (lbs)"
label variable height "vehicle height (in)"
label variable length "vehicle length (in)"

save "raw\instrumentalvehicles.dta"

