proc import out=stoneridge datafile="/home/u63974606/sasuser.v94/Stoneridge/Stoneridge Stock price Prediction Dataset.xlsx"
dbms=xlsx replace;
run;

data stoneridge;
    set stoneridge;
    rename 'Monthly Close'n = Monthly_Close;
run;

proc sgplot data=stoneridge;
	series x=date y=Monthly_Close;
	title "Stoneridge Time Series Plot from 1997 to 2024";
run;

proc timeseries data=stoneridge plots=acf out=_null_;
	var Monthly_Close;
	corr acf/nlag=60;
run;

*Holt's;

data stoneridge;
	set stoneridge;
	t=_n_;
	Monthly_Close1=Monthly_Close;
	if t>260 then Monthly_Close1=.;
run;

proc esm data=stoneridge lead=12 outfor=stoneridgeout1 out=_null_ print=all;
	forecast Monthly_Close1/model=linear;
run;

data stoneridgeout2;
	merge stoneridge stoneridgeout1;
	keep t Monthly_Close actual predict error;
run;

proc sgplot data=stoneridgeout2;
	series x=t y=Monthly_Close;
	series x=t y=predict;
	title "Actual vs Predicted Graph";
run;

data stoneridgeout2;
	set stoneridgeout2;
	if t<=260 then
		do;
			mape_fit = abs(error)/ Monthly_Close * 100;
        	mae_fit = abs(error);
        	mse_fit = (error)**2;
		end;
	else if t>260 then
		do;
			mape_acc = abs(Monthly_Close - Predict)/ Monthly_Close * 100;
        	mae_acc = abs(Monthly_Close - Predict);
        	mse_acc = (Monthly_Close - Predict)**2;
		end;
run;

proc means data=stoneridgeout2 n mean maxdec=3;
	var mape_fit mae_fit mse_fit mape_acc mae_acc mse_acc;
run;


*Non-Linear Regression;

data stoneridge;
	set stoneridge;
	t=_n_;
	t2=t*t;
run;

proc reg data=stoneridge;
	model monthly_close1=t t2;
	output out=non_linear_out2 p=nl_predict r=nl_resid;
run;

proc sgplot data=non_linear_out2;
	series x=date y=monthly_close;
	series x=date y=nl_predict;
	title "Stoneridge's Actual vs Predicted";
run;

data non_linear_out2;
	set non_linear_out2;
	if t<=260 then
		do;
			mape_fit = abs(nl_resid)/ Monthly_Close * 100;
        	mae_fit = abs(nl_resid);
        	mse_fit = (nl_resid)**2;
		end;
	else if t>260 then
		do;
			mape_acc = abs(Monthly_Close-nl_predict)/ Monthly_Close * 100;
        	mae_acc = abs(Monthly_Close-nl_predict);
        	mse_acc = (Monthly_Close-nl_predict)**2;
		end;
run;

proc means data=non_linear_out2 mean maxdec=3;
	var mape_fit mae_fit mse_fit mape_acc mae_acc mse_acc;
run;



*Arima Model;

data stoneridgeout2;
	set stoneridgeout2;
	Monthly_Close_dif=dif(Monthly_Close);
run;

proc timeseries data=stoneridgeout2 plots=(acf pacf) out=_null_;
	var Monthly_Close_dif;
run;

proc arima data=stoneridgeout2;
	identify var=Monthly_Close_dif nlag=36 whitenoise=ignoremiss;
	estimate p=12 q=12 whitenoise=ignoremiss;
	forecast id=t interval=month lead=60 out=arimaout;
run;

data arimaout1;
	merge arimaout stoneridge stoneridgeout2;
	keep date t Predict Monthly_Close forecast residual;
run;

proc sgplot data=arimaout1;
	series x=date y=Monthly_close;
	series x=date y=Predict;
	title "Actual VS Predicted using ARIMA";
run;

data arimaout1;
	set arimaout1;
	if t<=260 then
		do;
			mape_fit = abs(residual)/ Monthly_Close * 100;
        	mae_fit = abs(residual);
        	mse_fit = (residual)**2;
		end;
	else if t>260 then
		do;
			mape_acc = abs(residual)/ Monthly_Close * 100;
        	mae_acc = abs(residual);
        	mse_acc = (residual)**2;
		end;
run;

proc means data=arimaout1 n mean maxdec=3;
	var mape_fit mape_acc mse_fit mae_fit mae_acc mse_acc;
run;


















