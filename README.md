# WalmartSalesAnalysis

# About
This project aims to analyze Walmart Sales data, sourced from the Kaggle Walmart Sales dataset, with the goal of gaining insights into various aspects. The primary objectives include identifying top-performing branches, analyzing sales trends for different products, and understanding customer behavior. The ultimate aim is to leverage these insights to improve and optimize sales strategies, contributing to enhanced overall performance. Through a comprehensive exploration of the dataset, the project seeks to uncover valuable patterns and information that can inform strategic decision-making.

# Purpose 
The project seeks to uncover patterns, trends, and correlations within the sales data, providing a comprehensive understanding of the factors that contribute to variations in sales performance across different branches

# About Data
The Dataset was obtained from Kaggle. The dataset has sales transactions from three different branches of Walmart, located in Mandalay, Yangon and Naypyitaw. The data has 17 columns and 1000 rows:
| Column | Datatype | Description |
| ------ | -------- | ----------- |
| invoice_id | VARCHAR(30) | Invoice of the sales made |
| branch | VARCHAR(10) | branch at which sales are made |
| city | VARCHAR(20) | location of the branch |
| customer_type | VARCHAR(20) | type of the customer |
| gender | VARCHAR(10) | gender of the customer |
| product_line | VARCHAR(50) | product line of the product |
| unit_price | float | price of each product |
| quantity | int | quantity of product sold |
| tax | float | amount of tax on purchase |
| total | float | total cost of purchase |
| date | datetime | date on which the purchase was made |
| time | time | time at which purchase was made |
| payment | VARCHAR(50) | total amount paid |
| cogs | float | cost of goods sold |
| gross_margin_percent | float | gross margin percent |
| gross_income | float | gross income |
| rating | float | ratings by customer |

# Analysis made on dataset

1. Product Analysis
   The analysis of the Walmart sales data will focus on unraveling insights into the different product lines. By examining the performance metrics, we aim to identify the top-performing product lines and discern     areas where improvement is needed.
   
2. Sales Analysis
   This analysis is focused on unraveling the sales trends of products, aiming to provide insights that enable the assessment of the effectiveness of different sales strategies employed by the business. By       
   understanding these trends, the goal is to evaluate the performance of each sales strategy and identify necessary modifications for enhancing sales outcomes.

3. Customer Analysis
   The objective of this analysis is to unveil distinct customer segments, delineate purchase trends within these segments, and assess the profitability associated with each customer group.

# Approach

1. Data Wrangling: It is a first step to inspect data with NULL values and missing values.
   - Build a Database
   - Created table *WalmartSales* and inserted the data
   - Set *NOT NULL* for each column, hence null values filtered out

2. Feature Engineering: To generate some new columns out of existing ones.
   - *time_of_day* => Add new column time_of_day to give insights of sales made during Morning, Afternoon, Evening
   - *day_name* => Add new column day_name to find the day(Mon, Tue, Wed, Thur, Fri) of the week on which the transaction took place
   - *month_name* => Add new column month_name to find the name of the month(Jan, Feb, Mar) on which given transaction took place
  
3. Exploratory Data Analysis(EDA): EDA is performed to answer questions aimed to get insights from the dataset

# Questions answered 
## Generic Questions
1. What are unique cities does the data have?
2. In which city is each branch in the data?

## Product Analysis Questions
1. What are the unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the highest COGS?
6. What product line has the highest revenue?
7. Which city has the highest revenue?
8. Which product line has the highest tax?
9. Which branch sold more products than average product sold?
10. What is the most common product line by gender?
11. What is the average rating of each product line?

## Sales Analysis Questions
1. What is the number of sales made during 'Morning', 'Afternoon', 'Evening' during weekend?
2. Which customer type causes most revenue?
3. Which city has the highest tax percent?
4. Which customer type pays the most in tax?

## Customer Analysis Questions
1. How many unique customer type does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Who buys the most - male/female?
5. What is the gender distribution per branch - A/B/C?
6. Which time of day do customers give the highest ratings?
7. At what day time, do customers give highest ratings per branch?
8. Which day of the week has the best average ratings?
9. Which day of the week has the best average ratings per branch?

## Revenue And Profit Calculation
1. COGS = unit_price * quantity
2. tax = 5% of COGS
3. total_gross_sales = tax + cogs
4. gross_profit = (tax + cogs) - cogs

# Code
Find code here [WalmartSales](https://github.com/sadhanadby/WalmartSalesAnalysis/blob/main/WalmartSales.sql)
