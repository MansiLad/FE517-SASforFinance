/*
FE 517: Final Exam Solution
Name: Mansi Mistry
CWID: 20011402
*/

/* Soluiton 1 */
PROC IMPORT OUT= WORK.GDPC1_data 
            DATAFILE= "O:\FE517\SAS_rawdata\GDPC1.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc sort data=GDPC1 
	nodupkey;
	by date;
run;

data gdpc_filter;
  set gdpc1_data;
  by date;
  if date >= "01JAN2016"d and date <= "31DEC2020"d then output gdpc_filter;
run;



/* Solution 2 */
libname sasdata "O:\FE517\SAS_data" access = read;
run;

proc copy in=sasdata out=work;
	select inflation wp083;
run;

data wp083_inflation_comined;
	merge inflation(in=indgs rename=(CORESTICKM159SFRBATL=inflation_rate))
		wp083(in=insp);
	by date;
	if indgs and insp then output wp083_inflation_comined;
run ;

ods rtf file="O:\FE517\SAS_output\regression_report.rtf";
  title "Plywood (WP083) and inflation Regression Analysis Results";
	proc reg data=wp083_inflation_comined;
	  model WPU083 = inflation_rate;
run;
quit;
ods rtf close;


/* Solution 3 */
libname sasdata "O:\FE517\SAS_data" access = read;
run;

proc copy in=sasdata out=work;
	select unrate_2021;
run;


data unrate_interval;
  set unrate_2021;
  month = month(date);
  year = year(date);
run;

data unrate_merged;
  merge unrate_interval unrate_2021;
run;

title1 "Unemployment data ";
proc sgplot data=unrate_merged;
   series x=date  y=unrate/ ;
run;

proc esm data=unrate_merged outfor=unrate_fcast LEAD=12;
id  date  INTERVAL=month;
forecast UNRATE/ MODEL=DOUBLE  ;
run;

ods rtf file="O:\FE517\SAS_output\unemployment_forcast_report.rtf";
title1 "Unemployment data ";
proc sgplot data=unrate_fcast;
   series x=date    y=Actual / lineattrs=(  color=black); 
   series x=date    y=lower / lineattrs=(  color=blue);
   series x=date    y=upper / lineattrs=(  color=blue); 
   series x=date    y=predict/lineattrs=(  color=red);
run;
quit;
ods rtf close;
