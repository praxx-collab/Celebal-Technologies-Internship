CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

SELECT DATABASE();

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    join_date DATE NOT NULL,
    is_premium BOOLEAN DEFAULT FALSE
);

SHOW TABLES;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    stock_qty INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending' CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    total_amount DECIMAL(12,2) NOT NULL CHECK (total_amount >= 0),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    discount_pct DECIMAL(5,2) DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100),
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

SHOW TABLES;

INSERT INTO customers VALUES
(101, 'Aarav', 'Sharma', 'aarav.s@email.com', 'Mumbai', 'Maharashtra', '2024-01-15', 1),
(102, 'Priya', 'Patel', 'priya.p@email.com', 'Ahmedabad', 'Gujarat', '2024-02-20', 0),
(103, 'Rohan', 'Gupta', 'rohan.g@email.com', 'Delhi', 'Delhi', '2024-03-10', 1),
(104, 'Sneha', 'Reddy', 'sneha.r@email.com', 'Hyderabad', 'Telangana', '2024-04-05', 0),
(105, 'Vikram', 'Singh', 'vikram.s@email.com', 'Jaipur', 'Rajasthan', '2024-05-12', 1),
(106, 'Ananya', 'Iyer', 'ananya.i@email.com', 'Chennai', 'Tamil Nadu', '2024-06-18', 0),
(107, 'Karan', 'Mehta', 'karan.m@email.com', 'Pune', 'Maharashtra', '2024-07-22', 1),
(108, 'Divya', 'Nair', 'divya.n@email.com', 'Kochi', 'Kerala', '2024-08-30', 0);

INSERT INTO products VALUES
(201, 'Wireless Earbuds', 'Electronics', 'BoAt', 1499.00, 250),
(202, 'Cotton T-Shirt', 'Clothing', 'Levi''s', 799.00, 500),
(203, 'Smart Watch', 'Electronics', 'Noise', 2999.00, 150),
(204, 'Running Shoes', 'Clothing', 'Nike', 4599.00, 120),
(205, 'Bluetooth Speaker', 'Electronics', 'JBL', 3499.00, 200),
(206, 'Bedsheet Set', 'Home', 'Spaces', 1299.00, 300),
(207, 'Laptop Stand', 'Electronics', 'AmazonBasics', 899.00, 180),
(208, 'Cushion Covers (Set)', 'Home', 'HomeCenter', 599.00, 400);

INSERT INTO orders VALUES
(1001, 101, '2024-08-01', 'Delivered', 4498.00),
(1002, 102, '2024-08-03', 'Delivered', 799.00),
(1003, 103, '2024-08-05', 'Shipped', 7498.00),
(1004, 101, '2024-08-10', 'Delivered', 3499.00),
(1005, 104, '2024-08-12', 'Cancelled', 2999.00),
(1006, 105, '2024-08-15', 'Delivered', 5898.00),
(1007, 106, '2024-08-18', 'Pending', 1299.00),
(1008, 103, '2024-08-20', 'Delivered', 899.00),
(1009, 107, '2024-08-25', 'Shipped', 6098.00),
(1010, 108, '2024-08-28', 'Delivered', 1598.00);

INSERT INTO order_items VALUES
(5001, 1001, 201, 2, 1499.00, 0),
(5002, 1001, 207, 1, 899.00, 10),
(5003, 1002, 202, 1, 799.00, 0),
(5004, 1003, 203, 1, 2999.00, 0),
(5005, 1003, 204, 1, 4599.00, 5),
(5006, 1004, 205, 1, 3499.00, 0),
(5007, 1005, 203, 1, 2999.00, 0),
(5008, 1006, 201, 1, 1499.00, 10),
(5009, 1006, 204, 1, 4599.00, 5),
(5010, 1007, 206, 1, 1299.00, 0),
(5011, 1008, 207, 1, 899.00, 0),
(5012, 1009, 205, 1, 3499.00, 0),
(5013, 1009, 208, 2, 599.00, 15),
(5014, 1010, 206, 1, 1299.00, 0),
(5015, 1010, 208, 1, 599.00, 0);

SELECT COUNT(*) AS Customers
FROM customers;

SELECT COUNT(*) AS Products
FROM products;

SELECT COUNT(*) AS Orders
FROM orders;

SELECT COUNT(*) AS Order_Items
FROM order_items;


-- Q1. Display all columns and rows from the customers table
-- ==========================================================

SELECT *
FROM customers;

-- Q2. Retrieve first_name, last_name and city of customers
-- ==========================================================

SELECT first_name, last_name, city
FROM customers;

-- Q3. List all unique product categories
-- ==========================================================

SELECT DISTINCT category
FROM products;

-- Q4. Identify the Primary Key of each table
-- ==========================================================

/*
Primary Keys

customers      -> customer_id
products       -> product_id
orders         -> order_id
order_items    -> item_id

Explanation:
A Primary Key uniquely identifies each record in a table.
It must be UNIQUE and NOT NULL because every row should have one unique identifier.
*/

-- Q5. Constraints applied to the email column
-- ==========================================================

/*
Constraints:
1. NOT NULL
2. UNIQUE

Explanation:
NOT NULL ensures every customer has an email address.

UNIQUE ensures duplicate email addresses cannot be inserted.

If a duplicate email is inserted, MySQL returns a 'Duplicate entry' error due to the UNIQUE constraint.
*/

-- Q6. Test CHECK Constraint on unit_price
-- ==========================================================

/*
Explanation:
The following INSERT statement attempts to insert a product with a negative unit price.
Since the products table has the constraint:

CHECK (unit_price > 0)

MySQL rejects the insertion and returns an error.
*/
INSERT INTO products
VALUES
(
209,'Test Product',
'Electronics','TestBrand',
-50,100
);

/*
Expected Output:
The INSERT statement fails because the CHECK constraint does not allow unit_price values less than or equal to zero.
*/

-- Q7. Retrieve all orders with status = 'Delivered'
-- ==========================================================

SELECT *
FROM orders
WHERE status = 'Delivered';

-- Q8. Electronics products with unit_price greater than ₹2000
-- ==========================================================

SELECT *
FROM products
WHERE category = 'Electronics'
AND unit_price > 2000;

-- Q9. Customers who joined in 2024 and belong to Maharashtra
-- ==========================================================

SELECT *
FROM customers
WHERE state = 'Maharashtra'
AND YEAR(join_date) = 2024;

-- Q10. Orders between 2024-08-10 and 2024-08-25 excluding cancelled orders
-- ==========================================================

SELECT *
FROM orders
WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25'
AND status <> 'Cancelled';

-- Q11. Purpose of idx_orders_date
-- ==========================================================
/*
Explanation:
The idx_orders_date index speeds up queries that filter,search, or sort records based on the order_date column.
Instead of scanning the entire table, MySQL uses the index to locate matching rows efficiently.

Example Query:
*/
SELECT *
FROM orders
WHERE order_date = '2024-08-15';

-- Q12. SARGable Query
-- ==========================================================
/*
Explanation:

Query:
SELECT * FROM customers
WHERE YEAR(join_date)=2024;
is NOT SARGable because the YEAR() function is applied to the indexed column.

Index-Friendly Query:
*/
SELECT *
FROM customers
WHERE join_date BETWEEN '2024-01-01'
AND '2024-12-31';

-- Q13. Count total number of orders in the order table.
-- ==========================================================

SELECT COUNT(*) AS Total_Orders
FROM orders;

-- Q14. Total revenue from all Delivered orders.
-- ==========================================================

SELECT ROUND(SUM(total_amount),2) AS Total_Revenue
FROM orders
WHERE status = 'Delivered';

-- Q15. Average unit price in each category.
-- ==========================================================

SELECT category, ROUND(AVG(unit_price),2) AS Average_Unit_Price
FROM products
GROUP BY category;

-- Q16. Count of orders and total revenue by status
-- ==========================================================

SELECT status, COUNT(*) AS Order_Count, ROUND(SUM(total_amount),2) AS Total_Revenue
FROM orders
GROUP BY status
ORDER BY Total_Revenue DESC;

-- Q17.  Most expensive and cheapest product in each category
-- ==========================================================

SELECT category,MAX(unit_price) AS Highest_Price, MIN(unit_price) AS Lowest_Price
FROM products
GROUP BY category;

-- Q18. Categories with average unit price greater than ₹2000
-- ==========================================================
SELECT category, ROUND(AVG(unit_price),2) AS Average_Unit_Price
FROM products
GROUP BY category
HAVING AVG(unit_price) > 2000;

-- Q19. Display each order with customer details
-- ==========================================================

SELECT o.order_id, o.order_date, c.first_name, c.last_name, o.total_amount
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

-- Q20. Display all customers and their orders
-- ==========================================================

SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- Q21. Orders with product details
-- ==========================================================

SELECT o.order_id, p.product_name, oi.quantity, oi.unit_price, oi.discount_pct
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id;

-- Q24. Classify products using CASE
-- ==========================================================
/*
Explanation:
This query classifies products into Budget,Mid-Range and Premium based on unit price.
*/
SELECT product_name, unit_price,
    CASE
        WHEN unit_price < 1000 THEN 'Budget'
        WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
        ELSE 'Premium'
    END AS price_tier
FROM products;

-- Q25. Count Delivered vs Not Delivered orders
-- ==========================================================
/*
Explanation:
This query uses CASE inside SUM() to count delivered and non-delivered orders.
*/
SELECT SUM(CASE WHEN status='Delivered' THEN 1 ELSE 0 END) AS Delivered,
        SUM(CASE WHEN status<>'Delivered' THEN 1 ELSE 0 END) AS Not_Delivered
FROM orders;

SELECT product_id, product_name
FROM products;

-- Q27. SQL Transaction (BEGIN...COMMIT/ROLLBACK)
-- ==========================================================

/*
Explanation:
This transaction performs the following operations atomically:
1. Inserts a new order.
2. Inserts two order items.
3. Updates the stock quantity of the purchased products.
4. Commits the transaction if all statements succeed.
   Otherwise, the transaction should be rolled back.
*/

START TRANSACTION;

-- Step 1: Insert a new order
INSERT INTO orders
(order_id, customer_id, order_date, status, total_amount)
VALUES
(1011, 102, CURDATE(), 'Pending', 1598.00);

-- Step 2: Insert two order items
INSERT INTO order_items
(item_id, order_id, product_id, quantity, unit_price, discount_pct)
VALUES
(16, 1011, 201, 1, 999.00, 0),
(17, 1011, 203, 1, 599.00, 0);

-- Step 3: Update product stock
UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id IN (201,203);

-- Step 4: Save the transaction
COMMIT;

-- If any statement fails before COMMIT,
-- execute:
-- ROLLBACK;