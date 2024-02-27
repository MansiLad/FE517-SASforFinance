/*
Question 3
*/

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
