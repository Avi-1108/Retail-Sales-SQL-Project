-- AGGREGATE FUNCTION AND GROUP BY/HAVING TASKS

-- Q1. How many customers exist?
SELECT COUNT(customer_id) AS total_customers FROM customers;

-- Q2. Total value of all products.
SELECT SUM(price) AS total_value FROM products;

-- Q3. Average product price.
SELECT AVG(price) AS avg_price FROM products;

-- Q4. Highest product price.
SELECT MAX(price) AS highest_price FROM products;

-- Q5. Lowest product price.
SELECT MIN(price) AS lowest_price FROM products;

-- Q6. Total stock available.
SELECT SUM(stock_quantity) AS total_stock FROM products;

-- Q7. How many orders were placed?
SELECT COUNT(order_id) AS total_order FROM orders;

-- Q8. Total payment collected.
SELECT SUM(total_amount) AS total_payment FROM payments;

-- Q9. Average payment amount.
SELECT AVG(total_amount) AS avg_order_price FROM payments;

-- Q10. Highest payment.
SELECT MAX(total_amount) AS max_order_price FROM payments;

-- Q11.  Lowest payment.
SELECT MIN(total_amount) AS min_order_price FROM payments;

-- Q12.  Number of customers in each city.
SELECT city, COUNT(customer_id) AS total_cust FROM customers GROUP BY city;

-- Q13. Number of products in each category.
SELECT category, COUNT(product_id) AS total_prod FROM products GROUP BY category;

-- Q14. Average product price per category.
SELECT category, AVG(price) AS avg_price FROM products GROUP BY category;

-- Q15. Total revenue by payment method.
SELECT payment_method, SUM(total_amount) AS total_revenue FROM payments GROUP BY payment_method;

-- Q16. Count customers in each city.
SELECT city, COUNT(customer_id) AS total_customer FROM customers GROUP BY city;

-- Q17. Count products by category.
SELECT category, COUNT(product_name) AS total_prod FROM products GROUP BY category;

-- Q18. Average price by category.
SELECT category, AVG(price) AS avg_price FROM products GROUP BY category;

-- Q19. Total stock by category.
SELECT category, SUM(stock_quantity) AS total_stock FROM products GROUP BY category;

-- Q20. Show only categories having more than three products.
SELECT category, COUNT(product_name) AS total_product FROM products GROUP BY category HAVING total_product >3;

-- Q21. Cities having more than two customers.
SELECT city, COUNT(customer_name) AS total_cust FROM customers GROUP BY city HAVING total_cust > 2;

-- Q22. Payment methods collecting more than ₹10,000.
SELECT payment_method, SUM(total_amount) AS total_amount FROM payments GROUP BY payment_method HAVING total_amount > 10000;

-- Q23. Categories whose average price exceeds ₹2,000.
SELECT category, AVG(price) AS avg_price FROM products GROUP BY category HAVING avg_price > 2000;

-- Q24. Customers who placed more than one order.
SELECT customer_id, COUNT(order_id) AS total_order FROM orders GROUP BY customer_id HAVING total_order > 1;

-- Q25. Products ordered more than four times.
SELECT product_id, COUNT(item_id) AS total_order FROM order_items GROUP BY product_id HAVING total_order > 4;


-- Q26. Top three cities by customer count.
SELECT city, COUNT(customer_name) AS total_cust FROM customers GROUP BY city ORDER BY total_cust DESC LIMIT 3;

-- Q27. Top two expensive categories.
SELECT category, SUM(price) AS total_cost FROM products GROUP BY category ORDER BY total_cost DESC LIMIT 2;

-- Q28. Average quantity sold by category.
SELECT category, AVG(stock_quantity) AS total_quantity FROM products GROUP BY category;

-- Q29. Orders containing more than three products.
SELECT product_id,COUNT(item_id) AS total_product FROM order_items GROUP BY product_id HAVING total_product > 3;

-- Q30. Payment methods used more than three times.
SELECT payment_method, COUNT(payment_id) AS total_count FROM payments GROUP BY payment_method HAVING total_count > 3;