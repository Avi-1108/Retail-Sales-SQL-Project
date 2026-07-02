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
WHERE product_id = 7;

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