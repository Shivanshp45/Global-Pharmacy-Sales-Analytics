-- =========================================================
-- Phase 1 - Data Validation.sql (MySQL 8.0)
-- Dataset: Global Pharmacy Sales Analytics
-- =========================================================

USE pharma_sales;

-- 1. Total Records
SELECT COUNT(*) AS total_records FROM pharmacy_sales;

-- 2. Date Range
SELECT MIN(date) AS start_date, MAX(date) AS end_date
FROM pharmacy_sales;

-- 3. NULL Count by Important Columns
SELECT
SUM(date IS NULL) date_nulls,
SUM(region IS NULL) region_nulls,
SUM(country IS NULL) country_nulls,
SUM(category IS NULL) category_nulls,
SUM(medicine IS NULL) medicine_nulls,
SUM(units_sold IS NULL) units_nulls,
SUM(unit_price IS NULL) price_nulls
FROM pharmacy_sales;

-- 4. Duplicate Records
SELECT date,country,medicine,age_group,COUNT(*) cnt
FROM pharmacy_sales
GROUP BY date,country,medicine,age_group
HAVING COUNT(*)>1;

-- 5. Invalid Units Sold
SELECT * FROM pharmacy_sales WHERE units_sold<=0;

-- 6. Invalid Unit Price
SELECT * FROM pharmacy_sales WHERE unit_price<=0;

-- 7. Invalid Stock
SELECT * FROM pharmacy_sales WHERE stock_level<0;

-- 8. Invalid Expiry Days
SELECT * FROM pharmacy_sales WHERE expiry_days_remaining<0;

-- 9. Invalid COVID Flag
SELECT DISTINCT covid_flag FROM pharmacy_sales;

-- 10. Distinct Regions
SELECT DISTINCT region FROM pharmacy_sales;

-- 11. Distinct Countries
SELECT DISTINCT country FROM pharmacy_sales;

-- 12. Distinct Categories
SELECT DISTINCT category FROM pharmacy_sales;

-- 13. Distinct Medicines
SELECT DISTINCT medicine FROM pharmacy_sales;

-- 14. Distinct Age Groups
SELECT DISTINCT age_group FROM pharmacy_sales;

-- 15. Year Distribution
SELECT year,COUNT(*) records
FROM pharmacy_sales
GROUP BY year
ORDER BY year;

-- 16. Month Distribution
SELECT month,COUNT(*) records
FROM pharmacy_sales
GROUP BY month
ORDER BY month;

-- 17. Revenue Validation
SELECT SUM(units_sold*unit_price) total_revenue
FROM pharmacy_sales;

-- 18. Top Stock
SELECT MAX(stock_level) max_stock,
MIN(stock_level) min_stock
FROM pharmacy_sales;

-- 19. Expiry Summary
SELECT MIN(expiry_days_remaining),MAX(expiry_days_remaining)
FROM pharmacy_sales;

-- 20. Summary Statistics
SELECT
AVG(units_sold) avg_units,
AVG(unit_price) avg_price,
AVG(stock_level) avg_stock
FROM pharmacy_sales;
