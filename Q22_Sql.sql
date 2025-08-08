-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    address TEXT,
    phone VARCHAR(20)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- SAMPLE DATA --
-- Insert Customers
INSERT INTO customers VALUES
(1, 'aakriti pandey', 'aaku@email.com', '123 Main St, City', '555-0101'),
(2, 'aarati', 'aarati@email.com', '456 Oak Ave, Town', '555-0102'),
(3, 'aaku', 'aaku@email.com', '789 Pine Rd, Village', '555-0103');

-- Insert Products
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 999.99, 50),
(102, 'Mouse', 'Electronics', 29.99, 200),
(103, 'Keyboard', 'Electronics', 79.99, 150),
(104, 'Book', 'Education', 19.99, 100);

-- Insert Orders
INSERT INTO orders VALUES
(1001, 1, '2024-01-15 10:30:00', 1109.97, 'completed'),
(1002, 2, '2024-01-16 14:20:00', 49.98, 'pending'),
(1003, 1, '2024-01-17 09:15:00', 19.99, 'shipped');

-- Insert Order Items
INSERT INTO order_items VALUES
(1, 1001, 101, 1, 999.99),
(2, 1001, 102, 1, 29.99),
(3, 1001, 103, 1, 79.99),
(4, 1002, 102, 1, 29.99),
(5, 1002, 104, 1, 19.99),
(6, 1003, 104, 1, 19.99);
SELECT 
    c.name, 
    o.order_id, 
    o.order_date, 
    o.total_amount, 
    o.status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.order_date;
SELECT 
    p.name, 
    p.category,
    SUM(oi.quantity) as total_sold,
    SUM(oi.quantity * oi.unit_price) as total_revenue

FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name, p.category
ORDER BY total_revenue DESC;