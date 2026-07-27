CREATE DATABASE retail_sales_analytics;

USE retail_sales_analytics;

CREATE TABLE customers(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
customer_name VARCHAR(50) NOT NULL,
age INT NOT NULL,
email VARCHAR(30) UNIQUE,
phone_number VARCHAR(30) UNIQUE,
city VARCHAR(30) NOT NULL,
registration_date DATE DEFAULT(CURDATE())
);

CREATE TABLE products(
product_id INT AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(50) NOT NULL,
price DECIMAL(10,2) CHECK(price>0),
category VARCHAR(50) UNIQUE,
stock_quantity INT DEFAULT(0),
launch_date DATE DEFAULT(CURDATE())
);

CREATE TABLE orders(
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
order_date DATE DEFAULT(CURDATE()),
order_status VARCHAR(10) CHECK(order_status= 'cancelled' OR order_status= 'pending' OR order_status= 'delivered'),
FOREIGN KEY (customer_id) 
REFERENCES customers(customer_id)
);

CREATE TABLE order_items(
item_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT DEFAULT(0),
item_total INT DEFAULT(0),
FOREIGN KEY (order_id)
REFERENCES orders(order_id),
FOREIGN KEY (product_id)
REFERENCES products(product_id)
);

CREATE TABLE payments(
payment_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
payment_method VARCHAR(50) NOT NULL,
total_amount DECIMAL(10,2) CHECK(total_amount>0),
payment_date DATE DEFAULT(CURDATE()),
FOREIGN KEY (order_id)
REFERENCES orders(order_id)
);

CREATE TABLE stores(
store_id INT AUTO_INCREMENT PRIMARY KEY,
store_name VARCHAR(50) NOT NULL,
location VARCHAR(30) NOT NULL,
manager_name VARCHAR(50) NOT NULL
);

-- category should probably not be UNIQUE---Product table 
ALTER TABLE products
DROP CONSTRAINT category;

-- Add validation for stock quantity--products table
ALTER TABLE products
MODIFY COLUMN stock_quantity INT DEFAULT(0) CHECK(stock_quantity>=0);

-- customer_id should likely be required--orders table
ALTER TABLE orders
MODIFY COLUMN customer_id INT NOT NULL;

-- order_status length is tight--orders table
ALTER TABLE orders
MODIFY COLUMN order_status VARCHAR(50);

-- quantity should not allow zero--order_items table
ALTER TABLE order_items
MODIFY COLUMN quantity INT DEFAULT(0) CHECK(quantity>=0);

-- item_total datatype--order_items table
ALTER TABLE order_items
MODIFY COLUMN item_total DECIMAL(10,2) CHECK(item_total>=0);

-- One order → One payment--payments table
ALTER TABLE payments
ADD CONSTRAINT unique_order_id UNIQUE(order_id);

-- Email length--customers table
ALTER TABLE customers
MODIFY COLUMN email VARCHAR(100);

-- ADD lumn store_id-- products table
ALTER TABLE products
ADD COLUMN store_id INT;

-- FOREIGN KEY Added store_id-- products table
ALTER TABLE products
ADD CONSTRAINT FOREIGN KEY (store_id) REFERENCES stores(store_id);

-- SAMPLE DATA

INSERT INTO customers(customer_name,age,email,phone_number,city,registration_date)
VALUES('Rahul',29,'rahul@gmail.com','1231231231','kanpur','2023-01-01'),
('Priya',20,'priya@gmail.com','1234345246','roorkee','2023-10-11'),
('Mohan',25,'mohan@gmail.com','4564564567','lucknow','2023-08-15'),
('Shreya',19,'shreya@gmail.com','3434234234','indoor','2023-02-24'),
('Sohan',23,'sohan@gmail.com','4897986756','rishikesh','2023-06-27'),
('Neha',30,'neha@gmail.com','5678956789','haridwar','2023-07-12'),
('Yash',33,'yash@gmail.com','3927839278','kashipur','2023-06-04'),
('Geetu',36,'geetu@gmail.com','6798667986','patna','2023-08-06'),
('Arun',27,'arun@gmail.com','2979694939','ramnagar','2023-12-21'),
('Ajay',20,'ajay@gmail.com','3975639756','jammu','2023-07-30');

INSERT INTO stores(store_name,location,manager_name)
VALUE('Delhi Central','Delhi','Sushant Singh'),
('Mumbai Mall','Mumbai','Prakhar Verma'),
('Jaipur Plaza','Jaipur','Rohit Kumar'),
('Pune Square','Pune','Shalini Sharma'),
('Bangalore Hub','Bangalore','Vaishali Gupta');

INSERT INTO products(store_id,product_name,price,category,stock_quantity,launch_date)
VALUES(2,'Charger',1200.89,'Electronics',5,'2022-05-01'),
(5,'Phone',14000.26,'Electronics',DEFAULT,'2024-05-01'),
(1,'Brush',56.00,'Home',20,DEFAULT),
(5,'Chair',1400.54,'Home',10,DEFAULT),
(3,'Table',3450.66,'Home',4,'2022-12-04'),
(1,'Book',350.00,'Stationary',30,'2023-08-06'),
(4,'Pen',50.21,'Stationary',DEFAULT,'2025-12-11'),
(1,'Mouse',1000.00,'Electronics',30,DEFAULT),
(2,'Bed',34000.45,'Home',4,'2021-03-30'),
(4,'Laptop',26000.50,'Electronics',10,'2024-05-12');

INSERT INTO orders(customer_id,order_date,order_status)
VALUES(2,'2026-03-04','delivered'),
(1,'2026-03-04','pending'),
(4,'2026-03-04','delivered'),
(9,'2026-03-04','pending'),
(10,'2026-03-04','delivered'),
(7,'2026-03-04','pending'),
(5,'2026-03-04','delivered'),
(8,'2026-03-04','cancelled'),
(6,'2026-03-04','delivered'),
(10,'2026-03-04','delivered'),
(4,'2026-03-04','pending'),
(7,'2026-03-04','delivered'),
(9,'2026-03-04','pending'),
(3,'2026-03-04','cancelled'),
(2,'2026-03-04','cancelled');

INSERT INTO order_items(order_id,product_id,quantity,item_total)
VALUES(12,1,3,3600.34),
(13,3,2,3567.78),
(13,5,5,2845.39),
(11,7,6,4983.25),
(4,2,1,4567.00),
(9,8,1,11234.28),
(8,9,4,2946.17),
(2,10,2,3973.56),
(7,10,8,2945.39),
(4,4,1,4745.23),
(10,6,4,1745.30),
(14,10,1,3895.40),
(2,9,2,17054.00),
(13,5,1,27450.70),
(7,2,2,2507.74),
(4,8,4,12000.32),
(5,2,3,2690.27),
(8,5,2,2367.56),
(2,7,3,27895.91),
(2,8,1,2675.38),
(1,10,1,3444.72),
(8,9,4,4500.53),
(10,4,2,1144.00),
(11,5,4,100.75),
(8,7,5,2200.23),
(3,3,2,2300.63),
(9,4,4,1300.48),
(12,2,2,2300.26),
(6,6,1,6700.49),
(3,9,1,5400.00);

INSERT INTO payments(order_id,payment_method,total_amount,payment_date)
VALUES(14,'UPI',1266.89,'2026-09-09'),
(1,'Net Banking',3788.00,DEFAULT),
(11,'Net Banking',4536.23,'2026-10-11'),
(15,'UPI',3499.54,'1756-02-26'),
(6,'Credit Card',9365.00,DEFAULT),
(5,'Debit Card',456.21,'2026-04-30'),
(7,'Credit Card',4147.45,'2026-09-14'),
(2,'Cash',1111.50,'2026-12-31'),
(8,'UPI',NULL,'2026-01-07'),
(4,'Credit Card',4590.11,DEFAULT),
(9,'Debit Card',2734.89,'2026-05-23'),
(3,'Debit Card',3410.00,'2026-05-27'),
(12,'Net Banking',3789.00,DEFAULT),
(10,'Cash',NULL,'2026-08-04'),
(13,'Cash',1234.11,'2026-01-17');

-- DML TASKS
-- Q1- Change the city of a specific customer.
UPDATE customers
SET city='noida' WHERE customer_id=3;

-- Q2- Update the email address of two customers.
UPDATE customers
SET email='shrey@gmail.com' WHERE customer_id=4;

UPDATE customers
SET email='aru@gmail.com' WHERE customer_id=9;

-- Q3. Increase the age of customers by one year.
UPDATE customers
SET age=age+1 WHERE customer_id  IS NOT NULL;

-- Q4. Change the phone number of a customer.
UPDATE customers
SET phone_number='19717563645' WHERE customer_id=6;

-- Q5. Increase the price of all Electronics products by 10%.
UPDATE products
SET price=price+price*0.1
WHERE category='Electronics';

-- Q6. Reduce the stock of a product after a purchase.
UPDATE products
SET stock_quantity=stock_quantity-1
WHERE product_id = 6;

-- Q7. Restock all products with stock below 20.
UPDATE products
SET stock_quantity=stock_quantity+1
WHERE stock_quantity < 20;

-- Q8. Rename a product.
UPDATE products
SET product_name='Lappy'
WHERE product_name='Laptop';

-- Q9. Change all Pending orders to Delivered.
UPDATE orders
SET order_status='delivered'
WHERE order_status='pending';

-- Q10. Cancel one order.
UPDATE orders
SET order_status='cancelled'
WHERE order_id=5;

-- Q11. Update the order date for a specific order.
UPDATE orders
SET order_date= DEFAULT
WHERE order_id=3;

-- Q12. Increase the quantity of one product in an order.
UPDATE order_items
SET quantity=quantity+1
WHERE item_id=65;

-- Q13. Update the item total after changing quantity.
UPDATE order_items
SET item_total=5656.99
WHERE item_id=65;

-- Q14. Replace one product in an order with another product.
UPDATE order_items
SET product_id=2
WHERE item_id=62;

-- Q15. Change the payment method.
UPDATE payments
SET payment_method='UPI'
WHERE payment_id=2;

-- Q16. Correct an incorrect payment amount.
UPDATE payments
SET total_amount=5389.26
WHERE payment_id=7;

-- Observe which operations succeed and which fail because of foreign key constraints.
-- Q17. Delete one payment record.
DELETE FROM payments WHERE payment_id=5;

-- Q18. Delete one order item.
DELETE FROM order_items WHERE item_id=67;

-- Q19. Delete one order.
DELETE FROM orders WHERE order_id=2;
-- Ans Can't delete/update due to a parent row/Foreign key.

-- Q20. Delete one customer.
DELETE FROM customers WHERE customer_id=3;
-- Ans Can't delete/update due to a parent row/Foreign key.

-- TCL TASKS

-- SELECT TASKS
-- Q21. Display all customers.
SELECT * FROM customers;

-- Q22. Display only:
-- * customer_name
-- * city
SELECT customer_name FROM customers;

SELECT city FROM customers;

-- Q23. Display:
-- * product_name
-- * price
SELECT product_name FROM products;

SELECT price FROM products;

-- Q24. Display unique product categories.
SELECT DISTINCT category FROM products;

-- Q25. Display customers registered after a specific date(2023-05-04).
SELECT * FROM products WHERE launch_date > "2023-05-04";

-- Q26. Display Electronics products.
SELECT * FROM products WHERE category="Electronics";

-- Q27. Display products costing more than ₹10,000.
SELECT * FROM products WHERE price>"10000";

-- Q28. Display products priced between ₹5,000 and ₹20,000.
SELECT * FROM products WHERE price BETWEEN 5000 AND 20000;

-- Q29. Display customers from Delhi or Mumbai.
SELECT * FROM customers WHERE city IN("delhi","mumbai");

-- Q30. Display orders whose status is Delivered.
SELECT * FROM orders WHERE order_status = "delivered";

-- Q31. Display products whose stock is less than 10.
SELECT * FROM products WHERE stock_quantity <10;

-- Q32. Display payments made using UPI.
SELECT * FROM payments WHERE payment_method = 'upi';

-- Q33. Display customers whose age is greater than 30.
SELECT * FROM customers WHERE age >10;

-- Q34. Display orders placed in the current month.
SELECT * FROM orders WHERE order_date = MONTH(CURDATE());

-- Q35. Display customers whose names start with “A”.
SELECT * FROM customers WHERE customer_name LIKE 'a%';

-- Q36. Display customers whose names end with “a”.
SELECT * FROM customers WHERE customer_name LIKE '%a';

-- Q37. Display products ordered by price(Ascending)
SELECT * FROM products ORDER BY price ASC;

-- Q38. Display products ordered by price(Descending)
SELECT * FROM products ORDER BY price DESC;

-- Q39. Display the five most expensive products.
SELECT product_name FROM products ORDER BY price DESC LIMIT 5;

-- Q40. Display the latest five customer registrations.
SELECT * FROM customers ORDER BY registration_date DESC LIMIT 5;


-- AGGREGATE FUNCTION AND GROUP BY/HAVING TASKS
-- Q41. How many customers exist?
SELECT COUNT(customer_id) AS total_customers FROM customers;

-- Q42. Total value of all products.
SELECT SUM(price) AS total_value FROM products;

-- Q43. Average product price.
SELECT AVG(price) AS avg_price FROM products;

-- Q44. Highest product price.
SELECT MAX(price) AS highest_price FROM products;

-- Q45. Lowest product price.
SELECT MIN(price) AS lowest_price FROM products;

-- Q46. Total stock available.
SELECT SUM(stock_quantity) AS total_stock FROM products;

-- Q47. How many orders were placed?
SELECT COUNT(order_id) AS total_order FROM orders;

-- Q48. Total payment collected.
SELECT SUM(total_amount) AS total_payment FROM payments;

-- Q49. Average payment amount.
SELECT AVG(total_amount) AS avg_order_price FROM payments;

-- Q50. Highest payment.
SELECT MAX(total_amount) AS max_order_price FROM payments;

-- Q51.  Lowest payment.
SELECT MIN(total_amount) AS min_order_price FROM payments;

-- Q52.  Number of customers in each city.
SELECT city, COUNT(customer_id) AS total_cust FROM customers GROUP BY city;

-- Q53. Number of products in each category.
SELECT category, COUNT(product_id) AS total_prod FROM products GROUP BY category;

-- Q54. Average product price per category.
SELECT category, AVG(price) AS avg_price FROM products GROUP BY category;

-- Q55. Total revenue by payment method.
SELECT payment_method, SUM(total_amount) AS total_revenue FROM payments GROUP BY payment_method;

-- Q56. Count customers in each city.
SELECT city, COUNT(customer_id) AS total_customer FROM customers GROUP BY city;

-- Q57. Count products by category.
SELECT category, COUNT(product_name) AS total_prod FROM products GROUP BY category;

-- Q58. Average price by category.
SELECT category, AVG(price) AS avg_price FROM products GROUP BY category;

-- Q59. Total stock by category.
SELECT category, SUM(stock_quantity) AS total_stock FROM products GROUP BY category;

-- Q60. Show only categories having more than three products.
SELECT category, COUNT(product_name) AS total_product FROM products GROUP BY category HAVING total_product >3;

-- Q61. Cities having more than two customers.
SELECT city, COUNT(customer_name) AS total_cust FROM customers GROUP BY city HAVING total_cust > 2;

-- Q62. Payment methods collecting more than ₹10,000.
SELECT payment_method, SUM(total_amount) AS total_amount FROM payments GROUP BY payment_method HAVING total_amount > 10000;

-- Q63. Categories whose average price exceeds ₹2,000.
SELECT category, AVG(price) AS avg_price FROM products GROUP BY category HAVING avg_price > 2000;

-- Q64. Customers who placed more than one order.
SELECT customer_id, COUNT(order_id) AS total_order FROM orders GROUP BY customer_id HAVING total_order > 1;

-- Q65. Products ordered more than four times.
SELECT product_id, COUNT(item_id) AS total_order FROM order_items GROUP BY product_id HAVING total_order > 4;

-- Q66. Top three cities by customer count.
SELECT city, COUNT(customer_name) AS total_cust FROM customers GROUP BY city ORDER BY total_cust DESC LIMIT 3;

-- Q67. Top two expensive categories.
SELECT category, SUM(price) AS total_cost FROM products GROUP BY category ORDER BY total_cost DESC LIMIT 2;

-- Q68. Average quantity sold by category.
SELECT category, AVG(stock_quantity) AS total_quantity FROM products GROUP BY category;

-- Q69. Orders containing more than three products.
SELECT product_id,COUNT(item_id) AS total_product FROM order_items GROUP BY product_id HAVING total_product > 3;

-- Q70. Payment methods used more than three times.
SELECT payment_method, COUNT(payment_id) AS total_count FROM payments GROUP BY payment_method HAVING total_count > 3;

-- JOINS TASK
-- Q71. Display: Customer Name + Order ID
SELECT customer_name, order_id FROM customers
INNER JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q72. Display: Customer Name + Order Date + Status
SELECT customer_name,order_date,order_status FROM customers
INNER JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q73. Display: Order ID + Product Name + Quantity
SELECT order_id,product_name,quantity FROM order_items
INNER JOIN products
ON order_items.product_id=products.product_id;

-- Q74. Display: Product Name + Price + Quantity Purchased
SELECT product_name,price,quantity FROM products
INNER JOIN order_items
ON products.product_id=order_items.product_id;

-- Q75. Display payment amount along with customer name.
SELECT customer_name,total_amount FROM customers
JOIN Orders ON customers.customer_id=orders.customer_id
JOIN payments ON orders.order_id=payments.order_id;

-- Q76. Display customers who never placed an order.
SELECT customer_name, order_id FROM customers
LEFT JOIN orders 
ON customers.customer_id=orders.customer_id
WHERE order_id IS NULL;

-- Q77. Display orders without payments.
SELECT orders.order_id, total_amount FROM orders
LEFT JOIN payments
ON orders.order_id = payments.order_id
WHERE payments.order_id IS NULL;

-- Q78. Display products never ordered.
SELECT product_name,quantity FROM products
LEFT JOIN order_items
ON products.product_id=order_items.product_id
WHERE quantity IS NULL;

-- Q79. Display customers with total order count.
SELECT customer_name,COUNT(order_id) AS total_order FROM customers
LEFT JOIN orders
ON customers.customer_id=orders.customer_id
GROUP BY customers.customer_id;

-- Q80. Display customers with total payment amount.
SELECT customer_name,SUM(total_amount) AS payment FROM customers
JOIN Orders ON customers.customer_id=orders.customer_id
JOIN payments ON orders.order_id=payments.order_id
GROUP BY customers.customer_id;

-- Q81. Display order details using: 1.Customers 2.Orders 3.Order_Items 4.Products
SELECT customer_name,product_name,category,price,order_date,order_status FROM customers
JOIN orders ON customers.customer_id=orders.customer_id
JOIN order_items ON orders.order_id=order_items.order_id
JOIN products ON products.product_id=order_items.product_id;
 
-- Q82. Display: 1.Customer 2.Product 3.Quantity 4.Payment (using four tables)
SELECT customer_name,product_name,quantity,total_amount FROM customers
JOIN orders ON customers.customer_id=orders.customer_id
JOIN payments ON orders.order_id=payments.order_id
JOIN order_items ON orders.order_id=order_items.order_id
JOIN products ON products.product_id=order_items.product_id;

-- Q83. Display all products with their order count.
SELECT product_name, COUNT(order_id) AS total_count FROM products
LEFT JOIN order_items
ON products.product_id=order_items.product_id
GROUP BY product_name;

-- Q84. Display all customers even if they never ordered.
SELECT customer_name,orders.order_id FROM customers
LEFT JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q85. Display all orders even if payment is missing.
SELECT orders.order_id,total_amount FROM orders
LEFT JOIN payments
ON orders.order_id=payments.order_id;

-- Q86. Create a CROSS JOIN between customers and stores.
SELECT customer_name,store_name FROM customers
CROSS JOIN stores;

-- Q87. Create a SELF JOIN challenge.
SELECT c1.customer_name,c2.customer_name,c2.city FROM customers c1
LEFT JOIN customers c2
ON c1.city=c2.city
WHERE c1.customer_id != c2.customer_id;

-- Q88. Simulate a FULL OUTER JOIN in MySQL.
SELECT * FROM customers
LEFT JOIN orders
ON customers.customer_id=orders.customer_id
UNION
SELECT * FROM customers
RIGHT JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q89. Display NULL values generated by LEFT JOIN.
SELECT orders.order_id, total_amount FROM orders
LEFT JOIN payments
ON orders.order_id=payments.order_id
WHERE total_amount IS NULL;

-- Q90. Identify unmatched records after joining.
SELECT customer_name,total_amount FROM customers
LEFT JOIN orders ON customers.customer_id=orders.customer_id
LEFT JOIN payments ON orders.order_id=payments.order_id
WHERE total_amount IS NULL;

-- Q91. Which products generated the highest revenue?
SELECT product_name, SUM(item_total) AS revenue FROM products
LEFT JOIN order_items
ON products.product_id=order_items.product_id
GROUP BY product_name
ORDER BY revenue DESC LIMIT 1;

-- Q92. Which customer spent the most?
SELECT customer_name, SUM(item_total) AS total_spent FROM customers
JOIN orders ON customers.customer_id=orders.customer_id
JOIN order_items ON orders.order_id=order_items.order_id
GROUP BY customers.customer_id
ORDER BY total_spent DESC LIMIT 1;

-- Q93. Which product is ordered most frequently?
SELECT product_name, COUNT(order_items.product_id) AS order_count FROM products
LEFT JOIN order_items
ON products.product_id=order_items.product_id
GROUP BY product_name
ORDER BY order_count DESC LIMIT 1;

-- Q94. Which city generated the highest sales?
SELECT city, SUM(total_amount) AS total_spent FROM customers
JOIN orders ON customers.customer_id=orders.customer_id
JOIN payments ON orders.order_id=payments.order_id
GROUP BY city
ORDER BY total_spent DESC LIMIT 1;

-- Q95. Display complete sales report using all related tables.
SELECT customer_name,product_name,category,price ,store_name,order_date,payment_method,total_amount,order_status FROM customers
JOIN orders ON customers.customer_id=orders.customer_id
JOIN payments ON orders.order_id=payments.order_id 
JOIN order_items ON orders.order_id=order_items.order_id
JOIN products ON products.product_id=order_items.product_id
JOIN stores ON products.store_id=stores.store_id;

-- WINDOW FUNCTIONS TASK

-- Q96. Assign row numbers to customers by registration date.
SELECT customer_name,registration_date, ROW_NUMBER() OVER(ORDER BY registration_date DESC) AS raw_number 
FROM customers;

-- Q97. Rank products by price.
SELECT product_name,price,RANK() OVER(ORDER BY price DESC) AS ranks
FROM products;

-- Q98. Dense rank products by price.
SELECT product_name,price,DENSE_RANK() OVER(ORDER BY price DESC) AS ranks
FROM products;

-- Q99. Find the previous payment amount.(LAG)
SELECT payment_id,total_amount, LAG(total_amount) OVER(ORDER BY total_amount) AS previou_amount
FROM payments;

-- Q100. Find the next payment amount.(LEAD)
SELECT payment_id,total_amount, LEAD(total_amount) OVER(ORDER BY total_amount) AS previou_amount
FROM payments;

-- Q101. Rank customers based on total spending.
SELECT customer_name,SUM(total_amount) AS total_spending, RANK() OVER(ORDER BY SUM(total_amount) DESC) AS ranks FROM customers
JOIN orders ON customers.customer_id=orders.customer_id
JOIN payments ON orders.order_id=payments.order_id
GROUP BY customer_id;

-- Q102. Find the second highest-priced product.
SELECT product_name,price, DENSE_RANK() OVER(ORDER BY price DESC) AS ranks
FROM products;

-- Q103. Find the third highest payment.
SELECT payment_id,total_amount, DENSE_RANK() OVER(ORDER BY total_amount DESC) AS ranks
FROM payments;

-- Q104. Show each product with the previous product’s price.
SELECT product_name,price, LAG(price) OVER(ORDER BY price) AS previou_price
FROM products;

-- Q105. Show each product with the next product’s price.
SELECT product_name,price, LEAD(price) OVER(ORDER BY price) AS previou_price
FROM products;

-- Q106. Rank cities by customer count.
SELECT city,COUNT(customer_id) AS total_customer, RANK() OVER(ORDER BY COUNT(customer_id) DESC) AS ranks
FROM customers GROUP BY city;

-- Q107. Rank payment methods by revenue.
SELECT payment_method,SUM(total_amount) AS revenue, RANK() OVER(ORDER BY SUM(total_amount) DESC) AS ranks
FROM payments GROUP BY payment_method;

-- Q108. Show order sequence for each customer.(Partition by customer)
SELECT customer_name,order_date, DENSE_RANK() OVER(PARTITION BY customer_name ORDER BY order_date DESC) AS ranks
FROM customers 
LEFT JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q109. Find each customer’s first order.
SELECT customer_name,order_date, DENSE_RANK() OVER(PARTITION BY customer_name ORDER BY order_date) AS ranks
FROM customers 
LEFT JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q110. Find each customer’s latest order.
SELECT customer_name,order_date, DENSE_RANK() OVER(PARTITION BY customer_name ORDER BY order_date DESC) AS ranks
FROM customers 
LEFT JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q111. Find payment growth compared to the previous payment.
SELECT payment_id,payment_date,total_amount, LAG(total_amount) OVER(ORDER BY payment_date) AS previous_amount,
total_amount - LAG(total_amount) OVER(ORDER BY payment_date) AS growth
FROM payments;

-- Q112. Show product ranking within each category.
SELECT product_name,category, RANK() OVER(PARTITION BY category ORDER BY price DESC) AS ranks
FROM products;

-- Q113. Find the most expensive product in each category.
SELECT product_name,category,price, RANK() OVER(PARTITION BY category ORDER BY price DESC) AS ranks
FROM products;

-- Q114. Find the cheapest product in each category.
SELECT product_name,category,price, RANK() OVER(PARTITION BY category ORDER BY price ASC) AS ranks
FROM products;

-- Q115. Generate a complete sales ranking report.
SELECT customer_name,SUM(total_amount) AS payment, RANK() OVER(ORDER BY SUM(total_amount) DESC) AS ranks
FROM customers
JOIN orders ON customers.customer_id=orders.customer_id
JOIN payments ON orders.order_id=payments.order_id 
JOIN order_items ON orders.order_id=order_items.order_id
JOIN products ON products.product_id=order_items.product_id
GROUP BY customers.customer_id;

-- VIEWS TASKS
-- Q116. Create a view showing all customer details.
CREATE VIEW customer_view AS (
SELECT * FROM customers
);
SELECT * FROM customer_view;

-- Q117. Create a view containing complete order information (customer, order date, status).
CREATE VIEW order_info AS(
SELECT c.customer_id,customer_name,order_date,order_status FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
);
SELECT * FROM order_info;

-- Q118. Create a view showing product inventory details.
CREATE VIEW inventory AS(
SELECT product_name,price,category,stock_quantity FROM products
);
SELECT * FROM inventory;

-- Q119. Create a view displaying payment history.
CREATE VIEW payment_history AS(
SELECT * FROM payments
);
SELECT * FROM payment_history;

-- Q120. Create a view showing customer purchase summary (customer name + total orders).
CREATE VIEW cust_summary AS(
SELECT customer_name,COUNT(order_id) AS total_order FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id
);

-- Q121. Create a view containing all completed (Delivered) orders.
CREATE VIEW delivered_orders AS(
SELECT * FROM orders
WHERE order_status = 'delivered'
);
SELECT * FROM delivered_orders;

-- Q122. Create a view showing products that have never been ordered.
CREATE VIEW no_order_prod AS(
SELECT p.product_id,product_name FROM products p 
LEFT JOIN order_items oi ON p.product_id=oi.product_id
WHERE order_id IS NULL
);

-- Q123. Create a view for monthly sales.
CREATE VIEW monthly_sale AS(
SELECT MONTH(payment_date) AS months, COUNT(order_id) AS total_order, SUM(total_amount) AS total_sales FROM payments GROUP BY months
);

-- Q124. Query data from one of the created views.
SELECT months,total_order,total_sales FROM monthly_sale;

-- Q125. Drop a view.
DROP VIEW monthly_sale;

-- SUBQUERIES TASKS(BASIC)
-- Q126. Find the most expensive product.
SELECT product_name, price FROM products
WHERE price = (
SELECT MAX(price) FROM products
);

-- Q127. Find customers whose age is greater than the average customer age.
SELECT customer_id,customer_name,age FROM customers
WHERE age > (
SELECT AVG(age) FROM customers
);

-- Q128. Find products priced above the average product price.
SELECT product_id,product_name,price FROM products
WHERE price > (
SELECT AVG(price) FROM products
);

-- Q129. Find orders placed after the latest payment date.
SELECT order_id,order_date FROM orders
WHERE order_date > (
SELECT MAX(payment_date) FROM payments
);

-- Q130. Find customers who spent more than the average customer spending.
SELECT c.customer_id,customer_name FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN payments p ON o.order_id=p.order_id
GROUP BY c.customer_id
HAVING SUM(total_amount) > (
SELECT AVG(t.total) FROM (SELECT c.customer_id,SUM(total_amount) AS total FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN payments p ON o.order_id=p.order_id
GROUP BY c.customer_id) AS t);

-- SUBQUERIES TASKS(Multi-row)
-- Q131. Find customers who have placed at least one order.
SELECT c.customer_id,customer_name FROM customers c
WHERE c.customer_id IN (
SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(order_id) >= 1
);

-- Q132. Find products that have never been ordered.
SELECT product_id,product_name FROM products
WHERE product_id NOT IN(
SELECT product_id FROM order_items
);

-- Q133. Find customers who have purchased Electronics products.
SELECT customer_id,customer_name FROM customers
WHERE customer_id IN(
SELECT o.customer_id FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
WHERE p.category = "Electronics"
);

-- Q134. Find orders containing products priced above ₹25,000.
SELECT * FROM orders
WHERE order_id IN(
SELECT order_id FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
WHERE price > 25000
);

-- Q135. Find customers living in cities where at least one delivered order exists.
SELECT customer_id,customer_name,city FROM customers
WHERE city IN(
SELECT city FROM customers c
JOIN orders o ON c.customer_id=o.customer_id 
WHERE order_status = 'delivered'
);

-- SUBQUERIES TASKS(Correlated)

-- Q136. Find customers whose total spending is higher than the average spending of customers in the same city.
SELECT c.customer_id, c.customer_name, city, SUM(total_amount) AS total FROM customers c
JOIN orders o USING(customer_id)
JOIN payments p USING(order_id)
GROUP BY c.customer_id,city
HAVING SUM(total_amount) > (
	SELECT AVG(t.total) FROM (
		SELECT c1.customer_id, c1.city, SUM(p1.total_amount) AS total 
        FROM payments 
        JOIN orders o1 USING(order_id)
		JOIN customers c1 USING(customer_id) 
        GROUP BY c1.customer_id, city
	) AS t
WHERE c.city=t.city
);

-- Q137. Find each customer’s latest order.
SELECT o.customer_id, o.order_id, o.order_date, o.order_status FROM orders o
WHERE o.order_date = (
SELECT MAX(order_date) FROM orders
WHERE customer_id = o.customer_id
);

SELECT customer_id, MAX(order_date) AS latest FROM orders GROUP BY customer_id;

-- Q138. Find products whose price is greater than the average price of products in the same category.
SELECT product_id, product_name FROM products
WHERE product_id IN (
SELECT p1.product_id FROM products p1
WHERE p1.price > (SELECT AVG(p2.price) FROM products p2 WHERE p1.category=p2.category)
);

-- Q139. Find customers who have placed more orders than the average customer.
SELECT c.customer_id,customer_name FROM customers c
JOIN (SELECT customer_id, COUNT(order_id) AS total_order FROM orders GROUP BY customer_id) AS t
ON c.customer_id=t.customer_id
WHERE t.total_order > (SELECT AVG(b.total_order) FROM (SELECT customer_id, COUNT(order_id) AS total_order FROM orders GROUP BY customer_id) AS b)
;

-- Q140. Find the highest-priced product in every category.
SELECT p1.product_id,p1.product_name FROM products p1
WHERE p1.price = (
SELECT MAX(p2.price) FROM products p2 WHERE p1.category=p2.category
);

-- ⸻

-- EXISTS / NOT EXISTS

-- Q141. Find customers who have made payments.
SELECT c1.customer_id, c1.customer_name FROM customers c1
WHERE EXISTS (SELECT * FROM payments p JOIN orders o USING(order_id)
WHERE c1.customer_id = customer_id);

-- Q142. Find customers who have never made a payment.
SELECT c1.customer_id, c1.customer_name FROM customers c1
WHERE NOT EXISTS (SELECT * FROM payments p JOIN orders o USING(order_id)
WHERE c1.customer_id = o.customer_id);

-- Q143. Find products that have been ordered.
SELECT p.product_id, p.product_name FROM products p
WHERE EXISTS (
SELECT product_id FROM orders o JOIN order_items oi USING(order_id)
WHERE oi.product_id = p.product_id
);

-- Q144. Find products that have never been ordered.
SELECT p.product_id, p.product_name FROM products p
WHERE NOT EXISTS (
SELECT product_id FROM orders o JOIN order_items oi USING(order_id)
WHERE oi.product_id = p.product_id
);

-- Q145. Find stores that have no products assigned.
SELECT s.store_id, s.store_name FROM stores s
WHERE NOT EXISTS (
SELECT p.store_id FROM products p
WHERE p.store_id = s.store_id
);

-- CTE TASKS

-- Basic CTE
-- Q146. Create a CTE containing customer spending.
WITH cust_spending AS (
SELECT c.customer_id,customer_name, SUM(total_amount) AS spending FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id
)
SELECT * FROM cust_spending;

-- Q147. Find customers whose spending exceeds ₹50,00 using a CTE.
WITH cust_spending AS (
SELECT c.customer_id,customer_name, SUM(total_amount) AS spending FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id
HAVING spending > 5000
)
SELECT * FROM cust_spending;

-- Q148. Create a CTE showing monthly sales.
WITH monthly_sale AS (
SELECT MONTH(payment_date) AS months, SUM(total_amount) AS revenue FROM payments
GROUP BY months ORDER BY months ASC
)
SELECT * FROM monthly_sale;

-- Q149. Find the highest monthly sales using a CTE.
WITH highest_sale_month AS(
SELECT MONTH(payment_date) AS months, SUM(total_amount) AS revenue FROM payments
GROUP BY months
)
SELECT * FROM highest_sale_month
ORDER BY revenue DESC LIMIT 1;

-- Q150. Create a CTE showing product revenue.
WITH product_revenue AS (
SELECT product_id, product_name, SUM(item_total) AS revenue FROM products
JOIN order_items USING(product_id)
GROUP BY product_id
)
SELECT * FROM product_revenue;

-- CTE + Window Functions
-- Q151. Rank customers based on total spending using a CTE.
WITH rank_cust AS (
SELECT customer_name, SUM(total_amount) As total_spending,
RANK() OVER(ORDER BY SUM(total_amount) DESC) AS ranks FROM customers c
JOIN orders o  USING(customer_id)
JOIN payments p USING(order_id)
GROUP BY customer_id
)
SELECT * FROM rank_cust;

-- Q152. Find the top three customers using a CTE.
WITH top_cust AS (
SELECT customer_name, SUM(total_amount) As total_spending,
ROW_NUMBER() OVER(ORDER BY SUM(total_amount) DESC) AS ranks FROM customers c
JOIN orders o  USING(customer_id)
JOIN payments p USING(order_id)
GROUP BY customer_id
)
SELECT * FROM top_cust
LIMIT 3;

-- Q153. Find the second highest-priced product using a CTE.
WITH second_prod AS (
SELECT product_id, product_name, price,
ROW_NUMBER() OVER(ORDER BY price DESC) AS ranks
FROM products
)
SELECT * FROM second_prod
WHERE ranks =2;

-- Q154. Find the latest payment of every customer using a CTE.
WITH latest_payments AS (
SELECT customer_id, customer_name, payment_date,
DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY payment_date DESC) AS ranks FROM customers c
JOIN orders o USING(customer_id)
JOIN payments p USING(order_id)
)
SELECT * FROM latest_payments
WHERE ranks = 1;

-- Q155. Find the first order of every customer using a CTE.
WITH first_order AS (
SELECT customer_id, customer_name, order_id, order_date,
DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS ranks
FROM customers c
JOIN orders o USING(customer_id)
)
SELECT * FROM first_order
WHERE ranks = 1;

-- Multiple CTEs

-- Q156. Create one CTE for customer spending and another for product revenue, then combine them into one report.
WITH cust_spending AS (
SELECT c.customer_id,customer_name,total_amount FROM customers c
JOIN orders o USING(customer_id)
JOIN payments p USING(order_id)
),
prod_revenue AS (
SELECT o.customer_id, product_id, product_name, total_amount FROM products pr
JOIN order_items oi USING(product_id)
JOIN orders o USING(order_id)
JOIN payments p USING(order_id)
)
SELECT * FROM cust_spending
JOIN prod_revenue USING(customer_id);

-- Q157. Compare monthly revenue with the previous month using a CTE and LAG().
WITH revenue AS (
SELECT MONTH(payment_date) AS months, SUM(total_amount) AS revenue 
FROM payments 
GROUP BY months
),
comparision AS (
SELECT MONTH(payment_date) AS months, SUM(total_amount) AS revenue, 
LAG(SUM(total_amount)) OVER(ORDER BY MONTH(payment_date)) AS previous_month 
FROM payments
GROUP BY months
)
SELECT r.months, r.revenue, c.previous_month FROM revenue r
JOIN comparision c USING(months);

-- Q158. Find customers whose spending is above the company average.
WITH cust_spending AS (
SELECT c.customer_id,customer_name,SUM(total_amount) AS spending FROM customers c
JOIN orders o USING(customer_id)
JOIN payments p USING(order_id)
GROUP BY customer_id
),
total_cust AS (
SELECT AVG(spending) AS avg_spending FROM cust_spending
)
SELECT customer_id,customer_name FROM cust_spending
JOIN total_cust
WHERE spending > avg_spending;

-- Q159. Generate a customer ranking report.
WITH cust_spending AS (
SELECT c.customer_id,customer_name,SUM(total_amount) AS spending FROM customers c
JOIN orders o USING(customer_id)
JOIN payments p USING(order_id)
GROUP BY c.customer_id
),
ranking AS (
SELECT c1.customer_id,SUM(total_amount) AS spending,
DENSE_RANK() OVER(ORDER BY SUM(total_amount) DESC) AS ranks
FROM customers c1
JOIN orders o1 USING(customer_id)
JOIN payments p1 USING(order_id)
GROUP BY c1.customer_id
)
SELECT * FROM cust_spending
JOIN ranking USING(customer_id);

-- Q160. Generate a complete sales summary using multiple CTEs.
WITH customer_detail AS(
SELECT customer_id,customer_name FROM customers
),
order_detail AS (
SELECT order_id, customer_id, order_date FROM orders
),
product_detail AS (
SELECT product_id, product_name FROM products
),
payment_detail AS (
SELECT payment_id, order_id, payment_date, total_amount FROM payments
),
item_detail AS (
SELECT product_id,order_id, quantity FROM order_items
)
SELECT * FROM customer_detail cd
JOIN order_detail od USING(customer_id)
JOIN payment_detail pay USING(order_id)
JOIN item_detail id USING(order_id)
JOIN product_detail pd USING(product_id);

-- CASE TASKS

-- Basic CASE
-- Q161. Classify customers as Young, Adult, or Senior based on age.
SELECT customer_id,customer_name,age,
CASE
WHEN age < 18 THEN 'Young'
WHEN age < 60 THEN 'Adult'
ELSE 'Senior'
END AS age_category
FROM customers;

-- Q162. Categorize products as Cheap, Moderate, or Expensive based on price.
SELECT product_id,product_name,price,
CASE 
WHEN price < 1000 THEN 'Cheap'
WHEN price < 20000 THEN 'Moderate'
ELSE 'Expensive'
END AS product_category
FROM products;

-- Q163. Display stock status as “In Stock”, “Low Stock”, or “Out of Stock”.
SELECT product_id,product_name,stock_quantity,
CASE
WHEN stock_quantity > 10 THEN 'In Stock'
WHEN stock_quantity BETWEEN 1 AND 10 THEN 'Low Stock'
ELSE 'Out of Stock'
END AS stock_category
FROM products;

-- Q164. Display payment status based on payment amount.
SELECT payment_id,total_amount,
CASE
WHEN total_amount < 1000 THEN 'Low'
WHEN total_amount < 3500 THEN 'Medium'
ELSE 'High'
END AS amount_category
FROM payments;

-- Q165. Display order priority based on order status.
SELECT order_id,order_status,
CASE
WHEN order_status = 'pending' THEN 'High priority'
WHEN order_status = 'delivered' THEN 'Delivered'
ELSE 'Cancelled'
END AS order_priority
FROM orders;

-- CASE + AGGREGATION TASKS
-- Q166. Count customers in each age category.
SELECT COUNT(customer_id) AS total_customer,
CASE
WHEN age < 18 THEN 'Young'
WHEN age < 60 THEN 'Adult'
ELSE 'Senior'
END AS age_category
FROM customers
GROUP BY age_category;

-- Q167. Count products by stock status.
SELECT COUNT(product_id) AS total_product,
CASE
WHEN stock_quantity > 10 THEN 'In Stock'
WHEN stock_quantity BETWEEN 1 AND 10 THEN 'Low Stock'
ELSE 'Out of Stock'
END AS stock_category
FROM products
GROUP BY stock_category;

-- Q168. Show total revenue by product price category.
SELECT SUM(item_total) AS total_revenue,
CASE 
WHEN price < 1000 THEN 'Cheap'
WHEN price < 20000 THEN 'Moderate'
ELSE 'Expensive'
END AS product_category
FROM products p
JOIN order_items oi ON p.product_id=oi.product_id
GROUP BY product_category;

SELECT * FROM products;

-- Q169. Show total payments by payment method using CASE.
SELECT SUM(total_amount) AS total_payment,
CASE
WHEN payment_method = 'UPI' THEN 'UPI'
WHEN payment_method = 'Net Banking' THEN 'Net Banking'
WHEN payment_method = 'Credit Card' THEN 'Credit Card'
WHEN payment_method = 'Debit Card' THEN 'Debit Card'
WHEN payment_method = 'Cash' THEN 'Cash'
END AS payment_category
FROM payments
GROUP BY payment_category;

-- Q170. Show total orders by order status.
SELECT COUNT(order_id) AS Total_order,
CASE
WHEN order_status = 'pending' THEN 'High priority'
WHEN order_status = 'delivered' THEN 'Delivered'
ELSE 'Cancelled'
END AS order_priority
FROM orders
GROUP BY order_priority;

-- CASE + Window Functions
-- Q171. Show customer spending with a spending category (Gold, Silver, Bronze).
SELECT c.customer_id,customer_name,
CASE 
WHEN SUM(total_amount) < 3000 THEN 'Bronze'
WHEN SUM(total_amount) < 7000 THEN 'Silver'
ELSE 'Gold'
END AS spending_category
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN payments p ON o.order_id=p.order_id
GROUP BY customer_id,customer_name;

-- Q172. Display product ranking with a label: Top Seller, Medium Seller, Low Seller.
SELECT p.product_id,product_name,
CASE
WHEN COUNT(oi.product_id) BETWEEN 1 AND 2 THEN "Low Seller"
WHEN COUNT(oi.product_id) BETWEEN 3 AND 4 THEN "Medium Seller"
WHEN COUNT(oi.product_id) > 4 THEN "Top Seller"
ELSE "None"
END AS 'Prod_label'
FROM products p
JOIN order_items oi ON p.product_id=oi.product_id
GROUP BY p.product_id,product_name;

-- Q173. Display payment growth as Increase, Decrease, or No Change.
SELECT MONTH(payment_date) AS months,
CASE
WHEN SUM(total_amount) - LAG(SUM(total_amount)) OVER(ORDER BY MONTH(payment_date)) < 0 THEN 'Decrease'
WHEN SUM(total_amount) - LAG(SUM(total_amount)) OVER(ORDER BY MONTH(payment_date)) > 0 THEN 'Increase'
WHEN SUM(total_amount) - LAG(SUM(total_amount)) OVER(ORDER BY MONTH(payment_date)) = 0 THEN 'No Change'
ELSE 'ONE value is NULL'
END AS payment_growth
FROM payments
GROUP BY months;

-- Q174. Categorize cities by total revenue.
SELECT city,
CASE 
WHEN SUM(total_amount) < 3000 THEN 'low sales'
WHEN SUM(total_amount) < 6000 THEN 'medium sales'
ELSE 'high sales'
END AS city_revenue
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN payments p ON o.order_id=p.order_id
GROUP BY city;

-- Q175. Create a complete customer performance report.
SELECT c.customer_id,customer_name,SUM(total_amount) AS total_amounts,
CASE 
WHEN SUM(total_amount) < 3000 THEN 'Bronze'
WHEN SUM(total_amount) < 7000 THEN 'Silver'
ELSE 'Gold'
END AS spending_category
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN payments p ON o.order_id=p.order_id
GROUP BY customer_id,customer_name;



SET SQL_Safe_updates = 1;

SELECT * FROM customers;

SHOW CREATE TABLE customers;

TRUNCATE TABLE payments;