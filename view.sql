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