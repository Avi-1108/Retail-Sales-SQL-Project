# Retail Sales & Customer Analytics SQL Project

A practical MySQL project designed to demonstrate SQL skills through a
realistic retail sales database. The project covers data manipulation,
querying, aggregation, joins, subqueries, correlated subqueries, CTEs,
window functions, views, EXISTS / NOT EXISTS, and CASE expressions.

## Project Overview

This project simulates a retail business with customers, products,
stores, orders, order items, and payments.

## Database Structure

-   `customers` - customer information
-   `products` - product information including category, price, stock,
    and store
-   `stores` - store information
-   `orders` - customer orders, dates, and status
-   `order_items` - products and quantities included in orders
-   `payments` - payment details, methods, dates, and amounts

## SQL Topics Covered

### DML

-   UPDATE
-   DELETE
-   Updating customer information, prices, stock, orders, and payments
-   Foreign-key constraint behavior

### SELECT & Filtering

-   SELECT, WHERE, DISTINCT
-   IN, BETWEEN, LIKE
-   ORDER BY, LIMIT

### Aggregate Functions

-   COUNT(), SUM(), AVG(), MAX(), MIN()
-   GROUP BY and HAVING

### JOINs

-   INNER JOIN
-   LEFT JOIN
-   RIGHT JOIN
-   CROSS JOIN
-   SELF JOIN
-   FULL OUTER JOIN simulation in MySQL
-   Finding unmatched records

### Subqueries

-   Scalar and multi-row subqueries
-   Correlated subqueries
-   IN / NOT IN
-   EXISTS / NOT EXISTS

### CTEs

-   Customer spending
-   Monthly sales
-   Product revenue
-   Customer ranking
-   Latest payments and first orders
-   Multi-CTE analytical reports

### Window Functions

-   ROW_NUMBER()
-   RANK()
-   DENSE_RANK()
-   LAG()
-   LEAD()
-   PARTITION BY

### Views

Views are used for customer details, orders, inventory, payments,
purchase summaries, delivered orders, products without orders, and
monthly sales.

### CASE Expressions

Business classifications include customer age groups, product price
groups, stock status, payment categories, customer spending tiers,
revenue categories, and payment growth.

## Business Questions Covered

-   Which customer spent the most?
-   Which product generated the highest revenue?
-   Which city generated the highest sales?
-   Which products were never ordered?
-   Which customers never placed an order?
-   Which customers spent more than the average customer?
-   Which products are priced above their category average?
-   What is the highest-priced product in each category?
-   What is each customer's latest order?
-   How does monthly revenue compare with the previous month?
-   How can customers be classified based on spending?


## Skills Demonstrated

-   SQL query writing
-   Relational database analysis
-   Data filtering and aggregation
-   Multi-table joins
-   Subquery and correlated subquery design
-   CTEs
-   Window functions
-   Views
-   Conditional logic with CASE
-   Business-oriented data analysis

## Tools

-   MySQL
-   MySQL Workbench
-   Git / GitLab


## Project Purpose

This project was created as hands-on SQL practice with progressively
increasing difficulty, moving from basic queries to advanced analytical
SQL. It demonstrates the ability to translate business questions into
SQL queries and work with relational data across multiple connected
tables.


## Author

**Avinash Kumar**

Aspiring Data Analyst