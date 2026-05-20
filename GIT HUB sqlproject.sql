create database data_cleaning;

use data_cleaning;

CREATE TABLE retail_orders_dirty (
    row_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(20),
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    phone_number VARCHAR(30),
    gender VARCHAR(20),
    city VARCHAR(50),
    state_name VARCHAR(50),
    country VARCHAR(50),
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity VARCHAR(20),
    unit_price VARCHAR(20),
    total_amount VARCHAR(30),
    order_date VARCHAR(50),
    payment_method VARCHAR(50),
    order_status VARCHAR(50),
    discount VARCHAR(20),
    customer_age VARCHAR(20),
    pincode VARCHAR(20),
    remarks VARCHAR(255)
);


INSERT INTO retail_orders_dirty 
(order_id, customer_name, customer_email, phone_number, gender, city, state_name, country,
product_name, category, quantity, unit_price, total_amount, order_date,
payment_method, order_status, discount, customer_age, pincode, remarks)

VALUES

('ORD101','Naveen Singh','naveen@gmail.com','9876543210','Male','Delhi','Delhi','India',
'Laptop','Electronics','2','55000','110000','2025-01-15',
'UPI','Delivered','10','23','110001','Good customer'),

('ORD102','  Riya Sharma ','riya@gmail.com ','9999988888','Female','Mumbai','Maharashtra','India',
'Mobile','Electronics','1','30000','30000','15/01/2025',
'Cash','Delivered','5','21','400001',''),

('ORD103','Aman Verma','aman@gmail','8888877777','male','delhi','Delhi','India',
'Headphones','Electronics','2','2500','5000','01-16-2025',
'Card','Shipped','','19','110001','NULL'),

('ORD104','Priya Kapoor',NULL,'98765','Female','Bangalore','Karnataka','India',
'Shoes','Fashion','1','abc','5000','2025/01/18',
'UPI','Pending','0','Twenty Two','560001','Wrong price'),

('ORD105','Rahul Mehta','rahul@gmail.com','7777766666','M','Chennai','Tamil Nadu','India',
'T-shirt','Fashion','3','1000','3000','18 Jan 2025',
'COD','Delivered','2','25','600001',''),

('ORD105','Rahul Mehta','rahul@gmail.com','7777766666','M','Chennai','Tamil Nadu','India',
'T-shirt','Fashion','3','1000','3000','18 Jan 2025',
'COD','Delivered','2','25','600001','Duplicate Row'),

('ORD106','Sneha Joshi','sneha@gmail.com','6666655555','Female ','Pune','Maharashtra','India',
'Watch','Accessories','-1','4500','-4500','2025-01-20',
'Card','Returned','0','24','411001','Negative quantity'),

('ORD107','','kartik@gmail.com','5555544444','Male','Hyderabad','Telangana','India',
'Bag','Fashion','2','1500','3000','2025-13-01',
'UPI','Delivered','5','27','500001','Invalid date'),

('ORD108','Anjali Gupta','anjali@gmail.com','4444433333','FEMALE','Kolkata','West Bengal','India',
'Laptop','Electronics','1','58000','58000','2025-01-22',
'Crypto','Delivered','10','22','700001','Invalid payment'),

('ORD109','Vikas Sharma','vikas@gmail.com','3333322222','Male','Delhi ','Delhi','India',
'Tablet','Electronics','NULL','20000','40000','2025-01-23',
'Card','Shipped','','30','110001','Quantity missing'),

('ORD110','Neha Arora','neha@gmail.com','2222211111','Female','Mumbai','Maharashtra','India',
'Camera','Electronics','1','45000','45000','2025-01-24',
'UPI','delivered','5','26','400001','Lowercase status'),

('ORD111','Arjun Singh','arjun@gmail.com','1111100000','Male','Jaipur','Rajasthan','India',
'Speaker','Electronics','2','3500 ','7000 ','2025-01-25',
'Card','Delivered',' ','29','302001','Extra spaces'),

('ORD112','Pooja Malhotra','pooja@gmail.com','9999911111','Female','Delhi','Delhi','India',
'Mouse','Electronics','0','700','0','2025-01-26',
'UPI','Cancelled','0','23','110001','Zero quantity'),

('ORD113','Karan Patel','karan@gmail.com','8888811111','Male','Ahmedabad','Gujarat','India',
'Keyboard','Electronics','1','1500','1500','2025-01-27',
'Card','Delivered','105','31','380001','Invalid discount'),

('ORD114','Simran Kaur','simran@gmail.com','7777711111','Female','Chandigarh','Punjab','India',
'Monitor','Electronics','1','12000','12000','2025-01-28',
'UPI','Delivered','5','-5','160001','Negative age');

-- Display the complete dataset and inspect all columns manually.

SELECT * FROM retail_orders_dirty;

-- Count the total number of records in the dataset.
-- Expected Learning:
-- •	COUNT(*)

SELECT COUNT(*) AS total_records
FROM retail_orders_dirty;

-- Check the structure of the table.
-- Find:
-- •	Column names 
-- •	Data types 
-- •	Nullability 
-- Expected Learning:
-- •	DESC 

DESC retail_orders_dirty;

-- Identify columns that should not be stored as VARCHAR.
-- Examples:
-- •	quantity 
-- •	unit_price 
-- •	order_date 
-- •	customer_age 
-- Expected Learning:
-- •	Data type auditing 

-- | Column Name  | Current Type | Correct Type  | Reason                                              |
-- | ------------ | ------------ | ------------- | --------------------------------------------------- |
-- | quantity     | VARCHAR      | INT           | Stores quantity numbers                             |
-- | unit_price   | VARCHAR      | DECIMAL(10,2) | Stores price values                                 |
-- | total_amount | VARCHAR      | DECIMAL(10,2) | Stores calculated sales amount                      |
-- | order_date   | VARCHAR      | DATE          | Stores dates                                        |
-- | discount     | VARCHAR      | DECIMAL(5,2)  | Stores percentage/numeric values                    |
-- | customer_age | VARCHAR      | INT           | Stores age numbers                                  |
-- | pincode      | VARCHAR      | VARCHAR(10)   | Correct as VARCHAR because pincodes are identifiers |

ALTER TABLE retail_orders_dirty
MODIFY COLUMN quantity INT,
MODIFY COLUMN unit_price DECIMAL(10,2),
MODIFY COLUMN total_amount DECIMAL(10,2),
MODIFY COLUMN order_date DATE,
MODIFY COLUMN discount DECIMAL(5,2),
MODIFY COLUMN customer_age INT;

ALTER TABLE retail_orders_dirty
MODIFY COLUMN quantity INT;

-- Cleaning-- 
-- 1--
 
update retail_orders_dirty
set quantity =2
where quantity ="null";

ALTER TABLE retail_orders_dirty
modify Column quantity INT;

-- 2-- 

ALTER TABLE retail_orders_dirty
MODIFY COLUMN unit_price DECIMAL(10,2);

-- Cleaning--


update retail_orders_dirty
set unit_price = 25000
where unit_price = "abc";

ALTER TABLE retail_orders_dirty
MODIFY COLUMN unit_price DECIMAL(10,2);

-- 3

update retail_orders_dirty
set total_amount = 4500
where  total_amount = -4500;

ALTER TABLE retail_orders_dirty
MODIFY COLUMN total_amount int ;


-- 4

UPDATE retail_orders_dirty
SET customer_age = CASE
    WHEN customer_age = 'twenty two' THEN 22
    WHEN customer_age = -5 THEN 5
END
WHERE customer_age = 'twenty two'
   OR customer_age = -5;
   

ALTER TABLE retail_orders_dirty
MODIFY COLUMN  customer_age int ;


-- 5

UPDATE retail_orders_dirty
SET discount = CASE
    WHEN discount = 'null' THEN 4
    WHEN discount = ' ' THEN 4
    WHEN discount = '' THEN 4
END
WHERE discount IN ('null', ' ', '');


ALTER TABLE retail_orders_dirty
MODIFY COLUMN discount DECIMAL(10,2)  ;

-- Task 6
-- Find records where customer name is blank or contains only spaces.
-- Expected Learning:
-- •	TRIM() 

SELECT customer_name
FROM retail_orders_dirty
WHERE TRIM(customer_name) = '';

-- Find rows where quantity contains:
-- •	NULL 
-- •	blank values 
-- •	text like 'NULL' 
-- Expected Learning:
-- •	Handling fake null values 

SELECT *
FROM retail_orders_dirty
WHERE quantity IS NULL
   OR TRIM(quantity) = ''
   OR LOWER(quantity) = 'null';
   
--    Replace missing customer emails with:
-- unknown@gmail.com
-- Expected Learning:
-- •	UPDATE 

UPDATE retail_orders_dirty
SET customer_email = 'unknown@gmail.com'
WHERE customer_email IS NULL
   OR TRIM(customer_email) = '';
   
--    Identify duplicate order IDs.
-- Expected Learning:
-- •	GROUP BY 
-- •	HAVING 

   
   SELECT order_id, COUNT(*) AS duplicate_count
FROM retail_orders_dirty
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Identify duplicate order IDs.
-- Expected Learning:
-- •	GROUP BY 
-- •	HAVING 

SELECT *
FROM retail_orders_dirty
WHERE order_id IN (
    SELECT order_id
    FROM retail_orders_dirty
    GROUP BY order_id
    HAVING COUNT(*) > 1
);

-- Task 14
-- Standardize gender values.
-- Current values include:
-- •	Male 
-- •	male 
-- •	M 
-- •	FEMALE 
-- •	Female 
-- Convert all into:
-- •	Male 
-- •	Female 
-- Expected Learning:
-- •	CASE WHEN 



UPDATE retail_orders_dirty
SET gender =
CASE
    WHEN UPPER(TRIM(gender)) IN ('MALE', 'M')
        THEN 'Male'

    WHEN UPPER(TRIM(gender)) IN ('FEMALE', 'F')
        THEN 'Female'

    ELSE gender
END;

-- Task 15
-- Standardize city names.
-- Convert:
-- •	delhi 
-- •	Delhi 
-- •	Delhi 
-- into one format.
-- Expected Learning:
-- •	LOWER() 
-- •	UPPER() 


UPDATE retail_orders_dirty
SET city =
CASE
    WHEN LOWER(TRIM(city)) = 'delhi'
    THEN 'Delhi'

    ELSE city
END;

-- Task 16
-- Standardize order status values.
-- Convert:
-- •	delivered 
-- •	Delivered 
-- into:
-- •	Delivered 


UPDATE retail_orders_dirty
SET order_status = 'Delivered'
WHERE LOWER(TRIM(order_status)) = 'delivered';


-- Task 17
-- Find invalid email addresses.
-- Rules:
-- •	Must contain @ 
-- •	Must contain . 
-- Expected Learning:
-- •	LIKE 




SELECT *
FROM retail_orders_dirty
WHERE customer_email NOT LIKE '%@%'
   OR customer_email NOT LIKE '%.%';


-- Task 18
-- Replace invalid emails with NULL.
-- Expected Learning:
-- •	Data correction 


UPDATE retail_orders_dirty
SET customer_email = NULL
WHERE customer_email NOT LIKE '%@%'
OR customer_email NOT LIKE '%.%';
 
-- Task 19
-- Find invalid phone numbers.
-- Rules:
-- •	Must contain exactly 10 digits 
-- Expected Learning:
-- •	LENGTH() 

SELECT *
FROM retail_orders_dirty
WHERE LENGTH(phone_number) != 10;




-- Task 20
-- Separate invalid phone numbers into an error table

-- Create error table

CREATE TABLE invalid_phone_numbers (
    row_id INT,
    order_id VARCHAR(20),
    customer_name VARCHAR(100),
    phone_number VARCHAR(30),
    error_reason VARCHAR(100)
);


-- Step 2: Insert invalid phone number records

INSERT INTO invalid_phone_numbers
(row_id, order_id, customer_name, phone_number, error_reason)

SELECT
    row_id,
    order_id,
    customer_name,
    phone_number,
    'Invalid phone number'
FROM retail_orders_dirty
WHERE phone_number IS NULL
   OR LENGTH(phone_number) != 10
   OR phone_number NOT REGEXP '^[0-9]{10}$';

-- Step 3: View error records

SELECT * 
FROM invalid_phone_numbers; 	


-- Task 21
-- Find rows where quantity is:
-- • negative
-- • zero
-- • text
-- • NULL

SELECT *
FROM retail_orders_dirty
WHERE quantity IS NULL
   OR TRIM(quantity) = ''
   OR UPPER(quantity) = 'NULL'
   OR quantity REGEXP '[A-Za-z]'
   OR quantity < 0
   OR quantity  = 0;




-- Task 22
-- Find rows where unit_price contains text values

SELECT *
FROM retail_orders_dirty
WHERE unit_price REGEXP '[A-Za-z]';



-- Task 23
-- Replace invalid prices with NULL

UPDATE retail_orders_dirty
SET unit_price = NULL
WHERE unit_price REGEXP '[A-Za-z]';



-- Task 24
-- Find rows where total_amount is not equal to quantity * unit_price

SELECT *,
       (quantity * unit_price) AS calculated_total
FROM retail_orders_dirty
WHERE total_amount != (quantity * unit_price);




-- Task 25
-- Identify all different date formats in the dataset

SELECT 
    order_date,

    CASE

        -- YYYY-MM-DD
        WHEN order_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        THEN 'YYYY-MM-DD'

        -- DD/MM/YYYY
        WHEN order_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
        THEN 'DD/MM/YYYY'

        -- MM-DD-YYYY
        WHEN order_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
        THEN 'MM-DD-YYYY'

        -- YYYY/MM/DD
        WHEN order_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
        THEN 'YYYY/MM/DD'

        -- DD Mon YYYY
        WHEN order_date REGEXP '^[0-9]{2} [A-Za-z]{3} [0-9]{4}$'
        THEN 'DD Mon YYYY'

        ELSE 'Unknown Format'

    END AS date_format

FROM retail_orders_dirty;





-- Task 26
-- Convert all dates into standard MySQL DATE format
-- Target format: YYYY-MM-DD

-- already done



-- Task 27
-- Find invalid dates.
-- Example:
-- •	2025-13-01 


-- already done

-- Task 28
-- Find invalid payment methods.
-- Allowed methods:
-- •	UPI 
-- •	Card 
-- •	COD 
-- •	Cash 
-- Expected Learning:
-- •	Business validation rules 


SELECT *
FROM retail_orders_dirty
WHERE payment_method NOT IN ('UPI', 'Card', 'COD', 'Cash')
   OR payment_method IS NULL
   OR TRIM(payment_method) = '';


-- Task 29
-- Find records where discount exceeds 50%.
-- Expected Learning:
-- •	Outlier detection 

SELECT *
FROM retail_orders_dirty
WHERE (discount / unit_price) * 100 > 50;


-- Task 30
-- Find negative customer ages.

SELECT *
FROM retail_orders_dirty
WHERE customer_age < 0;
 
 
--  Task 31
-- Find non-numeric customer ages.
-- Example:
-- •	Twenty Two 


SELECT *
FROM retail_orders_dirty
WHERE customer_age  REGEXP '[A-Za-z]';

-- Task 32
-- Rename column:
-- state_name → state
-- Expected Learning:
-- •	ALTER TABLE 
-- •	RENAME COLUMN 


ALTER TABLE retail_orders_dirty
RENAME COLUMN state_name TO state;



-- Task 33
-- Change column data types.
-- Convert:
-- Column	New Data Type
-- quantity	INT
-- unit_price	DECIMAL(10,2)
-- total_amount	DECIMAL(10,2)
-- customer_age	INT
-- order_date	DATE
-- Expected Learning:
-- •	ALTER TABLE 
-- •	MODIFY COLUMN 


-- Already done


-- Task 34
-- Create a new column named full_address.
-- Combine:
-- •	city 
-- •	state 
-- •	country 
-- Expected Learning:
-- •	CONCAT() 

ALTER TABLE retail_orders_dirty
ADD COLUMN full_address VARCHAR(255);

UPDATE retail_orders_dirty
SET full_address = CONCAT(city, ', ', state, ', ', country);


-- Task 35
-- Create customer age groups.
-- Conditions:
-- •	0–25 → Young 
-- •	26–45 → Adult 
-- •	46+ → Senior 
-- Expected Learning:
-- •	CASE WHEN 

SELECT *,
       CASE
           WHEN customer_age BETWEEN 0 AND 25 THEN 'Young'
           WHEN customer_age BETWEEN 26 AND 45 THEN 'Adult'
           WHEN customer_age >= 46 THEN 'Senior'
           ELSE 'Invalid'
       END AS age_group
FROM retail_orders_dirty;


-- Task 36
-- Create a cleaned total amount column.
-- Formula:
-- quantity * unit_price

SELECT *,
       (quantity * unit_price) AS calculated_total
FROM retail_orders_dirty;



-- Task 37
-- Create a fully cleaned table named:
-- retail_orders_clean
-- The final table must:
-- •	contain no duplicates 
-- •	contain standardized values 
-- •	contain valid dates 
-- •	contain correct data types 
-- •	contain cleaned numeric values 

-- already done

-- Task 38
-- Remove unnecessary columns from final table.
-- Example:
-- •	remarks 

-- done


-- Task 39
-- Add PRIMARY KEY constraint to order_id.

-- already done


-- Task 40
-- Add NOT NULL constraints to important columns.
-- Examples:
-- •	order_id 
-- •	customer_name 
-- •	order_date 

-- no



-- Task 41
-- Check if any duplicate order IDs still exist.

SELECT order_id,
       COUNT(*) AS duplicate_count
FROM retail_orders_dirty
GROUP BY order_id
HAVING COUNT(*) > 1;



-- Task 42
-- Check if any NULL emails still exist.

SELECT *
FROM retail_orders_dirty
WHERE customer_email IS NULL;


-- Task 43
-- Check if any invalid payment methods still exist.

SELECT *
FROM retail_orders_dirty
WHERE payment_method NOT IN ('UPI', 'Card', 'COD', 'Cash')
   OR payment_method IS NULL
   OR TRIM(payment_method) = '';
   
   
-- Task 44
-- Check if any negative quantities still exist.

SELECT *
FROM retail_orders_dirty
WHERE quantity < 0;


-- Task 45
-- Check if any incorrect dates still exist.

SELECT *
FROM retail_orders_dirty
WHERE clean_order_date IS NULL;












   
   












