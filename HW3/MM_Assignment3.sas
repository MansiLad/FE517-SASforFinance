proc sort data=AAPL; 
	by date; 
run;

proc sort data=MSFT; 
	by date; 
run;

data aapl_nodup;
	set aapl;
	by date;
	if first.date then output;
	drop high low close adj_close volume;
run;

data msft_nodup;
	set msft;
	by date;
	if first.date then output;
	drop high low close adj_close volume;
run;

data both msft_only aapl_only;
	merge msft_nodup(in=inmsft rename=(open=MSFT_open))
		aapl_nodup(in=inaapl rename=(open=AAPL_open))
		;
	by date;
	if inmsft and inaapl then output both;
	else if inmsft then output msft_only;
	else output aapl_only;
run ;


ods rtf file="O:\FE517\SAS_output\Assignment3.rtf";

Title "Microsoft and Apple Open Prices";
Title2 "Source: Yahoo Finance";
proc print data=both;
var Date AAPL_Open MSFT_Open;
run;
ods rtf close;
