-- =========================================================
-- Phase 3 - Advanced SQL.sql (MySQL 8.0)
-- =========================================================

USE pharma_sales;

-- Revenue Ranking by Country
SELECT country,
SUM(units_sold*unit_price) revenue,
RANK() OVER(ORDER BY SUM(units_sold*unit_price) DESC) revenue_rank
FROM pharmacy_sales
GROUP BY country;

-- Dense Rank Categories
SELECT category,
SUM(units_sold*unit_price) revenue,
DENSE_RANK() OVER(ORDER BY SUM(units_sold*unit_price) DESC) rnk
FROM pharmacy_sales
GROUP BY category;

-- Monthly Running Revenue
WITH monthly AS(
SELECT year,month,
SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY year,month
)
SELECT *,
SUM(revenue) OVER(ORDER BY year,month) running_revenue
FROM monthly;

-- Previous Month Revenue
WITH monthly AS(
SELECT year,month,
SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY year,month
)
SELECT *,
LAG(revenue) OVER(ORDER BY year,month) previous_revenue
FROM monthly;

-- Moving Average Revenue
WITH monthly AS(
SELECT year,month,
SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY year,month
)
SELECT *,
AVG(revenue) OVER(
ORDER BY year,month
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) moving_avg
FROM monthly;

-- Top Medicine in Each Category
WITH ranked AS(
SELECT category,
medicine,
SUM(units_sold*unit_price) revenue,
ROW_NUMBER() OVER(
PARTITION BY category
ORDER BY SUM(units_sold*unit_price) DESC
) rn
FROM pharmacy_sales
GROUP BY category,medicine
)
SELECT * FROM ranked
WHERE rn=1;

-- Pareto Analysis
SELECT category,
SUM(units_sold*unit_price) revenue,
SUM(SUM(units_sold*unit_price))
OVER(ORDER BY SUM(units_sold*unit_price) DESC) cumulative_revenue
FROM pharmacy_sales
GROUP BY category;

-- Inventory Risk Ranking
SELECT medicine,
AVG(stock_level) avg_stock,
RANK() OVER(ORDER BY AVG(stock_level)) risk_rank
FROM pharmacy_sales
GROUP BY medicine;

-- NTILE Revenue Segmentation
WITH c AS(
SELECT country,
SUM(units_sold*unit_price) revenue
FROM pharmacy_sales
GROUP BY country
)
SELECT *,
NTILE(4) OVER(ORDER BY revenue DESC) revenue_quartile
FROM c;
