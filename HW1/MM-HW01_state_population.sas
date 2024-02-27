/* Name: Mansi Mistry */
/* Student ID: 20011402 */

data statepop;
   infile datalines;
   input state $ 1-2 Metro_90 4-11  non_metro_90 12-18 region 21;
   
datalines;
ME    .443    .785  1	
NH    .659    .450  1	
VT    .152    .411  1	
MA   5.788    .229  1	
RI    .938    .065  1	
CT   3.148    .140  1	
NY  16.515   1.475  1	
NJ   7.730     xx   1	
PA  10.083   1.799  1	
DE    .553    .113  2	
MD   4.439    .343  2	
DC    .607     xx   2	
VA   4.773   1.414  2	
WV    .748   1.045  2	
NC   4.376   2.253  2	
SC   2.423   1.064  2	
GA   4.352   2.127  2	
FL  12.023    .915  2	
KY   1.780   1.906  2	
TN   3.298   1.579  2	
AL   2.710   1.331  2	
MS    .776   1.798  2	
AR   1.040   1.311  2	
LA   3.160   1.060  2	
OK   1.870   1.276  2	
TX  14.166   2.821  2	
OH   8.826   2.021  3	
IN   3.962   1.582  3	
IL   9.574   1.857  3	
MI   7.698   1.598  3	
WI   3.331   1.561  3	
MN   3.011   1.364  3	
IA   1.200   1.577  3	
MO   3.491   1.626  3	
ND    .257    .381  3	
SD    .221    .475  3	
NE    .787    .791  3	
KS   1.333   1.145  3	
MT    .191    .608  4	
ID    .296    .711  4	
WY    .134    .319  4	
CO   2.686    .608  4	
NM    .842    .673  4	
AZ   3.106    .559  4	
UT   1.336    .387  4	
NV   1.014    .183  4	
WA   4.036    .830  4	
OR   1.985    .858  4	
CA  28.799    .961  4	
AK    .226    .324  4	
HI    .836    .272  4	
;
run;

title 'Entire Database';
proc print data = statepop;
run;


data statePop_clean statePop_dirty;
   	set statepop;
	lddate = today();
   	if non_metro_90 = . then output statePop_dirty;
	else output statePop_clean;
	format lddate date7.;
run;

title 'Clean Data from StatePop Database';
proc print data = statePop_clean;
run;

title 'Missing Data from StatePop Database';
proc print data = statePop_dirty;
run;
