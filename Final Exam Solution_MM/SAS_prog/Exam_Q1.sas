/*
Question 1 - Complete
*/

PROC IMPORT OUT= WORK.GDPC1_data 
            DATAFILE= "O:\FE517\SAS_rawdata\GDPC1.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data gdpc_filter;
  set gdpc1_data;
  by date;
  if date >= "01JAN2016"d and date <= "31DEC2020"d then output gdpc_filter;
run;




