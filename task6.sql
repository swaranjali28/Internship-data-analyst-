use swara;
CREATE TABLE orders1 (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    product_id INT,
    quantity INT,
    amount DECIMAL(10, 2)
);

INSERT INTO orders1 (order_date, customer_id, product_id, quantity, amount) VALUES
('2024-01-03', 101, 1, 2, 200.00),
('2024-01-10', 102, 3, 1, 150.00),
('2024-01-15', 103, 2, 1, 100.00),
('2024-01-20', 104, 4, 3, 450.00),
('2024-01-27', 105, 2, 2, 200.00),

('2024-02-02', 106, 3, 1, 150.00),
('2024-02-09', 107, 1, 4, 400.00),
('2024-02-14', 108, 2, 2, 200.00),
('2024-02-21', 109, 4, 1, 100.00),
('2024-02-25', 110, 1, 2, 200.00),

('2024-03-03', 111, 3, 2, 300.00),
('2024-03-09', 112, 1, 1, 100.00),
('2024-03-13', 113, 4, 3, 450.00),
('2024-03-19', 114, 2, 1, 100.00),
('2024-03-27', 115, 1, 3, 300.00),

('2024-04-04', 116, 2, 2, 200.00),
('2024-04-08', 117, 4, 1, 150.00),
('2024-04-16', 118, 3, 2, 300.00),
('2024-04-22', 119, 1, 2, 200.00),
('2024-04-29', 120, 2, 1, 100.00),

('2024-05-03', 121, 4, 2, 300.00),
('2024-05-10', 122, 1, 1, 100.00),
('2024-05-14', 123, 2, 3, 300.00),
('2024-05-18', 124, 3, 1, 150.00),
('2024-05-27', 125, 1, 2, 200.00),

('2024-06-02', 126, 4, 1, 150.00),
('2024-06-06', 127, 2, 2, 200.00),
('2024-06-12', 128, 3, 1, 150.00),
('2024-06-19', 129, 1, 3, 300.00),
('2024-06-25', 130, 2, 1, 100.00);
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    orders1
GROUP BY 
    YEAR(order_date), MONTH(order_date)
ORDER BY 
    order_year, order_month;
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    orders1
WHERE 
    order_date BETWEEN '2024-01-01' AND '2024-06-30'  
GROUP BY 
    YEAR(order_date), MONTH(order_date)
ORDER BY 
    total_revenue DESC, total_orders DESC  
LIMIT 3;  