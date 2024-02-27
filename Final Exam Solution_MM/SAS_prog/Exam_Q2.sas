/*
Question 2
*/
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

