-- ==========================================================
-- Celebal Technologies Internship
-- Assignment 03
-- Topic: Subqueries, CTEs & Window Functions
-- Name: Prachurya Nanda
-- ==========================================================

-- ==========================================================
-- STEP 1: SETUP DATA
-- ==========================================================
CREATE DATABASE superstore_week3;
USE superstore_week3;

CREATE TABLE customers AS
SELECT DISTINCT `Customer ID`, `Customer Name`, Segment, Country, City, State, Region
FROM superstore;

SELECT *
FROM customers
LIMIT 5;

CREATE TABLE orders AS
SELECT DISTINCT `Order ID`,`Order Date`,`Ship Date`,`Ship Mode`,`Customer ID`,`Product ID`,
Sales, Quantity, Discount, Profit
FROM superstore;

SELECT *
FROM orders
LIMIT 5;

CREATE TABLE products AS
SELECT DISTINCT `Product ID`, Category,`Sub-Category`,`Product Name`
FROM superstore;

SELECT *
FROM products
LIMIT 5;


# QUESTION 1
# Find all orders where Sales are greater than the average Sales (Subquery)
-- ==========================================================

SELECT `Order ID`,`Customer ID`, Sales
FROM orders
WHERE Sales >
(
    SELECT AVG(Sales)
    FROM orders
);

SELECT AVG(Sales) AS Average_Sales
FROM orders;

# QUESTION 2
# Find the highest sales order for each customer (Correlated Subquery)
-- ==========================================================

SELECT o.`Order ID`, o.`Customer ID`, o.Sales
FROM orders o
JOIN
(
    SELECT
        `Customer ID`,
        MAX(Sales) AS Highest_Sales
    FROM orders
    GROUP BY `Customer ID`
) m
ON o.`Customer ID` = m.`Customer ID`
AND o.Sales = m.Highest_Sales;

# QUESTION 3
# Calculate Total Sales for Each Customer (CTE)
-- ==========================================================

WITH CustomerSales AS
(
    SELECT `Customer ID`, ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY `Customer ID`
)

SELECT *
FROM CustomerSales;

# QUESTION 4
# Find Customers Whose Total Sales Are Above Average (CTE + Subquery)
-- ==========================================================

WITH CustomerSales AS
(
    SELECT
        `Customer ID`,
        ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY `Customer ID`
)

SELECT *
FROM CustomerSales
WHERE Total_Sales >
(
    SELECT AVG(Total_Sales)
    FROM CustomerSales
);

# QUESTION 5
# Rank Customers Based on Total Sales (Window Function)
-- ==========================================================

WITH CustomerSales AS
(
    SELECT `Customer ID`, ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY `Customer ID`
)

SELECT
    `Customer ID`,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Customer_Rank
FROM CustomerSales;

# QUESTION 6
# Assign Row Numbers to Each Order Within a Customer (Window Function + PARTITION BY)
-- ==========================================================

SELECT `Customer ID`,`Order ID`,`Order Date`, Sales,
    ROW_NUMBER() OVER
    (
        PARTITION BY `Customer ID`
        ORDER BY `Order Date`
    ) AS Order_Number
FROM orders;

# QUESTION 7
# Display Top 3 Customers Based on Total Sales (Window Function)
-- ==========================================================

WITH CustomerSales AS
(
    SELECT `Customer ID`, ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY `Customer ID`
),

CustomerRanking AS
(
    SELECT `Customer ID`, Total_Sales,
        RANK() OVER (ORDER BY Total_Sales DESC) AS Customer_Rank
    FROM CustomerSales
)

SELECT *
FROM CustomerRanking
WHERE Customer_Rank <= 3;

# FINAL COMBINED QUERY
# Customer Name, Total Sales and Rank Using JOIN + CTE + Window Function
-- ==========================================================

WITH CustomerSales AS
(
    SELECT `Customer ID`, ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY `Customer ID`
)

SELECT c.`Customer Name`, cs.Total_Sales,
    RANK() OVER (ORDER BY cs.Total_Sales DESC) AS Customer_Rank
FROM CustomerSales cs
JOIN customers c
ON cs.`Customer ID` = c.`Customer ID`
ORDER BY Customer_Rank;

-- ==========================================================
-- MINI PROJECT
-- ==========================================================

-- BUSINESS QUESTION 1
-- Identify the Top 5 Customers based on Total Sales.
-- ==========================================================

SELECT `Customer ID`,`Customer Name`, ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY `Customer ID`, `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 5;

-- BUSINESS QUESTION 2
-- Identify the Bottom 5 Customers based on Total Sales
-- ==========================================================

SELECT `Customer ID`, `Customer Name`, ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY `Customer ID`, `Customer Name`
ORDER BY Total_Sales ASC
LIMIT 5;

-- BUSINESS QUESTION 3
-- Identify Customers Who Placed Only One Order
-- ==========================================================

SELECT `Customer ID`,`Customer Name`, COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM superstore
GROUP BY `Customer ID`, `Customer Name`
HAVING COUNT(DISTINCT `Order ID`) = 1;

-- BUSINESS QUESTION 4
-- Customers with Above Average Total Sales
-- ==========================================================

WITH CustomerSales AS
(
    SELECT `Customer ID`,`Customer Name`, ROUND(SUM(Sales), 2) AS Total_Sales
    FROM superstore
    GROUP BY `Customer ID`, `Customer Name`
)

SELECT *
FROM CustomerSales
WHERE Total_Sales >
(
    SELECT AVG(Total_Sales)
    FROM CustomerSales
)
ORDER BY Total_Sales DESC;

-- BUSINESS QUESTION 5
-- Highest Order Value for Each Customer
-- ==========================================================

SELECT `Customer ID`,`Customer Name`,ROUND(MAX(Sales), 2) AS Highest_Order_Value
FROM superstore
GROUP BY `Customer ID`, `Customer Name`
ORDER BY Highest_Order_Value DESC;

-- ==========================================================
-- END OF ASSIGNMENT
-- ==========================================================