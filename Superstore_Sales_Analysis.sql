## PROJECT: Superstore Sales Analysis
## TOOL: MySQL Workbench
## TABLE: superstore_sales_test
## DATASET SIZE: 145 records
## PURPOSE: Explore sales performance by category,
##         region, and sales-value band.
##NOTE: Results describe the 145 imported records,
##    not the full Power BI dataset.


USE superstore_practice;

##1. DATASET OVERVIEW
SELECT COUNT(*) AS total_records
FROM superstore_sales_test;

SELECT *
FROM superstore_sales_test
LIMIT 10;

SELECT
    `Order ID`,
    `Customer Name`,
    `Category`,
    `Sales`
FROM superstore_sales_test
LIMIT 10;

##2. OVERALL SALES METRICS
SELECT SUM(Sales) AS total_sales
FROM superstore_sales_test;

## 3. CATEGORY ANALYSIS
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore_sales_test
GROUP BY Category
ORDER BY total_sales DESC;

SELECT
    Category,
    COUNT(*) AS number_of_records
FROM superstore_sales_test
GROUP BY Category
ORDER BY number_of_records DESC;

SELECT
    Category,
    ROUND(AVG(Sales), 2) AS average_sales
FROM superstore_sales_test
GROUP BY Category
ORDER BY average_sales DESC;

SELECT
    MAX(Sales) AS highest_sale
FROM superstore_sales_test;

SELECT
    MIN(Sales) AS lowest_sale
FROM superstore_sales_test;

SELECT
    COUNT(DISTINCT `Customer ID`) AS total_customers
FROM superstore_sales_test;

SELECT
    `Product Name`,
    Category,
    Sales
FROM superstore_sales_test
ORDER BY Sales DESC
LIMIT 1;

## 4. FURNITURE SALES ANALYSIS
SELECT
    `Product Name`,
    Sales
FROM superstore_sales_test
WHERE Category = 'Furniture'
ORDER BY Sales DESC
LIMIT 5;

SELECT
    `Product Name`,
    Sales
FROM superstore_sales_test
WHERE Category = 'Furniture'
  AND Sales > 1000
ORDER BY Sales DESC;

SELECT
    COUNT(*) AS furniture_sales_over_1000
FROM superstore_sales_test
WHERE Category = 'Furniture'
  AND Sales > 1000;
  
  SELECT
    ROUND(SUM(Sales), 2) AS total_furniture_sales_over_1000
FROM superstore_sales_test
WHERE Category = 'Furniture'
  AND Sales > 1000;
  
  SELECT
    `Product Name`,
    Sales
FROM superstore_sales_test
WHERE Category = 'Furniture'
  AND Sales BETWEEN 500 AND 1000
ORDER BY Sales DESC;

SELECT
    COUNT(*) AS furniture_sales_between_500_1000
FROM superstore_sales_test
WHERE Category = 'Furniture'
  AND Sales BETWEEN 500 AND 1000;
  
  SELECT
    ROUND(SUM(Sales), 2) AS total_sales_between_500_1000
FROM superstore_sales_test
WHERE Category = 'Furniture'
  AND Sales BETWEEN 500 AND 1000;
  
  SELECT
    `Product Name`,
    Sales,
    CASE
        WHEN Sales < 500 THEN 'Low'
        WHEN Sales <= 1000 THEN 'Medium'
        ELSE 'High'
    END AS sales_band
FROM superstore_sales_test
WHERE Category = 'Furniture'
ORDER BY Sales DESC
LIMIT 10;

SELECT
    CASE
        WHEN Sales < 500 THEN 'Low'
        WHEN Sales <= 1000 THEN 'Medium'
        ELSE 'High'
    END AS sales_band,
    COUNT(*) AS number_of_records
FROM superstore_sales_test
WHERE Category = 'Furniture'
GROUP BY sales_band
ORDER BY number_of_records DESC;

SELECT
    CASE
        WHEN Sales < 500 THEN 'Low'
        WHEN Sales <= 1000 THEN 'Medium'
        ELSE 'High'
    END AS sales_band,
    COUNT(*) AS number_of_records,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM superstore_sales_test
         WHERE Category = 'Furniture'),
        2
    ) AS percentage
FROM superstore_sales_test
WHERE Category = 'Furniture'
GROUP BY sales_band
ORDER BY number_of_records DESC;

SELECT
    ROUND(SUM(Sales), 2) AS low_band_total_sales
FROM superstore_sales_test
WHERE Category = 'Furniture'
  AND Sales < 500;
  
  SELECT
    ROUND(
        SUM(CASE WHEN Sales < 500 THEN Sales ELSE 0 END) * 100.0
        / SUM(Sales),
        2
    ) AS low_band_revenue_percentage
FROM superstore_sales_test
WHERE Category = 'Furniture';

SELECT
    CASE
        WHEN Sales < 500 THEN 'Low'
        WHEN Sales <= 1000 THEN 'Medium'
        ELSE 'High'
    END AS sales_band,
    COUNT(*) AS number_of_records,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Sales) * 100.0 /
        (SELECT SUM(Sales)
         FROM superstore_sales_test
         WHERE Category = 'Furniture'), 2) AS revenue_percentage
FROM superstore_sales_test
WHERE Category = 'Furniture'
GROUP BY sales_band
ORDER BY revenue_percentage DESC;

## 5. REGIONAL SALES ANALYSIS
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore_sales_test
GROUP BY Region
ORDER BY total_sales DESC;

SELECT
    Region,
    COUNT(*) AS number_of_records
FROM superstore_sales_test
GROUP BY Region
ORDER BY number_of_records DESC;

SELECT
    Region,
    COUNT(*) AS number_of_records,
    ROUND(AVG(Sales), 2) AS average_sales
FROM superstore_sales_test
GROUP BY Region
ORDER BY average_sales DESC;

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore_sales_test
GROUP BY Region
HAVING SUM(Sales) > 5000
ORDER BY total_sales DESC;

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS furniture_sales
FROM superstore_sales_test
WHERE Category = 'Furniture'
GROUP BY Region
HAVING SUM(Sales) > 2000
ORDER BY furniture_sales DESC;

SELECT
    Region,
    COUNT(*) AS furniture_records
FROM superstore_sales_test
WHERE Category = 'Furniture'
GROUP BY Region
ORDER BY furniture_records DESC;

SELECT
    Region,
    COUNT(*) AS furniture_records,
    ROUND(AVG(Sales), 2) AS average_sales
FROM superstore_sales_test
WHERE Category = 'Furniture'
GROUP BY Region
ORDER BY average_sales DESC;

## 6. SALES BAND ANALYSIS

SELECT
    `Product Name`,
    Sales,
    CASE
        WHEN Sales < 250 THEN 'Small'
        WHEN Sales <= 750 THEN 'Medium'
        ELSE 'Large'
    END AS sales_band
FROM superstore_sales_test
WHERE Category = 'Furniture'
ORDER BY Sales DESC
LIMIT 10;

SELECT
    CASE
        WHEN Sales < 250 THEN 'Small'
        WHEN Sales <= 750 THEN 'Medium'
        ELSE 'Large'
    END AS sales_band,
    COUNT(*) AS number_of_records,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore_sales_test
WHERE Category = 'Furniture'
GROUP BY sales_band
ORDER BY total_sales DESC;

SELECT
    CASE
        WHEN Sales < 250 THEN 'Small'
        WHEN Sales <= 750 THEN 'Medium'
        ELSE 'Large'
    END AS sales_band,
    COUNT(*) AS number_of_records,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(
        SUM(Sales) * 100 /
        (SELECT SUM(Sales)
         FROM superstore_sales_test
         WHERE Category = 'Furniture'),
        2
    ) AS percentage_of_sales
FROM superstore_sales_test
WHERE Category = 'Furniture'
GROUP BY sales_band
ORDER BY percentage_of_sales DESC;

## 7. FINAL DATASET SUMMARY
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT `Order ID`) AS unique_orders,
    COUNT(DISTINCT `Customer ID`) AS unique_customers,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(AVG(Sales), 2) AS average_sales,
    ROUND(MAX(Sales), 2) AS highest_sale,
    ROUND(MIN(Sales), 2) AS lowest_sale
FROM superstore_sales_test;