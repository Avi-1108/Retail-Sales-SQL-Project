-- WINDOW FUNCTIONS TASK

-- Q1. Assign row numbers to customers by registration date.
SELECT customer_name,registration_date, ROW_NUMBER() OVER(ORDER BY registration_date DESC) AS raw_number 
FROM customers;

-- Q2. Rank products by price.
SELECT product_name,price,RANK() OVER(ORDER BY price DESC) AS ranks
FROM products;

-- Q3. Dense rank products by price.
SELECT product_name,price,DENSE_RANK() OVER(ORDER BY price DESC) AS ranks
FROM products;

-- Q4. Find the previous payment amount.(LAG)
SELECT payment_id,total_amount, LAG(total_amount) OVER(ORDER BY total_amount) AS previou_amount
FROM payments;

-- Q5. Find the next payment amount.(LEAD)
SELECT payment_id,total_amount, LEAD(total_amount) OVER(ORDER BY total_amount) AS previou_amount
FROM payments;

-- Q6. Rank customers based on total spending.
SELECT customer_name,SUM(total_amount) AS total_spending, RANK() OVER(ORDER BY SUM(total_amount) DESC) AS ranks FROM customers
JOIN orders ON customers.customer_id=orders.customer_id
JOIN payments ON orders.order_id=payments.order_id
GROUP BY customer_id;

-- Q7. Find the second highest-priced product.
SELECT product_name,price, DENSE_RANK() OVER(ORDER BY price DESC) AS ranks
FROM products;

-- Q8. Find the third highest payment.
SELECT payment_id,total_amount, DENSE_RANK() OVER(ORDER BY total_amount DESC) AS ranks
FROM payments;

-- Q9. Show each product with the previous product’s price.
SELECT product_name,price, LAG(price) OVER(ORDER BY price) AS previou_price
FROM products;

-- Q10. Show each product with the next product’s price.
SELECT product_name,price, LEAD(price) OVER(ORDER BY price) AS previou_price
FROM products;

-- Q11. Rank cities by customer count.
SELECT city,COUNT(customer_id) AS total_customer, RANK() OVER(ORDER BY COUNT(customer_id) DESC) AS ranks
FROM customers GROUP BY city;

-- Q12. Rank payment methods by revenue.
SELECT payment_method,SUM(total_amount) AS revenue, RANK() OVER(ORDER BY SUM(total_amount) DESC) AS ranks
FROM payments GROUP BY payment_method;

-- Q13. Show order sequence for each customer.(Partition by customer)
SELECT customer_name,order_date, DENSE_RANK() OVER(PARTITION BY customer_name ORDER BY order_date DESC) AS ranks
FROM customers 
LEFT JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q14. Find each customer’s first order.
SELECT customer_name,order_date, DENSE_RANK() OVER(PARTITION BY customer_name ORDER BY order_date) AS ranks
FROM customers 
LEFT JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q15. Find each customer’s latest order.
SELECT customer_name,order_date, DENSE_RANK() OVER(PARTITION BY customer_name ORDER BY order_date DESC) AS ranks
FROM customers 
LEFT JOIN orders
ON customers.customer_id=orders.customer_id;

-- Q16. Find payment growth compared to the previous payment.
SELECT payment_id,payment_date,total_amount, LAG(total_amount) OVER(ORDER BY payment_date) AS previous_amount,
total_amount - LAG(total_amount) OVER(ORDER BY payment_date) AS growth
FROM payments;

-- Q17. Show product ranking within each category.
SELECT product_name,category, RANK() OVER(PARTITION BY category ORDER BY price DESC) AS ranks
FROM products;

-- Q18. Find the most expensive product in each category.
SELECT product_name,category,price, RANK() OVER(PARTITION BY category ORDER BY price DESC) AS ranks
FROM products;

-- Q19. Find the cheapest product in each category.
SELECT product_name,category,price, RANK() OVER(PARTITION BY category ORDER BY price ASC) AS ranks
FROM products;

-- Q20. Generate a complete sales ranking report.
SELECT customer_name,SUM(total_amount) AS payment, RANK() OVER(ORDER BY SUM(total_amount) DESC) AS ranks
FROM customers
JOIN orders ON customers.customer_id=orders.customer_id
JOIN payments ON orders.order_id=payments.order_id 
JOIN order_items ON orders.order_id=order_items.order_id
JOIN products ON products.product_id=order_items.product_id
GROUP BY customers.customer_id;