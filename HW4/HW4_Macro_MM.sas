libname sasdata "O:\FE517\SAS_data" access=read;
run;

proc copy in=sasdata out=work;
   select dgs10_dup ;
run;

proc copy in=sasdata out=work;
   select sp500_dup ;
run;

data dgs10;
	set dgs10_dup;
	by date;
	if first.date then output;
run;

data sp500;
	set sp500_dup;
	by date;
	if first.date then output;
run;

%let dsn=dgs10; %let varn=DGS10;
%let dsn=SP500; %let varn=SP500;
%let mdate=01JAN2022;

%macro mdata_clean(dsn= , varn= , mdate=01JAN2022);

	proc copy in=sasdata out=work;
		select &dsn._dup;
	run;

	data &dsn._clean;
	   set &dsn.;
	   if date <"&mdate"d or &varn.=. then delete;
	run;

    proc univariate data=&dsn._clean;
        var &varn.;
    run;

%mend;

%mdata_clean(dsn=DGS10, varn=DGS10);
%mdata_clean(dsn=SP500, varn=SP500);
