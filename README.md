# 📊 Stoneridge Stock Price Prediction: A Comparative Analysis of Forecasting Models

## 📝 Introduction
In today's volatile market, accurately predicting stock prices is essential for making informed investment decisions. Time series analysis provides powerful tools to identify trends and patterns in stock prices, aiding investors in making data-driven decisions.

Stoneridge, Inc., a leading manufacturer of electrical and electronic components for the automotive industry, has shown notable volatility in its stock price. In this project, we aim to forecast Stoneridge's stock price over the next 12 months using various time series forecasting models and determine the most accurate method.

## 🔍 Problem
Predicting stock prices is inherently complex due to the interplay of various factors, such as:
- Economic conditions
- Investor sentiment
- Company performance

While Stoneridge's stock price has fluctuated significantly over the past 30 years, understanding these historical patterns can help forecast future performance.

## 📊 Data
### Data Source
The dataset is sourced from Stoneridge's official investor relations website and includes 27 years of **daily stock price data** from **November 1997 to November 2024**. The variables include:
- **Date**
- **Open Price**
- **High Price**
- **Low Price**
- **Close Price**
- **Volume**

We focused on **monthly closing prices** to smooth out short-term volatility and align with the 12-month forecast goal.

### Data Cleaning & Transformation
- **No missing values** or **outliers** were found in the dataset.
- The daily closing prices were aggregated to monthly averages.
- The data was validated to ensure consistency and quality.

## 📈 Exploratory Data Analysis
The time series plot of Stoneridge's monthly closing prices reveals a **non-linear trend**, indicating significant fluctuations. Autocorrelation Function (ACF) analysis shows subtle hints of potential seasonality.

## 🛠️ Model Selection & Methodology
We compared three forecasting models to determine the best fit for Stoneridge's stock price prediction:
1. **Holt's Exponential Smoothing** - A linear trend model suited for data without seasonality.
2. **Non-linear Regression (Quadratic Regression)** - To capture more complex, non-linear patterns in the data.
3. **ARIMA (AutoRegressive Integrated Moving Average)** - A time series model designed to handle autocorrelation and temporal dependencies.

## 🧑‍💻 Modeling Process
### 1. Holt’s Exponential Smoothing
- **Training Data**: 260 observations (80% training, 20% testing).
- **Performance Metrics**:  
  - **R-Square**: 0.933  
  - **MAPE (Test)**: 45.76% (Significant drop during forecast period)

While Holt’s Exponential Smoothing performed well in capturing the trend, its forecasted results exhibited a large error during testing, indicating the model's difficulty in generalizing.

### 2. Non-linear Regression (Quadratic)
- **Model Parameters**:  
  - **Intercept**: 19.79  
  - **Time Coefficients**: -0.19555 (downward) and 0.00082075 (slight upward curvature).
- **Performance Metrics**:  
  - **MAPE (Training)**: 31.8%  
  - **MAPE (Test)**: 72.3% (Overestimated values in test data)

While the non-linear model captured the complex patterns in the stock price, it struggled with generalizing, as indicated by the high error metrics on the test data.

### 3. ARIMA Model
- **ACF & PACF**: Identified significant lags at 1, 12, and 15 for AR and MA terms.
- **Performance Metrics**:  
  - **MAPE (Training)**: 9.46%  
  - **MAPE (Test)**: 45.76% (Overestimation on test data)

ARIMA performed well on the training data but struggled with overfitting, as shown by the high error on the test data.

## 📉 Model Comparison & Evaluation
After evaluating each model's forecasting accuracy over the 12-month horizon, we compared:
- **Holt’s Exponential Smoothing**: Struggled to generalize for the test period.
- **Non-linear Regression**: Overestimated values with a high MAPE during testing.
- **ARIMA**: Provided good training results but also overestimated during forecasting.

### Final Evaluation
ARIMA and Holt’s Exponential Smoothing performed well on the training set but did not generalize well on unseen data. Non-linear regression was able to capture some of the non-linear patterns, but its performance on the test set was poor due to overestimation.

## 🧑‍🔬 Conclusion
Based on the results, **ARIMA** showed the most potential for future predictions despite its overfitting on test data. However, improvements could be made to address its shortcomings, such as exploring hybrid models or tuning parameters further.

## 🛠️ Getting Started
To run the models and replicate this analysis, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/stoneridge-stock-price-prediction.git
