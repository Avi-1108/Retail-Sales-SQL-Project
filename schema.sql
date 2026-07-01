CREATE DATABASE retail_sales_analytics;

USE retail_sales_analytics;

CREATE TABLE customers(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
customer_name VARCHAR(50) NOT NULL,
age INT NOT NULL,
email VARCHAR(30) UNIQUE,
phone_number VARCHAR(30) UNIQUE,
city VARCHAR(30) NOT NULL,
registration_date DATE DEFAULT(CURDATE())
);

CREATE TABLE products(
product_id INT AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(50) NOT NULL,
price DECIMAL(10,2) CHECK(price>0),
category VARCHAR(50) UNIQUE,
stock_quantity INT DEFAULT(0),
launch_date DATE DEFAULT(CURDATE())
);

CREATE TABLE orders(
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
order_date DATE DEFAULT(CURDATE()),
order_status VARCHAR(10) CHECK(order_status= 'cancelled' OR order_status= 'pending' OR order_status= 'delivered'),
FOREIGN KEY (customer_id) 
REFERENCES customers(customer_id)
);

CREATE TABLE order_items(
item_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT DEFAULT(0),
item_total INT DEFAULT(0),
FOREIGN KEY (order_id)
REFERENCES orders(order_id),
FOREIGN KEY (product_id)
REFERENCES products(product_id)
);

CREATE TABLE payments(
payment_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
payment_method VARCHAR(50) NOT NULL,
total_amount DECIMAL(10,2) CHECK(total_amount>0),
payment_date DATE DEFAULT(CURDATE()),
FOREIGN KEY (order_id)
REFERENCES orders(order_id)
);

CREATE TABLE stores(
store_id INT AUTO_INCREMENT PRIMARY KEY,
store_name VARCHAR(50) NOT NULL,
location VARCHAR(30) NOT NULL,
manager_name VARCHAR(50) NOT NULL
);