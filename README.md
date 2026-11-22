# SAS Statistical Modeling & Data Manipulation Portfolio

**Author:** Okelana Ireoluwa Inumidun (B.Sc. Statistics Candidate, LASUSTECH)  
**Tools:** Base SAS, SAS/STAT (`DATA` Step, `ARRAY`, `PROC MEANS`, `PROC FREQ`, `PROC CORR`, `PROC REG`)

## Overview
This repository demonstrates end-to-end statistical data preprocessing and linear modeling workflows in SAS using the built-in `SASHELP.CARS` dataset ($N = 428$ raw records; $N = 426$ complete observations after cleaning).

## Repository Contents
1. **`01_data_cleaning_and_arrays.sas`**
   * Evaluates missingness and summary distributions via `PROC MEANS`.
   * Engineers composite fuel efficiency (`MPG_Combined`), dealer markup, and categorical price tiers (`Economy`, `Mid-Range`, `Luxury`).
   * Implements **SAS Arrays with `DO` loops** to batch-apply natural logarithmic transformations across skewed continuous predictors.
2. **`02_multiple_linear_regression.sas`**
   * Screens bivariate linear relationships using `PROC CORR`.
   * Fits an Ordinary Least Squares (OLS) multiple regression model via `PROC REG` with Variance Inflation Factor (`VIF`) diagnostics to detect multicollinearity between engine displacement (`EngineSize`) and `Horsepower`.
   * Fits a refined parsimonious regression model and generates residual diagnostic plots and prediction comparisons.

## Key Statistical Findings
* **Model Fit:** Horsepower, vehicle weight, and combined fuel efficiency explain **71.31% of the variance** in retail vehicle price ($R^2 = 0.7131$, Adjusted $R^2 = 0.7110$, $F = 348.03$, $p < 0.0001$).
* **Primary Driver:** Horsepower exhibits the strongest positive standardized effect ($\beta$) on MSRP, while vehicle weight acts as a secondary positive predictor after removing collinearity with engine displacement.
