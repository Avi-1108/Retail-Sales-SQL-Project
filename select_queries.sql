-- SELECT TASKS

-- Q1. Display all customers.
SELECT * FROM customers;

-- Q2. Display only:
-- * customer_name
-- * city
SELECT customer_name FROM customers;

SELECT city FROM customers;

-- Q3. Display:
-- * product_name
-- * price
SELECT product_name FROM products;

SELECT price FROM products;

-- Q4. Display unique product categories.
SELECT DISTINCT category FROM products;

-- Q5. Display customers registered after a specific date(2023-05-04).
SELECT * FROM products WHERE launch_date > "2023-05-04";

-- Q6. Display Electronics products.
SELECT * FROM products WHERE category="Electronics";

-- Q7. Display products costing more than ₹10,000.
SELECT * FROM products WHERE price>"10000";

-- Q8. Display products priced between ₹5,000 and ₹20,000.
SELECT * FROM products WHERE price BETWEEN 5000 AND 20000;

-- Q9. Display customers from Delhi or Mumbai.
SELECT * FROM customers WHERE city IN("delhi","mumbai");

-- Q10. Display orders whose status is Delivered.
SELECT * FROM orders WHERE order_status = "delivered";

-- Q11. Display products whose stock is less than 10.
SELECT * FROM products WHERE stock_quantity <10;

-- Q12. Display payments made using UPI.
SELECT * FROM payments WHERE payment_method = 'upi';

-- Q13. Display customers whose age is greater than 30.
SELECT * FROM customers WHERE age >10;

-- Q14. Display orders placed in the current month.
SELECT * FROM orders WHERE order_date = MONTH(CURDATE());

-- Q15. Display customers whose names start with “A”.
SELECT * FROM customers WHERE customer_name LIKE 'a%';

-- Q16. Display customers whose names end with “a”.
SELECT * FROM customers WHERE customer_name LIKE '%a';

-- Q17. Display products ordered by price(Ascending)
SELECT * FROM products ORDER BY price ASC;

-- Q18. Display products ordered by price(Descending)
SELECT * FROM products ORDER BY price DESC;

-- Q19. Display the five most expensive products.
SELECT product_name FROM products ORDER BY price DESC LIMIT 5;

-- Q20. Display the latest five customer registrations.
SELECT * FROM customers ORDER BY registration_date DESC LIMIT 5;