/******************************************************************************
* Project:      SAS Statistical Modeling Portfolio - Script 1
* Title:        Data Manipulation, Missing Value Imputation & Array Operations
* Dataset:      SASHELP.CARS (Built-in automotive specifications dataset)
* Author:       Okelana Ireoluwa Inumidun
******************************************************************************/

/* 1. Inspect raw structure and missing values */
PROC MEANS DATA=SASHELP.CARS N NMISS MEAN STD MIN MAX;
    VAR MSRP Invoice EngineSize Cylinders Horsepower MPG_City MPG_Highway Weight;
    TITLE "Summary Statistics & Missing Value Check - Raw SASHELP.CARS";
RUN;
/* 2. Data Cleaning, Feature Engineering & Array Processing */
DATA work.cars_clean;
    SET SASHELP.CARS;

    /* Remove records missing core predictor (Cylinders) */
    IF MISSING(Cylinders) THEN DELETE;

    /* Create derived metric: Average Fuel Efficiency and Price Markup */
    MPG_Combined = MEAN(MPG_City, MPG_Highway);
    Dealer_Markup = MSRP - Invoice;

    /* Categorize vehicle price tier using conditional logic */
    LENGTH Price_Tier $12;
    IF MSRP < 25000 THEN Price_Tier = "Economy";
    ELSE IF 25000 <= MSRP < 45000 THEN Price_Tier = "Mid-Range";
    ELSE Price_Tier = "Luxury";

    /* Use a SAS ARRAY to flag outliers (> 3 SD above mean) or standardize metrics */
    ARRAY num_vars[4] EngineSize Horsepower Weight MPG_Combined;
    ARRAY log_vars[4] Log_Engine Log_HP Log_Weight Log_MPG;

    DO i = 1 TO DIM(num_vars);
        /* Apply natural log transformation for skewness reduction */
        IF num_vars[i] > 0 THEN log_vars[i] = LOG(num_vars[i]);
        ELSE log_vars[i] = .;
    END;

    DROP i;
RUN;

/* 3. Verify cleaned dataset across Price Tiers */
PROC FREQ DATA=work.cars_clean;
    TABLES Origin * Price_Tier / NOCOL NOPERCENT;
    TITLE "Vehicle Distribution by Origin and Price Tier";
RUN;

PROC PRINT DATA=work.cars_clean (OBS=10);
    VAR Make Model Price_Tier MSRP Dealer_Markup MPG_Combined Log_HP;
    TITLE "Sample of Cleaned & Array-Transformed Dataset";
RUN;
