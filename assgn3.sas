 libname path "C:\Users\amishra49\Downloads\Assign-3\";


data path.data_table1 (keep=Cash_Flow1 Cash_Flow2 Capital_Exp Cash_Flow_perShare1 Cash_Flow_perShare2 Cash_Flow_perShare3 Eq_in_Earnings_per_Sh) ;
set path.funda;
Cash_Flow1=IBC + DPC + TXDC + ESUBC + XIDOC + MII;
Cash_Flow2=(IBC +DPC + TXDC +ESUBC +XIDOC)/(CSHPRI * AJEX);
Capital_Exp=CAPX/(CSHPRI * AJEX);
Cash_Flow_perShare1=(IBC +DPC)/(CSHPRI * AJEX);
Cash_Flow_perShare2=(IBC + DPC + TXDC + ESUBC +XIDOC + MII)/(CSHPRI *AJEX);
Cash_Flow_perShare3=(IBC + DPC + TXDC + ESUBC + XIDOC)/(CSHPRI * AJEX);
Eq_in_Earnings_per_Sh=ESUBC/(CSHPRI * AJEX);
run;

data path.data_table2 (keep= Cash_Flow Pref_Div_Cov Tax_Rate Cash_Flow1 Dep_and_Amort Discont_Op EarningsperShare X EPS_1 EPS_2 EquityinEarnings Items1 ItemsandDiscontOp InterestExp  LaborandRelatedCosts NonopInc OpIncAfterDep OpIncBeforeDep1 OpIncBeforeDep2 PensionExp  PretaxInc  ResDevExp Sales);
set path.funda;
Cash_Flow=IB + DP;
Pref_Div_Cov=IB/DVP;
Tax_Rate=(TXT/PI) * 100;
Cash_Flow1=(IB + DP)/(CSHPRI * AJEX);
Dep_and_Amort=DP/(CSHPRI * AJEX);
Discont_Op=DO/(CSHPRI * AJEX);
EarningsperShare=	EPSFX/AJEX;
X=EPSFI/AJEX;
EPS_1=	EPSPX/AJEX;
EPS_2=	EPSPI/AJEX;
EquityinEarnings=	ESUB/(CSHPRI * AJEX);
Items1=	XI/(CSHPRI * AJEX);
ItemsandDiscontOp=	XIDO/(CSHPRI * AJEX);
InterestExp=	XINT/(CSHPRI * AJEX);
LaborandRelatedCosts=	XLR/(CSHPRI * AJEX);
NonopInc=	NOPI/(CSHPRI * AJEX);
OpIncAfterDep=	OIADP/(CSHPRI * AJEX);
OpIncBeforeDep1=	OIBDP/(CSHPRI * AJEX);
OpIncBeforeDep2=	(SALE-COGS-XSGA)/(CSHPRI * AJEX);
PensionExp=	XPR/(CSHPRI * AJEX);
PretaxInc=	PI/(CSHPRI * AJEX);
ResDevExp=	XRD/(CSHPRI * AJEX);
Sales=SALE/(CSHPRI * AJEX);
run;
data path.data_table3 (keep=AdvtExp CostofGoodsSold DepandAmort IntExp LaborandRelatedExp  NonopInc PensionRetirementExp RentalExp RandDExp SGAExp CashFlowMargin1 CashFlowMargin2 CashFlowMargin3 CashFlowMargin4 NetProfitMargin OpMAfterDepreciation  OpMBeforeDepreciation PretaxProfitMargin);
set path.funda;
AdvtExp=(XAD/SALE) * 100;
CostofGoodsSold=(COGS/SALE) * 100;
DepandAmort=(DP/SALE) * 100;
IntExp=(XINT/SALE) * 100;
LaborandRelatedExp=(XLR/SALE) * 100;
NonopInc=(NOPI/SALE) * 100;
PensionRetirementExp=(XPR/SALE) * 100;
RentalExp=(XRD/SALE) * 100;
RandDExp=(XSGA/SALE) * 100;
SGAExp=(XSGA/SALE) * 100;
CashFlowMargin1=((IBC + DPC)/SALE) * 100;
CashFlowMargin2=((IBC + DPC + TXDC + ESUBC+ XIDOC + MII)/SALE) * 100;
CashFlowMargin3=((IBC + DPC + TXDC + ESUBC+ XIDOC)/SALE) * 100;
CashFlowMargin4=((IB + DP)/SALE) * 100;
NetProfitMargin=(IB/SALE) * 100;
OpMAfterDepreciation=((OIBDP- DP)/SALE) * 100 or (OAIDP/SALE) * 100;
OpMBeforeDepreciation=(OIBDP/SALE) * 100;
PretaxProfitMargin=(PI/SALE) * 100;
run;

data path.data_table4 (keep=GrossAsst	InvCap	NetOpAsst	StckholdersEq	TotDebt	TotEarningAsst	WorkingCap	CapExp	CommEqu_Tangible	CommEq_LiquidatingVal	CommEq_Tot	GrossAssets	NetOpAsst	Prop_PlantandEquip_T	TotNetAsst	Work_Cap);
set path.funda;
GrossAsst=AT + DPACT;
InvCap=ICAPT;
NetOpAsst=PPENT + ACT-LCT;
StckholdersEq=PSTKL + CEQT;
TotDebt=DLTT + DLC;
TotEarningAsst=PPENT + ACT;
WorkingCap=ACT-LCT;
CapExp=CAPXV/(CSHO * AJEX);
CommEqu_Tangible=CEQT/(CSHO * AJEX);
CommEq_LiquidatingVal=CEQL/(CSHO * AJEX);
CommEq_Tot=CEQ/(CSHO * AJEX);
GrossAssets=(AT + DPACT)/(CSHO * AJEX);
NetOpAsst=(PPENT + ACT-LCT)/(CSHO *AJEX);
Prop_PlantandEquip_T=PPENT/(CSHO * AJEX);
TotNetAsst=AT/(CSHO * AJEX);
Work_Cap=(ACT-LCT)/(CSHO * AJEX);
run;


data path.data_table5 (keep=RetEarnings BegofYear EndofYear OtherChanges) ;
set path.funda;
RetEarnings=REUNA + ACOMINC + SEQO;
BegofYear=lag1(RE);
EndofYear=RE;
OtherChanges=RE-lag1(RE)-REA-IBC-XIDOC + DV;
run;


data path.data_table6 (keep=AccountsReceivableTurnover	AccountsReceivables	CshandShort_TermInv	Inventories	InventoryTurnover	No_ofDays_Sales	Sales_perCash	Sales_per_CommEq	Tangible	Liquidating_Val	Sales_per_Invest_Cap);
set path.funda;
AccountsReceivableTurnover=SALE/((RECT + lag1(RECT))/2);
AccountsReceivables=(RECT/SALE) * 100;
CshandShort_TermInv=(CHE/SALE) * 100;
Inventories=(INVT/SALE) * 100;
InventoryTurnover=COGS/((INVT + lag1(INVT))/2);
No_ofDays_Sales=((INVT + lag1(INVT))/2)/(COGS/365);
Sales_perCash=SALE/CHE;
Sales_per_CommEq=SALE/CEQ;
Tangible=SALE/CEQT;
Liquidating_Val=SALE/CEQL;
Sales_per_Invest_Cap=SALE/ICAPT;
run;

data path.data_table7 (keep=_ItemasbyAvgLong_TermDebt	_ItembyAvgTotalDebt	_ItembyCurrAssets1	_ItembyCurrAssets2	_ItembyCurrAssets3	_ItembyCurrAssets4	_ItembyIntangibles	_ItembyTotAsst1	_ItembyTotAsst2	_ItembyTotAsst3	_ItembyTotAsst4	_ItembyTotAsst5	_ItembyTotAsst6	_ItembyTotAsst7	_ItembyTotAsst8	_ItembyTotAsst9	_ItembyTotDebt	_ItembyTotLiab	_ItembyTotLiab1	_ItembyTotLiab2	_ItembyTotLiab3	_ItembyTotLiab4	_ItembyTotLiab5	_ItembyTotLiab6	_ItembyTotLiab7	_ItembyTotLiabandSE	_ItembyTotLiabandSE2	Cap_Exp_Cov	CurrentRatio	Debt_Eq_Ratios1	Debt_Eq_Ratios2	Debt_Eq_Ratios3	Debt_Eq_Ratios4	Debt_Eq_Ratios5	Debt_Eq_Ratios6	Debt_Eq_Ratios7	Debt_Eq_Ratios8	Int_Cov1	Int_Cov2	Int_Cov3);
set path.funda;
_ItemasbyAvgLong_TermDebt=(XINT/((DLTT + lag1(DLTT))/2)) * 100;
_ItembyAvgTotalDebt=XINT/((DLTT + lag1(DLTT)+ DLC + lag1(DLC)/2)) *100;
_ItembyCurrAssets1=(CHE/ACT) * 100;
_ItembyCurrAssets2=(ACO/ACT) * 100;
_ItembyCurrAssets3=(INVT/ACT) * 100;
_ItembyCurrAssets4=(RECT/ACT) * 100;
_ItembyIntangibles=(GDWL/INTAN) * 100;
_ItembyTotAsst1=(AO/AT) * 100;
_ItembyTotAsst2=(ACT/AT) * 100;
_ItembyTotAsst3=(GDWL/AT) * 100;
_ItembyTotAsst4=(INTAN/AT) * 100;
_ItembyTotAsst5=((IVAEQ + IVAO)/AT) * 100;
_ItembyTotAsst6=(IVAEQ/AT) * 100;
_ItembyTotAsst7=(PPEGT/AT) * 100;
_ItembyTotAsst8=(PPENT/AT) * 100;
_ItembyTotAsst9=((DLTT + DLC)/AT) * 100;
_ItembyTotDebt=(DLC/(DLTT + DLC)) * 100;
_ItembyTotLiab=(LCT/LT) * 100;
_ItembyTotLiab1=(TXDITC/LT) * 100;
_ItembyTotLiab2=(XINT/LT) * 100;
_ItembyTotLiab3=(LO/LT) * 100;
_ItembyTotLiab4=(DLTT/LT) * 100;
_ItembyTotLiab5=(MIB/LT) * 100;
_ItembyTotLiab6=(PSTK/LT) * 100;
_ItembyTotLiab7=(PSTKL/LT) * 100;
_ItembyTotLiabandSE=(CEQ/AT) * 100;
_ItembyTotLiabandSE2=(SEQ/AT) * 100;
Cap_Exp_Cov=(DP + IBADJ-DVC)/CSHO;
CurrentRatio=ACT/LCT;
Debt_Eq_Ratios1=DLTT/CEQ;
Debt_Eq_Ratios2=DLTT/CEQT;
Debt_Eq_Ratios3=DLTT/SEQ;
Debt_Eq_Ratios4=DLTT/(PSTKL + CEQT);
Debt_Eq_Ratios5=LT/CEQ;
Debt_Eq_Ratios6=LT/CEQT;
Debt_Eq_Ratios7=LT/SEQ;
Debt_Eq_Ratios8=LT/(PSTKL + CEQT);
Int_Cov1=(XINT + IB)/XINT;
Int_Cov2=(XINT +PI)/XINT;
Int_Cov3=(CHE + RECT)/LCT;
run;

data path.data_table8 (keep=Item_Csh_Flow1 Item_Csh_Flow2 Item_Csh_Flow3 Item_Inc_Before_Items Item_PPT1 Item_PPT2 Item_PPT3);
set path.funda;
Item_Csh_Flow1=(DV/(IBC + DPC)) * 100;
Item_Csh_Flow2=(DV/(IBC + DPC + TXDC +ESUBC + XIDOC + MII)) * 100;
Item_Csh_Flow3=(DV/(IBC + XIDOC + DPC +TXDC + ESUBC)) * 100;
Item_Inc_Before_Items=(DV/IBADJ) * 100;
Item_PPT1=(DP/PPEGT) * 100;
Item_PPT2=(PPENT/PPEGT) * 100;
Item_PPT3=(DP/PPENT) * 100;
run;


data path.data_table9 (keep=Comm_Sh_Adj Comm_Sh_Earning_Basic_Adj Comm_Sh_Earning_Dil_Adj TreasuryStock_Comm_Sh);
set path.funda;
Comm_Sh_Adj=CSHO * AJEX;
Comm_Sh_Earning_Basic_Adj=CSHPRI * AJEX;
Comm_Sh_Earning_Dil_Adj=CSHFD * AJEX;
TreasuryStock_Comm_Sh=TSTKN * AJEX;
run;


data path.data_table10 (keep=DividendPayoutRatio);
set path.funda;
DividendPayoutRatio=DVC/IBADJ;
run;

ods pdf file = "C:\Users\amishra49\Downloads\Assign-3\OutputAssgn3.pdf";

proc means data=path.data_table1 N mean median std min max; 
var Cash_Flow1 Cash_Flow2 Capital_Exp Cash_Flow_perShare1 Cash_Flow_perShare2 Cash_Flow_perShare3 Eq_in_Earnings_per_Sh;
Title "Changes in financial position";
run;

PROC CORR data=path.data_table1 nosimple;
TITLE "Correlation table1";
run;

proc means data=path.data_table2 N mean median std min max; 
var Cash_Flow Pref_Div_Cov Tax_Rate Cash_Flow1 Dep_and_Amort Discont_Op EarningsperShare X EPS_1 EPS_2 EquityinEarnings Items1 ItemsandDiscontOp InterestExp LaborandRelatedCosts NonopInc OpIncAfterDep OpIncBeforeDep1 OpIncBeforeDep2 PensionExp PretaxInc ResDevExp Sales;
Title "Income Statement";
run;

PROC CORR data=path.data_table2 nosimple;
TITLE "Correlation-table2";
run;


proc means data=path.data_table3 N mean median std min max; 
var AdvtExp CostofGoodsSold DepandAmort IntExp LaborandRelatedExp NonopInc PensionRetirementExp RentalExp RandDExp SGAExp CashFlowMargin1 CashFlowMargin2 CashFlowMargin3 CashFlowMargin4 NetProfitMargin OpMAfterDepreciation OpMBeforeDepreciation PretaxProfitMargin;
Title "Operating_Margins";
run;

PROC CORR data=path.data_table3 nosimple;
TITLE "Correlation-table3";
run;


proc means data=path.data_table4 N mean median std min max; 
var GrossAsst InvCap NetOpAsst StckholdersEq TotDebt TotEarningAsst WorkingCap CapExp CommEqu_Tangible CommEq_LiquidatingVal CommEq_Tot GrossAssets NetOpAsst Prop_PlantandEquip_T TotNetAsst Work_Cap;
Title "Balance Sheet";
run;

PROC CORR data=path.data_table4 nosimple;
TITLE "Correlation-table4";
run;

proc means data=path.data_table5 N mean median std min max; 
var RetEarnings BegofYear EndofYear OtherChanges;
Title "Retained Earnings Statement";
run;

PROC CORR data=path.data_table5 nosimple;
TITLE "Correlation-table5";
run;

proc means data=path.data_table6 N mean median std min max; 
var AccountsReceivableTurnover AccountsReceivables CshandShort_TermInv Inventories InventoryTurnover No_ofDays_Sales Sales_perCash Sales_per_CommEq Tangible Liquidating_Val Sales_per_Invest_Cap;
TITLE "TurnoverRatios";
run;
PROC CORR data=path.data_table6 nosimple;
TITLE "Correlation-table6";
run;


proc means data=path.data_table7 N mean median std min max; 
var _ItemasbyAvgLong_TermDebt _ItembyAvgTotalDebt _ItembyCurrAssets1 _ItembyCurrAssets2 _ItembyCurrAssets3 _ItembyCurrAssets4 _ItembyIntangibles _ItembyTotAsst1 _ItembyTotAsst2 _ItembyTotAsst3 _ItembyTotAsst4 _ItembyTotAsst5 _ItembyTotAsst6 _ItembyTotAsst7 _ItembyTotAsst8 _ItembyTotAsst9 _ItembyTotDebt _ItembyTotLiab _ItembyTotLiab1 _ItembyTotLiab2 _ItembyTotLiab3 _ItembyTotLiab4 _ItembyTotLiab5 _ItembyTotLiab6 _ItembyTotLiab7 _ItembyTotLiabandSE _ItembyTotLiabandSE2 Cap_Exp_Cov CurrentRatio Debt_Eq_Ratios1 Debt_Eq_Ratios2 Debt_Eq_Ratios3 Debt_Eq_Ratios4 Debt_Eq_Ratios5 Debt_Eq_Ratios6 Debt_Eq_Ratios7 Debt_Eq_Ratios8 Int_Cov1 Int_Cov2 Int_Cov3;
Title "Criteria of financial soundness";
run;


PROC CORR data=path.data_table7 nosimple;
TITLE "Correlation-table7";
run;

proc means data=path.data_table8 N mean median std min max; 
var Item_Csh_Flow1 Item_Csh_Flow2 Item_Csh_Flow3 Item_Inc_Before_Items Item_PPT1 Item_PPT2 Item_PPT3;
Title "Management Decision";
run;
PROC CORR data=path.data_table8 nosimple;
TITLE "Correlation-table8";
run;

proc means data=path.data_table9 N mean median std min max; 
var Comm_Sh_Adj Comm_Sh_Earning_Basic_Adj Comm_Sh_Earning_Dil_Adj TreasuryStock_Comm_Sh;
Title "Price and Market Data";
run;

PROC CORR data=path.data_table9 nosimple;
TITLE "Correlation-table9";
run;

proc means data=path.data_table10 N mean median std min max; 
var DividendPayoutRatio;
Title "Price Ratios";
run;

PROC CORR data=path.data_table10 nosimple;
TITLE "Correlation-table10";
run;

ods pdf close;
