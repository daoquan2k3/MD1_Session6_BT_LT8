drop table ss6_lt8.orders;
drop table ss6_lt8.customers;

CREATE TABLE ss6_lt8.orders (
                                id serial primary key ,
                                customer_id int REFERENCES ss6_lt8.customers(id),
                                order_date DATE,
                                total_amount NUMERIC(10,2)
);

CREATE TABLE ss6_lt8.customers (
    id serial primary key ,
    name VARCHAR(100)
);

--1
SELECT
    c.name,
    SUM(o.total_amount) as total_revenue
FROM ss6_lt8.customers c
JOIN ss6_lt8.orders o on c.id = o.customer_id
GROUP BY c.id
ORDER BY total_revenue desc ;

--2
SELECT
    c.name,
    SUM(o.total_amount) as total_revenue
FROM ss6_lt8.customers c
JOIN ss6_lt8.orders o on c.id = o.customer_id
GROUP BY c.id
HAVING SUM(o.total_amount) = (SELECT MAX(o.total_amount) FROM ss6_lt8.orders o);

--3
SELECT
    c.name
FROM ss6_lt8.customers c
LEFT JOIN ss6_lt8.orders o on c.id = o.customer_id
WHERE o.total_amount isnull ;

--4
SELECT
    c.name,
    SUM(o.total_amount)
FROM ss6_lt8.customers c
JOIN ss6_lt8.orders o on c.id = o.customer_id
GROUP BY c.id
HAVING SUM(o.total_amount) > all(SELECT AVG(o.total_amount) from ss6_lt8.orders o);