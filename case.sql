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