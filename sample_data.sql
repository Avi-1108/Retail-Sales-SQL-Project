-- SAMPLE DATA

INSERT INTO customers(customer_name,age,email,phone_number,city,registration_date)
VALUES('Rahul',29,'rahul@gmail.com','1231231231','kanpur','2023-01-01'),
('Priya',20,'priya@gmail.com','1234345246','roorkee','2023-10-11'),
('Mohan',25,'mohan@gmail.com','4564564567','lucknow','2023-08-15'),
('Shreya',19,'shreya@gmail.com','3434234234','indoor','2023-02-24'),
('Sohan',23,'sohan@gmail.com','4897986756','rishikesh','2023-06-27'),
('Neha',30,'neha@gmail.com','5678956789','haridwar','2023-07-12'),
('Yash',33,'yash@gmail.com','3927839278','kashipur','2023-06-04'),
('Geetu',36,'geetu@gmail.com','6798667986','patna','2023-08-06'),
('Arun',27,'arun@gmail.com','2979694939','ramnagar','2023-12-21'),
('Ajay',20,'ajay@gmail.com','3975639756','jammu','2023-07-30');

INSERT INTO stores(store_name,location,manager_name)
VALUE('Delhi Central','Delhi','Sushant Singh'),
('Mumbai Mall','Mumbai','Prakhar Verma'),
('Jaipur Plaza','Jaipur','Rohit Kumar'),
('Pune Square','Pune','Shalini Sharma'),
('Bangalore Hub','Bangalore','Vaishali Gupta');

INSERT INTO products(store_id,product_name,price,category,stock_quantity,launch_date)
VALUES(2,'Charger',1200.89,'Electronics',5,'2022-05-01'),
(5,'Phone',14000.26,'Electronics',DEFAULT,'2024-05-01'),
(1,'Brush',56.00,'Home',20,DEFAULT),
(5,'Chair',1400.54,'Home',10,DEFAULT),
(3,'Table',3450.66,'Home',4,'2022-12-04'),
(1,'Book',350.00,'Stationary',30,'2023-08-06'),
(4,'Pen',50.21,'Stationary',DEFAULT,'2025-12-11'),
(1,'Mouse',1000.00,'Electronics',30,DEFAULT),
(2,'Bed',34000.45,'Home',4,'2021-03-30'),
(4,'Laptop',26000.50,'Electronics',10,'2024-05-12');

INSERT INTO orders(customer_id,order_date,order_status)
VALUES(2,'2026-03-04','delivered'),
(1,'2026-03-04','pending'),
(4,'2026-03-04','delivered'),
(9,'2026-03-04','pending'),
(10,'2026-03-04','delivered'),
(7,'2026-03-04','pending'),
(5,'2026-03-04','delivered'),
(8,'2026-03-04','cancelled'),
(6,'2026-03-04','delivered'),
(10,'2026-03-04','delivered'),
(4,'2026-03-04','pending'),
(7,'2026-03-04','delivered'),
(9,'2026-03-04','pending'),
(3,'2026-03-04','cancelled'),
(2,'2026-03-04','cancelled');

INSERT INTO order_items(order_id,product_id,quantity,item_total)
VALUES(12,1,3,3600.34),
(13,3,2,3567.78),
(13,5,5,2845.39),
(11,7,6,4983.25),
(4,2,1,4567.00),
(9,8,1,11234.28),
(8,9,4,2946.17),
(2,10,2,3973.56),
(7,10,8,2945.39),
(4,4,1,4745.23),
(10,6,4,1745.30),
(14,10,1,3895.40),
(2,9,2,17054.00),
(13,5,1,27450.70),
(7,2,2,2507.74),
(4,8,4,12000.32),
(5,2,3,2690.27),
(8,5,2,2367.56),
(2,7,3,27895.91),
(2,8,1,2675.38),
(1,10,1,3444.72),
(8,9,4,4500.53),
(10,4,2,1144.00),
(11,5,4,100.75),
(8,7,5,2200.23),
(3,3,2,2300.63),
(9,4,4,1300.48),
(12,2,2,2300.26),
(6,6,1,6700.49),
(3,9,1,5400.00);

INSERT INTO payments(order_id,payment_method,total_amount,payment_date)
VALUES(14,'UPI',3499.89,'2026-09-09'),
(1,'Net Banking',3499.89,DEFAULT),
(11,'Net Banking',3499.89,'2026-10-11'),
(15,'UPI',3499.89,'2026-02-26'),
(6,'Credit Card',3499.89,DEFAULT),
(5,'Debit Card',3499.89,'2026-04-30'),
(7,'Credit Card',3499.89,'2026-09-14'),
(2,'Cash',3499.89,'2026-12-31'),
(8,'UPI',3499.89,'2026-01-07'),
(4,'Credit Card',3499.89,DEFAULT),
(9,'Debit Card',3499.89,'2026-05-23'),
(3,'Debit Card',3499.89,'2026-05-27'),
(12,'Net Banking',3499.89,DEFAULT),
(10,'Cash',3499.89,'2026-08-04'),
(13,'Cash',3499.89,'2026-01-17');