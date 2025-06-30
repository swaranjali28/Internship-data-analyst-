use pizzadb;
-- 1.  Create Tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers VALUES
(1, 'Swara', 'swara@gmail.com'),
(2, 'Aryan', 'aryan@yahoo.com'),
(3, 'Kiara', 'kiara@outlook.com');

INSERT INTO products VALUES
(101, 'Laptop', 75000.00),
(102, 'Smartphone', 25000.00),
(103, 'Headphones', 3000.00);

INSERT INTO orders VALUES
(201, 1, '2024-06-01'),
(202, 2, '2024-06-02'),
(203, 1, '2024-06-05'),
(204, 3, '2024-06-10');

INSERT INTO order_items VALUES
(301, 201, 101, 1, 75000.00),
(302, 202, 102, 2, 25000.00),
(303, 203, 103, 3, 3000.00),
(304, 204, 101, 1, 75000.00);


SELECT c.customer_name, SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


SELECT o.order_id, c.customer_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- RIGHT JOIN (only works in some RDBMS like PostgreSQL, not SQLite)
-- SELECT c.customer_name, o.order_id
-- FROM customers c
-- RIGHT JOIN orders o ON c.customer_id = o.customer_id;

SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
);


SELECT c.customer_name, AVG(oi.quantity * oi.unit_price) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name;

-- 7. 🪄 Create a View
CREATE VIEW product_sales AS
SELECT p.product_name, SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name;


SELECT * FROM product_sales;


CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_product_id ON order_items(product_id);
CREATE INDEX idx_order_id ON order_items(order_id);

