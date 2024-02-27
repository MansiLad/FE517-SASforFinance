libname sasdata "O:\FE517\SAS_data" access=read;

proc copy in=sasdata out=work;
	select fcast_data2;
run;

data year_qtr_month;
	set fcast_data2;
	year = year(weekdate);
	qtr = QTR(weekdate);
	Month = month(weekdate);
	monthdate = mdy(month,1,year);
	format monthdate date7.;
run;

proc sort data=year_qtr_month;
	by year qtr month;
run;

data month_cum;
	set year_qtr_month;
	by year qtr month;
	if first.month then month_cum=0;
	month_cum = month_cum + Prod1_quant;
	if last.month then output;
retain month_cum 0;
run;

proc esm data=month_cum outfor=six_month_fcast LEAD=6;
	id weekdate INTERVAL=month;
	forecast month_cum/ MODEL=Simple ;
run;

ods rtf file="O:\FE517\SAS_Output\Forecast.rtf";

Title "Six Month Forecast";
proc print data=six_month_fcast;
run;
ods rtf close;

