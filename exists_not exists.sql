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