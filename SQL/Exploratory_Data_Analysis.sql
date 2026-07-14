-- =========================================================
-- Phase 2 - Exploratory Data Analysis.sql (MySQL 8.0)
-- =========================================================

USE pharma_sales;

-- Revenue
SELECT SUM(units_sold*unit_price) total_revenue FROM pharmacy_sales;

-- Revenue by Region
SELECT region,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY region
ORDER BY revenue DESC;

-- Revenue by Country
SELECT country,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY country
ORDER BY revenue DESC;

-- Revenue by Category
SELECT category,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY category
ORDER BY revenue DESC;

-- Revenue by Medicine
SELECT medicine,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY medicine
ORDER BY revenue DESC;

-- Revenue by Age Group
SELECT age_group,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY age_group;

-- Revenue by COVID Flag
SELECT covid_flag,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY covid_flag;

-- Monthly Revenue
SELECT year,month,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY year,month
ORDER BY year,month;

-- Yearly Revenue
SELECT year,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY year;

-- Top 10 Medicines
SELECT medicine,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY medicine
ORDER BY revenue DESC
LIMIT 10;

-- Bottom 10 Medicines
SELECT medicine,SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY medicine
ORDER BY revenue
LIMIT 10;

-- Top Countries by Units
SELECT country,SUM(units_sold) units
FROM pharmacy_sales
GROUP BY country
ORDER BY units DESC;

-- Average Price by Category
SELECT category,AVG(unit_price) avg_price
FROM pharmacy_sales
GROUP BY category;

-- Average Stock by Category
SELECT category,AVG(stock_level) avg_stock
FROM pharmacy_sales
GROUP BY category;

-- Average Expiry by Category
SELECT category,AVG(expiry_days_remaining) avg_expiry
FROM pharmacy_sales
GROUP BY category;

-- Revenue Contribution
SELECT category,
ROUND(SUM(units_sold*unit_price)/
(SELECT SUM(units_sold*unit_price) FROM pharmacy_sales)*100,2) contribution_pct
FROM pharmacy_sales
GROUP BY category;
