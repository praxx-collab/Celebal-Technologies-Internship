-- Assignment 2 
-- Name : Prachurya Nanda
-- Dataset : Sample Superstore 
-- Database : MySQL

USE superstore_db;

-- SECTION 1 : DATA EXPLORATION 

-- Query 1 : Display first 10 records 
SELECT *
FROM superstore
LIMIT 10;

-- Query 2 : Count total records 
SELECT COUNT(*) AS Total_Records
FROM superstore;

-- Query 3 : Display table structure 
DESCRIBE superstore;

-- Query 4 : Count unique categories,regions and segments 
SELECT COUNT(DISTINCT Category) AS Total_Categories, COUNT(DISTINCT Region) AS Total_Regions, COUNT(DISTINCT Segment) AS Total_Segments
FROM superstore;

-- SECTION 2 : FILTERING 

-- Query 5 : Orders from the West region
SELECT *
FROM superstore
WHERE Region = 'West';

-- Query 6: Furniture category orders
SELECT *
FROM superstore
WHERE Category = 'Furniture';

-- Query 7: Orders with Sales greater than 500
SELECT *
FROM superstore
WHERE Sales > 500;

-- Query 8: Orders with negative profit
SELECT *
FROM superstore
WHERE Profit < 0;

SELECT `Order Date`
FROM superstore
LIMIT 10;

-- Query 9: Orders placed in the year 2016
SELECT *
FROM superstore
WHERE YEAR(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) = 2016;

-- SECTION 3 : AGGREGATION

-- Query 10: Total Sales by Region
SELECT Region, ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Query 11: Total Quantity Sold by Category
SELECT Category, SUM(Quantity) AS Total_Quantity
FROM superstore
GROUP BY Category
ORDER BY Total_Quantity DESC;

-- Query 12: Average Sales by Segment
SELECT Segment, ROUND(AVG(Sales),2) AS Average_Sales
FROM superstore
GROUP BY Segment
ORDER BY Average_Sales DESC;

-- SECTION 4 : SORTING AND LIMITS 

-- Query 13: Top 10 Products by Sales 
SELECT `Product Name`, ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- Query 14 : Top 5 Customers by Sales 
SELECT `Customer Name`, ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 5;

-- Query 15 : Top Categories by Sales 
SELECT Category, ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

-- SECTION 5 : BUSINESS USE CASES 

-- Query 16 : Top 10 States by Sales
SELECT State, ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;

-- Query 17 : Top 10 Customers by Sales 
SELECT `Customer Name`, ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- Query 18: Check Duplicate Order IDs
SELECT `Order ID`, COUNT(*) AS Frequency
FROM superstore
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

-- SECTION 6 : DATA VALIDATION 

-- Query 19: Verify Total Rows
SELECT COUNT(*) AS Total_Rows
FROM superstore;

-- Query 20: Check for NULL Sales
SELECT COUNT(*) AS Null_Sales
FROM superstore
WHERE Sales IS NULL;

-- Query 21: Check for NULL Profit
SELECT COUNT(*) AS Null_Profit
FROM superstore
WHERE Profit IS NULL;
