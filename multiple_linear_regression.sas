/******************************************************************************
* Project:      SAS Statistical Modeling Portfolio - Script 2
* Title:        Multiple Linear Regression & Residual Diagnostics
* Dataset:      work.cars_clean (Generated from Script 1)
* Author:       Okelana Ireoluwa Inumidun
******************************************************************************/

/* 1. Correlation Matrix to check linear relationships with MSRP */
PROC CORR DATA=work.cars_clean NOSIMPLE;
    VAR MSRP EngineSize Cylinders Horsepower Weight MPG_Combined;
    TITLE "Pearson Correlation Matrix - Vehicle Price Predictors";
RUN;

/* 2. Fit Multiple Linear Regression Model with Multicollinearity Check (VIF) */
ODS GRAPHICS ON;

PROC REG DATA=work.cars_clean PLOTS(MAXPOINTS=NONE)=(DIAGNOSTICS RESIDUALS);
    Model_1: MODEL MSRP = Horsepower EngineSize Weight MPG_Combined / VIF STB;
    TITLE "Multiple Linear Regression Predicting Vehicle MSRP";
RUN;
QUIT;

/* 3. Refined Parsimonious Model (Dropping non-significant/collinear predictors) */
PROC REG DATA=work.cars_clean;
    Model_Refined: MODEL MSRP = Horsepower Weight MPG_Combined / VIF STB;
    OUTPUT OUT=work.reg_predictions P=Predicted_MSRP R=Residual_MSRP;
    TITLE "Refined Regression Model & Residual Output";
RUN;
QUIT;

ODS GRAPHICS OFF;

/* 4. Inspect Actual vs. Predicted Values */
PROC PRINT DATA=work.reg_predictions (OBS=10);
    VAR Make Model MSRP Predicted_MSRP Residual_MSRP;
    FORMAT MSRP Predicted_MSRP Residual_MSRP DOLLAR10.2;
    TITLE "Actual vs. Predicted MSRP (First 10 Observations)";
RUN;