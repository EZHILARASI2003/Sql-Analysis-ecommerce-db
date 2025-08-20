SHOW DATABASES;
USE ecommerce_db;
SHOW TABLES;
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (customer_name, email, city) VALUES
('Alice', 'alice@example.com', 'Chennai'),
('Bob', 'bob@example.com', 'Mumbai'),
('Charlie', 'charlie@example.com', 'Delhi');

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 60000.00),
('Headphones', 'Electronics', 2000.00),
('Shoes', 'Fashion', 2500.00);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-08-01', 62000.00),  -- 1 Laptop (60000) + 1 Headphones (2000)
(2, '2025-08-05', 4000.00),   -- 2 Headphones (2*2000)
(1, '2025-08-10', 2500.00);   -- 1 Shoes (2500)

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 60000.00),
(1, 2, 1, 2000.00),
(2, 2, 2, 2000.00),
(3, 3, 1, 2500.00);

SELECT order_id, order_date, customer_id, total_amount
FROM orders
WHERE total_amount > 0
ORDER BY order_date DESC
LIMIT 10;

SELECT DATE_FORMAT(order_date, '%Y-%m-01') AS month,
       SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
ORDER BY month;

SELECT AVG(total_amount) AS avg_order_value
FROM orders;

SELECT p.category,
       SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
INNER JOIN products p ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

SELECT c.customer_id, c.customer_name,
       COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

SELECT p.product_id, p.product_name,
       COALESCE(SUM(oi.quantity), 0) AS total_sold
FROM order_items oi
RIGHT JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC, p.product_id;

SELECT customer_id, total_spent
FROM (
    SELECT o.customer_id, SUM(o.total_amount) AS total_spent
    FROM orders o
    GROUP BY o.customer_id
) t
WHERE total_spent > (
    SELECT AVG(total_spent) 
    FROM (
        SELECT SUM(total_amount) AS total_spent
        FROM orders
        GROUP BY customer_id
    ) x
)
ORDER BY total_spent DESC;

DROP VIEW IF EXISTS vw_daily_revenue;
CREATE OR REPLACE VIEW vw_daily_revenue AS
SELECT DATE(order_date) AS day,
       SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE(order_date);

SELECT * FROM vw_daily_revenue ORDER BY day;

CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);