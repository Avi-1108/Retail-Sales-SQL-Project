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