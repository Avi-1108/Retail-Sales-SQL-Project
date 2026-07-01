# Project: Retail Sales & Customer Insights Database (SQL)

## Project Goal

Build a relational database for a retail company to manage:
* Customers
* Products
* Orders
* Payments
* Delivery
* Store locations

Focus:
* Database design
* Constraints
* DDL
* DML
* DCL
* TCL

⸻

## Database Schema
Tables included in this project:

### Customers
Stores customer details and registration information.

### Products
Stores product information including pricing and stock.

### Orders
Stores customer order records.

### Order_Items
Handles product-level order details.

### Payments
Stores payment transaction records.

### Stores
Stores retail store information.

## Constraint Challenges

### Implement rules:

1. Customer email must be unique
2. Product stock cannot go below zero
3. Customer cannot place empty orders
4. Duplicate products in same order not allowed
5. Payment amount must match order value

## DML Tasks

### Perform:

#### INSERT
* 30 customers
* 20 products
* 50 orders

#### UPDATE
Examples:
* Increase product prices
* Update delivery status
* Adjust stock

#### DELETE
Examples:
* Remove cancelled orders
* Delete inactive customers


## DCL Tasks
Practice:
* Create analyst user
* Grant read access
* Revoke update permission


## TCL Tasks
Perform:
* START TRANSACTION
* SAVEPOINT
* ROLLBACK
* COMMIT




## Author

Avinash Chaudhary