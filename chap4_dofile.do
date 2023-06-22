
***chapter-4

**Maternal&Child Healthcare Access in India

clear
set maxvar 32000
use "C:\Users\91798\Desktop\flame\FSP\Dissertation\financial inclusion and healthcare\chapter-4\IAKR7AFL.DTA",clear

********* Sample Weights Construction [wt]
gen wt = v005/1000000


********* outcome variables

**institutional delivery in pr

replace m15 = 0 if m15==96

gen instbirth05 =.
replace instbirth05 = 1 if m15>20
replace instbirth05 = 0 if m15<14
label define instbirth05 1 "Yes" 0 "No"
label values instbirth05 instbirth05

gen pvtbirth=.
replace pvtbirth = 1 if (m15==31 | m15==32)
replace pvtbirth = 0 if (m15~=31 & m15~=32)
label define pvtbirth 1 "Yes" 0 "No"
label values pvtbirth pvtbirth 


********* Indicator Construction - csecdelivery - C-Section delivery   - Diarrhoea

gen csecdelivery05 = .
replace csecdelivery05 = 1 if m17==1
replace csecdelivery05 = 0 if m17==0

***8c-section in private hosp

gen pvtcsecd =.

replace pvtcsecd = 1 if csecdelivery05==1 & pvtbirth==1
replace pvtcsecd = 0 if csecdelivery05==0 & pvtbirth==1
label define pvtcsecd 1 "yes"  0 "No"
label value pvtcsecd pvtcsecd





*********************   health insurance IR file




*use "C:\Users\91798\Desktop\flame\FSP\Dissertation\NFHS5\IAIR7AFL.DTA"
*tab v481 [aw=wt]

rename v481 HI

***explanatory variables*****
gen educ =.
replace educ = 1 if v133==0
replace educ = 2 if v133==1 | v133==2 | v133==3 | v133==4 | v133==5
replace educ = 3 if v133==6 | v133==7 | v133==8 | v133==9 | v133==10
replace educ = 4 if v133==11 | v133==12 | v133==13 | v133==14 | v133==15 | v133==16 | v133==17 | v133==18 | v133==19 | v133==20
label define educ 1 "No education" 2 "primary" 3 "secondary" 4 "higher" 
label values educ educ

gen agegroup = .
replace agegroup = 1 if v012 >= 15 & v012 < 25
replace agegroup = 2 if v012 > 24 & v012 < 39
replace agegroup = 3 if v012 > 39 
label define agegroup 1 "15-24" 2 "25-39" 3 "40 or above"
label value agegroup agegroup

gen religion = 1 if v130==1
replace religion = 2 if v130==2
replace religion = 3 if v130>2
label define religion 1 "Hindu" 2 "Muslim" 3 "Others"
label value religion religion

gen soccategory = s116

replace soccategory= 4 if soccategory== 5 | soccategory== 8

label define soccategory 1 "ST" 2 "SC" 3 "OBC" 4 "None of the above or don't know"
label value soccategory soccategory

gen sector = v025
label define sector 1"urban" 2 "rural"
label value sector sector


***Table-1*****
tabstat HI pvtbirth pvtcsecd [aw=wt], stat(mean)
tabstat HI pvtbirth pvtcsecd [aw=wt], stat(mean) by(agegroup)
tabstat HI pvtbirth pvtcsecd [aw=wt], stat(mean) by(v190)
tabstat HI pvtbirth pvtcsecd [aw=wt], stat(mean) by(educ)
tabstat HI pvtbirth pvtcsecd [aw=wt], stat(mean) by(soccategory)
tabstat HI pvtbirth pvtcsecd [aw=wt] , stat(mean) by(sector)

tabstat HI pvtbirth pvtcsecd [aw=wt] , stat(semean)
tabstat HI pvtbirth pvtcsecd [aw=wt], stat(semean) by(agegroup)
tabstat HI pvtbirth pvtcsecd [aw=wt], stat(semean) by(v190)
tabstat HI pvtbirth pvtcsecd [aw=wt], stat(semean) by(educ)
tabstat HI pvtbirth pvtcsecd [aw=wt], stat(semean) by(soccategory)
tabstat HI pvtbirth pvtcsecd [aw=wt] , stat(semean) by(sector)

***Figure-2***
 egen gp = group(educ v190),label
 
 tabstat HI [aw=wt], stat(mean) by(gp)
 
 graph bar (mean) HI [aw=wt], over(gp)
 
 ***Figure-1*****
 
 **tabulating mean(%) data for all three variables in a new dta file
  tabstat HI [aw=wt], stat(mean) by(v024)
  tabstat pvtbirth [aw=wt], stat(mean) by(v024)
   tabstat pvtcsecd [aw=wt], stat(mean) by(v024)
   
 
 
 **maps***
 
 ssc install spmap
 ssc install spshape2dta
 
cd "C:\Users\91798\Desktop\flame\FSP\Dissertation\financial inclusion and healthcare\chapter-4\India_State_Shapefile"

spshape2dta India_State_Boundary

use  India_State_Boundary,clear


*gen id =.
*gen state=.


*rename name_1 state


merge 1:1 _ID using "C:\Users\91798\Desktop\flame\FSP\Dissertation\financial inclusion and healthcare\chapter-4\shpfile\mmmmean.dta"



****figure-2***

use "C:\Users\91798\Desktop\flame\FSP\Dissertation\financial inclusion and healthcare\chapter-4\shpfile\mmmmean.dta",clear

gen state_code =_n

label define state_code ///
1	"jammu & kashmir"	///
2	"himachal pradesh"	///
3	"punjab"	///
4	"chandigarh"	///
5	"uttarakhand"	///
6	"haryana"	///
7	"nct of delhi"	///
8	"rajasthan"	///
9	"uttar pradesh"	///
10	"bihar"	///
11	"sikkim"	///
12	"arunachal prades"	///
13	"nagaland"	///
14	"manipur"	///
15	"mizoram"	///
16	"tripura"	///
17	"meghalaya"	///
18	"assam"	///
19	"west bengal"	///
20	"jharkhand"	///
21	"odisha"	///
22	"chhattisgarh"	///
23	"madhya pradesh"	///
24	"gujarat"	///
25	"dadra & nagar ha"	///
26	"maharashtra"	///
27	"andhra pradesh"	///
28	"karnataka"	///
29	"goa"	///
30	"lakshadweep"	///
31	"kerala"	///
32	"tamil nadu"	///
33	"puducherry"	///
34	"andaman & nicoba"	///
35	"telangana"	///
36	"ladakh"

label value state_code state_code

**heatmap**

heatplot hi state_code
heatplot pvtbirth state_code
heatplot pvtcsecd state_code

****figure-3****

**using Kr dataset

**figure-4****

****figure-2***

use "C:\Users\91798\Desktop\flame\FSP\Dissertation\financial inclusion and healthcare\chapter-4\shpfile\mmmmean.dta",clear

gen state_code =_n

label define state_code ///
1	"jammu & kashmir"	///
2	"himachal pradesh"	///
3	"punjab"	///
4	"chandigarh"	///
5	"uttarakhand"	///
6	"haryana"	///
7	"nct of delhi"	///
8	"rajasthan"	///
9	"uttar pradesh"	///
10	"bihar"	///
11	"sikkim"	///
12	"arunachal prades"	///
13	"nagaland"	///
14	"manipur"	///
15	"mizoram"	///
16	"tripura"	///
17	"meghalaya"	///
18	"assam"	///
19	"west bengal"	///
20	"jharkhand"	///
21	"odisha"	///
22	"chhattisgarh"	///
23	"madhya pradesh"	///
24	"gujarat"	///
25	"dadra & nagar ha"	///
26	"maharashtra"	///
27	"andhra pradesh"	///
28	"karnataka"	///
29	"goa"	///
30	"lakshadweep"	///
31	"kerala"	///
32	"tamil nadu"	///
33	"puducherry"	///
34	"andaman & nicoba"	///
35	"telangana"	///
36	"ladakh"

label value state_code state_code

graph box hi pvtbirth pvtcsecd, over(state_code)

 







 
 

