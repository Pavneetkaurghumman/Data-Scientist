create database pizza_file;

use pizza_file;

CREATE TABLE pizza_sales (
    pizza_id INT PRIMARY KEY,
    order_id INT,
    pizza_name_id VARCHAR(255),
    quantity INT,
    order_date varchar(255),
    order_time Varchar(255),
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    pizza_size VARCHAR(255),
    pizza_category VARCHAR(500),
    pizza_ingredients varchar(500),
    pizza_name VARCHAR(500)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pizza_sales_excel_file.csv"
into table pizza_sales
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
;



CREATE TABLE pizza_sales_clean (
    pizza_id INT PRIMARY KEY,
    order_id INT,
    pizza_name_id VARCHAR(100),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);

INSERT INTO pizza_sales_clean
SELECT
    pizza_id,
    order_id,
    pizza_name_id,
    quantity,
    STR_TO_DATE(order_date, '%d-%m-%Y') AS order_date,
    CAST(order_time AS TIME),
    unit_price,
    total_price,
    pizza_size,
    pizza_category,
    pizza_ingredients,
    pizza_name
FROM pizza_sales;


alter table pizza_sales
modify column total_price int,
modify column unit_price int;

describe pizza_sales;

-- Q1. Find Total Revenue
SELECT 
    round(sum(total_price),2) AS 'total_revenue'
FROM
    pizza_sales
;

-- Q2. Find Total Orders
-- Write an SQL query to count total unique orders.

SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

-- Q3. Find Total Pizzas Sold
-- Calculate the total quantity of pizzas sold.

SELECT 
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;


-- Q4. Average Order Value
-- Find the average amount spent per order.

select avg(total_price)
from pizza_sales;

-- Q5. Average Pizzas Per Order
-- Find how many pizzas customers order on average.

select Avg(quantity)
from pizza_sales;

-- Intermediate Level Questions

-- Q6. Daily Trend Analysis
-- Find total orders for each day of the week.
-- Expected Insight
-- Identify busiest weekdays and weekends.

SELECT 
    DAYNAME(order_date) AS day_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales_clean
GROUP BY day_name
ORDER BY total_orders DESC;


-- Q7. Monthly Sales Trend
-- Find total orders month-wise.
-- Expected Insight
-- Identify peak sales months.

SELECT 
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales_clean
GROUP BY month_name
ORDER BY total_orders DESC;


-- Q8. Sales Percentage by Pizza Category
-- Calculate percentage contribution of each pizza category toward total revenue.

SELECT 
    pizza_category,
    round(sum(total_price),2) AS revenue,
    ROUND(SUM(total_price) * 100 /
        (SELECT SUM(total_price) FROM pizza_sales), 2) AS revenue_percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY revenue DESC;


-- Q9. Sales Percentage by Pizza Size
-- Find which pizza size contributes most to sales revenue.

SELECT 
    pizza_size,
    ROUND(SUM(total_price), 2) AS revenue,
    ROUND(SUM(total_price) * 100 /
        (SELECT SUM(total_price) FROM pizza_sales), 2) AS revenue_percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY revenue DESC;


-- Q10. Category-wise Pizza Sales
-- Find total pizzas sold for each category in February.

SELECT 
    pizza_category,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales_clean
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC;

-- Advanced Level Questions
-- Q11. Top 5 Pizzas by Revenue
-- Find top 5 pizzas generating highest revenue.

SELECT 
    pizza_name,
    ROUND(SUM(total_price), 2) AS revenue
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY revenue DESC
LIMIT 5;




-- Q12. Bottom 5 Pizzas by Revenue
-- Find lowest revenue generating pizzas.

SELECT 
    pizza_name,
    ROUND(SUM(total_price), 2) AS revenue
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY revenue ASC
LIMIT 5;

-- Q13. Top 5 Pizzas by Quantity Sold
-- Find most sold pizzas based on quantity.

SELECT 
    pizza_name,
    SUM(quantity) AS total_quantity
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 5;

-- Q14. Bottom 5 Pizzas by Quantity Sold
-- Find least sold pizzas.

SELECT 
    pizza_name,
    SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity ASC
LIMIT 5;

-- Q15. Top 5 Pizzas by Total Orders
-- Find pizzas ordered most frequently.

SELECT 
    pizza_name,
    count( Distinct order_id) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity desc
LIMIT 5;

-- Q16. Bottom 5 Pizzas by Total Orders
-- Find least frequently ordered pizzas.

SELECT 
    pizza_name,
    count( Distinct order_id) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity ASC
LIMIT 5;




