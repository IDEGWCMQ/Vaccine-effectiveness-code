
use Dataset
gen CaseControl=1 if PCRresult==1
replace CaseControl=0 if PCRresult==0
label define CaseControl 1"PCR positive" 0"PCR negative"
label values CaseControl CaseControl
ccmatch Sex Age Nationality ReasonforPCRTesting, cc(CaseControl) id(id)
keep if match~=.
merge 1:1 id using Vaccine
drop if _merge==2
gen diff=PCRDate-ImmDate
gen Vaccination=1 if (diff>=0 & diff~=.)
replace Vaccination=0 if Vaccination==.
cc CaseControl Vaccination
gen Calendar=1 if inrange(PCRDate, td(01feb2021), td(07feb2021))
replace Calendar=2 if inrange(PCRDate, td(08feb2021), td(14feb2021))
replace Calendar=3 if inrange(PCRDate, td(15feb2021), td(21feb2021))
replace Calendar=4 if inrange(PCRDate, td(22feb2021), td(28feb2021))
replace Calendar=5 if inrange(PCRDate, td(01mar2021), td(07mar2021))
replace Calendar=6 if inrange(PCRDate, td(08mar2021), td(14mar2021))
replace Calendar=7 if inrange(PCRDate, td(15mar2021), td(21mar2021))
replace Calendar=8 if inrange(PCRDate, td(22mar2021), td(28mar2021))
replace Calendar=9 if inrange(PCRDate, td(29mar2021), td(04apr2021))
replace Calendar=10 if inrange(PCRDate, td(05apr2021), td(11apr2021))
replace Calendar=11 if inrange(PCRDate, td(12apr2021), td(18apr2021))
replace Calendar=12 if inrange(PCRDate, td(19apr2021), td(25apr2021))
replace Calendar=13 if inrange(PCRDate, td(26apr2021), td(02may2021))
replace Calendar=14 if inrange(PCRDate, td(03may2021), td(10may2021))
label define Calendar 1"1-7 Feb" 2"8-14 Feb" 3"15-21 Feb" 4"22-28 Feb" 5"1-7 Mar" 6"8-14 Mar" 7"15-21 Mar" 8"22-28 Mar" 9"29 Mar-4 Apr" 10"5-11 Apr" 11"12-18 Apr" 12"19-25 Apr" 13"26 Apr-2 May" 14"3-10 May"
label values Calendar Calendar
xi: logistic CaseControl i.Vaccination i.Calendar 
xi: logistic CaseControl i.Vaccination i.Calendar i.Sex i.Nationality i.ReasonforPCRTesting Age
bys CaseControl: summ PCRDate, detail
save Dataset, replace






