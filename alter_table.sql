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