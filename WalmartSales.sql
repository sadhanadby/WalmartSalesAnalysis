-- Create Database
CREATE DATABASE IF NOT EXISTS WalmartSalesData;

-- Create Table
CREATE TABLE IF NOT EXISTS WalmartSales (
	invoice_id varchar(30) not null,
    branch varchar(10) not null,
    city varchar(20) not null,
    customer_type varchar (20) not null,
    gender varchar(10) not null,
    product_line varchar(50) not null,
    unit_price float not null,
    quantity int not null,
    tax float not null,
    total float not null,
    date datetime not null,
    time Time not null,
    payment varchar(50) not null,
    cogs float not null,
    gross_margin_percent float not null,
    gross_income float not null,
    rating float not null
);

-- Load csv data into database
LOAD DATA LOCAL INFILE 'WalmartSalesData.csv'
INTO TABLE WalmartSales
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- Select data from WalmartSales
Select*From WalmartSales;

-- Create columns to check time_of_day, day_name and month_name of the sales transaction
-- time_of_day
ALTER TABLE WalmartSales
ADD COLUMN time_of_day VARCHAR(10);

UPDATE WalmartSales
SET time_of_day = 
  CASE 
    WHEN CAST(SUBSTRING(time, 1, 2) AS UNSIGNED) < 12 THEN 'Morning'
    WHEN CAST(SUBSTRING(time, 1, 2) AS UNSIGNED) < 18 THEN 'Afternoon'
    ELSE 'Evening'
  END;

-- day_name
ALTER TABLE WalmartSales
ADD COLUMN day_name VARCHAR(10);	

UPDATE WalmartSales
SET day_name = dayname(date);

-- month_name
ALTER TABLE WalmartSales
ADD COLUMN month_name VARCHAR(10);	

UPDATE WalmartSales
SET month_name = monthname(date);


-- Generic Business questions

-- 1. What are unique cities does the data have?
SELECT DISTINCT (city) FROM WalmartSales;

-- 2. In which city is each branch in the data?
SELECT DISTINCT city, branch FROM WalmartSales;


-- PRODUCT ANALYSIS

-- 1. What are the unique product lines does the data have?
SELECT DISTINCT (product_line) FROM WalmartSales;

-- 2. What is the most common payment method?
SELECT 
	payment, 
    COUNT(payment) 	AS 'Count_Of_Payment'
FROM WalmartSales
GROUP BY payment
ORDER BY Count_Of_Payment DESC;

-- 3. What is the most selling product line?
SELECT 
	product_line, 
    COUNT(product_line) AS 'Count_Of_Product_Line'
FROM WalmartSales
GROUP BY product_line
ORDER BY Count_Of_Product_Line DESC;

-- 4. What is the total revenue by month?
SELECT
	month_name AS month,
    SUM(round( total )) AS 'total_revenue'
FROM WalmartSales 
GROUP BY month
ORDER BY total_revenue DESC;

-- 5. What month had the highest COGS?
SELECT 
	month_name AS month,
    SUM(round(cogs)) AS COGS
FROM WalmartSales
GROUP BY month_name
ORDER BY COGS DESC;

-- 6. What product line has the highest revenue?
SELECT 
	product_line,
    SUM(round(total)) AS 'total_revenue'
FROM WalmartSales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- 7. Which city has the highest revenue?
SELECT
	city,
    SUM(round(total)) AS 'revenue'
FROM WalmartSales
GROUP BY city
ORDER BY revenue DESC;

-- 8. Which product line has the highest tax?
SELECT 
	product_line,
    SUM(round(tax)) AS tax
FROM WalmartSales
GROUP BY product_line
ORDER BY tax DESC;

-- 9. Which branch sold more products than average product sold?
SELECT
	branch,
    SUM(quantity) as 'quantity'
FROM WalmartSales
GROUP BY branch
HAVING SUM(quantity) > (
	SELECT 
		AVG(quantity)
	FROM WalmartSales);
    
-- 10. What is the most common product line by gender?
SELECT 
	gender,
    product_line,
    COUNT(gender) as 'total_count'
FROM WalmartSales
GROUP BY gender, product_line
ORDER BY total_count DESC;

-- 11. What is the average rating of each product line?
SELECT 
	product_line,
    ROUND(AVG(rating), 2) AS avg_rating
FROM WalmartSales
GROUP BY product_line
ORDER BY avg_rating DESC;


-- SALES ANALYSIS

-- 1. What is the number of sales made during 'Morning', 'Afternoon', 'Evening' during weekend?
SELECT 
	time_of_day,
    count(*) as 'total_sales'
FROM WalmartSales
WHERE day_name = 'Sunday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- 2. Which customer type causes most revenue?
SELECT 
	customer_type,
    ROUND(SUM(total), 2) as 'total_revenue'
FROM WalmartSales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- 3. Which city has the highest tax percent?
SELECT
	city,
    AVG (tax) AS 'tax'
FROM WalmartSales
GROUP BY city
ORDER BY tax DESC;

-- 4. Which customer type pays the most in tax?
SELECT
	customer_type,
    AVG(tax) AS 'tax'
FROM WalmartSales
GROUP BY customer_type
ORDER BY tax DESC;


-- Customer Analysis

-- 1. How many unique customer type does the data have?
SELECT
	DISTINCT customer_type
FROM WalmartSales;

-- 2. How many unique payment methods does the data have?
SELECT 
	DISTINCT payment AS 'payment_method'
FROM WalmartSales;

-- 3. What is the most common customer type?
SELECT
	customer_type,
    count(*) as 'total_count'
FROM WalmartSales
GROUP BY customer_type
ORDER BY total_count DESC;

-- 4. Who buys the most - male/female?
SELECT
	gender,
    count(*) AS 'gender_count'
FROM WalmartSales
GROUP BY gender
ORDER BY gender_count DESC;

-- 5. What is the gender distribution per branch - A/B/C?
SELECT 
	branch,
	gender,
    count(gender) AS 'gender_count'
FROM WalmartSales
GROUP BY branch, gender
ORDER BY branch, gender_count;
    
-- 6. Which time of day do customers give the highest ratings?
SELECT 
	time_of_day,
    AVG(rating) AS 'avg_rating'
FROM WalmartSales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- 7. At what day time, do customers give highest ratings per branch?
SELECT
	time_of_day,
    branch,
    AVG(rating) as 'avg_rating'
FROM WalmartSales
GROUP BY time_of_day, branch
ORDER BY avg_rating DESC;

-- 8. Which day of the week has the best average ratings?
SELECT 
	day_name,
    AVG(rating) as 'avg_rating'
FROM WalmartSales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- 9. Which day of the week has the best average ratings per branch?
SELECT
	day_name,
    branch,
    AVG(rating) AS 'avg_rating'
FROM WalmartSales
GROUP BY day_name, branch
ORDER BY avg_rating DESC;


-- REVENUE AND PROFIT CALCULATIONS

-- Total Gross Sales
SELECT 
	SUM(tax + cogs) AS 'total_gross_sales'
FROM WalmartSales;

-- Gross Profit
SELECT 
	(SUM(ROUND(tax, 2) + cogs) - cogs) AS 'gross_profit'
FROM WalmartSales;
