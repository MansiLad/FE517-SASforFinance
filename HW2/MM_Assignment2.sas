data djia_missing_prior djia_remaining;
  set djia;
  by date;
  if djia = . and date < '01JAN2022'd then output djia_missing_prior;
  else output djia_remaining;
run;
