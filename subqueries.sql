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