libname path "C:\Users\akmishra\Downloads"; 

%let var=ni seq ebit at dltt pi sale cogs invt rect act lct che; 


data comp;
set path.funda;
if fyear<=2013 and fyear>=2003 then output;
run;

data comp1;
set comp(keep=gvkey datadate fyear indfmt consol popsrc datafmt tic cusip conm acctstd &var);
if datafmt="STD" then output;
run;

data comp_dal;
set comp1;
if tic="DAL" then output;
run;

data comp_ual;
set comp1;
if tic="UAL" then output;
run;

data comp_alk;
set comp1;
if tic="ALK" then output;
run;

data comp_aal;
set comp1;
if tic="AAL" then output;
run;

%macro cal(dataset);
     data &dataset(keep=fyear ROE ROA ROC Tax_burden Interest_burden Profit_margin Total_assetturnover Leverage_ratio Fixed_assetturnover
                        Inventory_turn Days_receive current_ratio quick_ratio cash_ratio);
	 set &dataset;
     lag_seq = lag1(seq);
     lag_at=lag1(at);
     lag_invt=lag1(invt);
     lag_rect=lag1(rect);
     ROE=2*ni/(lag_seq+seq);
	 ROA=2*ebit/(lag_at+at);
     ROC=ebit/(dltt+seq);
     Tax_burden=ni/pi;
     Interest_burden=pi/ebit;
     Profit_margin=ebit/sale;
     Total_assetturnover=sale/at;
     Leverage_ratio=at/seq;
******************asset utilization**********************;
     Fixed_assetturnover=2*sale/(at+lag_at);
     Inventory_turn=2*cogs/(invt+lag_invt);
     Days_receive=(rect+lag_rect)/sale*365;
     current_ratio=act/lct;
     quick_ratio=(che+rect)/lct;
     cash_ratio=che/lct;
     if fyear=2003 then delete;
     array missing _numeric_;
     do over missing;
        if missing= . then delete;
     end;
	 run;
%mend;

%cal(comp_aal);
%cal(comp_dal);
%cal(comp_ual);
%cal(comp_alk);

%macro renameVars(dataset , company);
data &dataset;
set &dataset;
	rename ROE=&company._roe ROA=&company._roa ROC=&company._roc tax_burden=&company._tax_burden Interest_burden=&company._Interest_burden
			Profit_margin=&company._Profit_margin Total_assetturnover=&company._Total_assetturnover
			Leverage_ratio=&company._Leverage_ratio Fixed_assetturnover=&company._Fixed_assetturnover
       		Inventory_turn=&company._Inventory_turn Days_receive=&company._Days_receive current_ratio=&company._current_ratio
       		quick_ratio=&company._quick_ratio cash_ratio=&company._cash_ratio ;
     run;
%mend;

%renameVars(comp_aal, aal);
%renameVars(comp_dal, dal);
%renameVars(comp_ual, ual);
%renameVars(comp_alk, alk);



%macro findStat(dataset);

data &dataset;
set &dataset;
run;

proc means data=&dataset n mean std min max;
class fyear;
run;
%mend;

%findStat(comp_aal);
%findStat(comp_dal);
%findStat(comp_ual);
%findStat(comp_alk);
data Plot;
merge Comp_dal Comp_ual Comp_alk Comp_aal;
by fyear;
run;

ods pdf file = "C:\Users\akmishra\Downloads\Weagley.pdf"; 

%macro plotgraph(stats);
proc gplot data=plot;
  symbol i=join v=none;
  plot (dal_&stats ual_&stats alk_&stats aal_&stats)*fyear/overlay
                 autovref
				 LAUTOVREF=2 CAUTOVREF=BLACK WAUTOVREF=1 ;  
  title1 &stats." Comparision"; 
  footnote1 "Source: Compustat";
run;
quit;
%mend;
