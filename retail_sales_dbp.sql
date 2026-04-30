-- ============================================================
-- RETAIL SALES PERFORMANCE ANALYSIS
-- Full SQL Script: Schema + Data + Analysis + Views + Procedure + Indexes
-- Database: retail_sales_db
-- ============================================================


-- ============================================================
-- PART 1: SCHEMA
-- ============================================================

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL REFERENCES categories(category_id),
    product_name VARCHAR(150) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    created_at DATE DEFAULT CURRENT_DATE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    order_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(50) DEFAULT 'completed',
    payment_method VARCHAR(50)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL
);


-- ============================================================
-- PART 2: DATA
-- ============================================================

INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Gadgets, devices and accessories'),
('Clothing', 'Men and women apparel'),
('Home & Kitchen', 'Furniture, cookware and home essentials'),
('Books', 'Fiction, non-fiction and educational'),
('Sports & Fitness', 'Equipment and activewear');

INSERT INTO products (category_id, product_name, price, stock_quantity) VALUES
(1, 'Wireless Earbuds', 49.99, 200),
(1, 'Bluetooth Speaker', 79.99, 150),
(1, 'USB-C Hub', 34.99, 300),
(1, 'Laptop Stand', 29.99, 250),
(2, 'Men''s Polo Shirt', 24.99, 400),
(2, 'Women''s Hoodie', 39.99, 350),
(2, 'Jogger Pants', 34.99, 300),
(2, 'Sneakers', 59.99, 200),
(3, 'Non-stick Pan', 44.99, 180),
(3, 'Blender', 69.99, 120),
(3, 'Desk Lamp', 27.99, 220),
(3, 'Storage Organizer', 19.99, 400),
(4, 'Atomic Habits', 14.99, 500),
(4, 'Deep Work', 13.99, 450),
(4, 'SQL for Beginners', 19.99, 300),
(5, 'Resistance Bands', 15.99, 600),
(5, 'Yoga Mat', 29.99, 350),
(5, 'Dumbbell Set', 89.99, 100);

INSERT INTO customers (first_name, last_name, email, city, state, created_at) VALUES
('Chidi', 'Okonkwo', 'chidi.o@email.com', 'Lagos', 'Lagos', '2024-01-05'),
('Amara', 'Nwosu', 'amara.n@email.com', 'Abuja', 'FCT', '2024-01-10'),
('Tunde', 'Adeyemi', 'tunde.a@email.com', 'Ibadan', 'Oyo', '2024-01-15'),
('Ngozi', 'Eze', 'ngozi.e@email.com', 'Lagos', 'Lagos', '2024-01-20'),
('Emeka', 'Obi', 'emeka.o@email.com', 'Enugu', 'Enugu', '2024-02-01'),
('Fatima', 'Bello', 'fatima.b@email.com', 'Kano', 'Kano', '2024-02-05'),
('Yusuf', 'Musa', 'yusuf.m@email.com', 'Kaduna', 'Kaduna', '2024-02-10'),
('Sade', 'Ojo', 'sade.o@email.com', 'Lagos', 'Lagos', '2024-02-14'),
('Kelechi', 'Nwofor', 'kelechi.n@email.com', 'Port Harcourt', 'Rivers', '2024-02-20'),
('Blessing', 'Okoro', 'blessing.ok@email.com', 'Benin City', 'Edo', '2024-03-01'),
('Musa', 'Ibrahim', 'musa.i@email.com', 'Abuja', 'FCT', '2024-03-05'),
('Chioma', 'Igwe', 'chioma.i@email.com', 'Owerri', 'Imo', '2024-03-10'),
('Damilola', 'Afolabi', 'dami.a@email.com', 'Lagos', 'Lagos', '2024-03-15'),
('Zainab', 'Usman', 'zainab.u@email.com', 'Kano', 'Kano', '2024-03-20'),
('Ifeanyi', 'Chukwu', 'ifeanyi.c@email.com', 'Enugu', 'Enugu', '2024-04-01'),
('Adaeze', 'Okafor', 'adaeze.ok@email.com', 'Lagos', 'Lagos', '2024-04-05'),
('Rotimi', 'Fashola', 'rotimi.f@email.com', 'Ibadan', 'Oyo', '2024-04-10'),
('Halima', 'Garba', 'halima.g@email.com', 'Kaduna', 'Kaduna', '2024-04-15'),
('Obinna', 'Nnadi', 'obinna.n@email.com', 'Port Harcourt', 'Rivers', '2024-04-20'),
('Taiwo', 'Lawal', 'taiwo.l@email.com', 'Lagos', 'Lagos', '2024-05-01');

INSERT INTO orders (customer_id, order_date, status, payment_method) VALUES
(1, '2024-01-10', 'completed', 'card'),
(2, '2024-01-15', 'completed', 'transfer'),
(3, '2024-01-20', 'completed', 'card'),
(4, '2024-02-02', 'completed', 'cash'),
(5, '2024-02-10', 'returned', 'card'),
(6, '2024-02-14', 'completed', 'transfer'),
(7, '2024-02-20', 'completed', 'card'),
(8, '2024-03-01', 'completed', 'card'),
(9, '2024-03-05', 'completed', 'transfer'),
(10, '2024-03-10', 'completed', 'cash'),
(11, '2024-03-18', 'completed', 'card'),
(12, '2024-04-01', 'completed', 'transfer'),
(13, '2024-04-05', 'cancelled', 'card'),
(14, '2024-04-10', 'completed', 'card'),
(15, '2024-04-20', 'completed', 'cash'),
(16, '2024-05-01', 'completed', 'card'),
(17, '2024-05-10', 'completed', 'transfer'),
(18, '2024-05-15', 'completed', 'card'),
(19, '2024-05-20', 'completed', 'card'),
(20, '2024-06-01', 'completed', 'transfer'),
(1,  '2024-06-10', 'completed', 'card'),
(3,  '2024-06-15', 'completed', 'card'),
(5,  '2024-07-01', 'completed', 'transfer'),
(8,  '2024-07-05', 'completed', 'card'),
(10, '2024-07-12', 'completed', 'cash'),
(12, '2024-07-20', 'completed', 'card'),
(14, '2024-08-01', 'completed', 'transfer'),
(16, '2024-08-10', 'completed', 'card'),
(18, '2024-08-15', 'returned', 'card'),
(20, '2024-08-20', 'completed', 'transfer'),
(2,  '2024-09-01', 'completed', 'card'),
(4,  '2024-09-10', 'completed', 'cash'),
(6,  '2024-09-15', 'completed', 'card'),
(9,  '2024-09-20', 'completed', 'transfer'),
(11, '2024-10-01', 'completed', 'card'),
(13, '2024-10-10', 'completed', 'card'),
(15, '2024-10-15', 'completed', 'cash'),
(17, '2024-10-20', 'completed', 'transfer'),
(19, '2024-11-01', 'completed', 'card'),
(1,  '2024-11-10', 'completed', 'card'),
(7,  '2024-11-15', 'completed', 'transfer'),
(3,  '2024-11-20', 'completed', 'card'),
(5,  '2024-12-01', 'completed', 'card'),
(8,  '2024-12-05', 'completed', 'transfer'),
(10, '2024-12-10', 'completed', 'card'),
(12, '2024-12-15', 'completed', 'cash'),
(14, '2024-12-20', 'completed', 'card'),
(16, '2024-12-24', 'completed', 'transfer'),
(18, '2024-12-28', 'completed', 'card');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 49.99),(1, 13, 2, 14.99),
(2, 6, 1, 39.99),(2, 17, 1, 29.99),
(3, 10, 1, 69.99),(3, 9, 1, 44.99),
(4, 5, 2, 24.99),(4, 16, 3, 15.99),
(5, 8, 1, 59.99),
(6, 2, 1, 79.99),(6, 4, 1, 29.99),
(7, 11, 1, 27.99),(7, 12, 2, 19.99),
(8, 14, 1, 13.99),(8, 15, 1, 19.99),
(9, 18, 1, 89.99),
(10, 3, 1, 34.99),(10, 1, 1, 49.99),
(11, 7, 2, 34.99),(11, 5, 1, 24.99),
(12, 13, 3, 14.99),(12, 14, 2, 13.99),
(13, 6, 1, 39.99),
(14, 2, 1, 79.99),(14, 11, 1, 27.99),
(15, 16, 2, 15.99),(15, 17, 1, 29.99),
(16, 1, 2, 49.99),(16, 4, 1, 29.99),
(17, 9, 1, 44.99),(17, 10, 1, 69.99),
(18, 8, 1, 59.99),(18, 7, 1, 34.99),
(19, 15, 2, 19.99),(19, 13, 1, 14.99),
(20, 18, 1, 89.99),(20, 16, 3, 15.99),
(21, 1, 1, 49.99),(21, 2, 1, 79.99),
(22, 6, 2, 39.99),
(23, 17, 1, 29.99),(23, 18, 1, 89.99),
(24, 3, 2, 34.99),(24, 12, 1, 19.99),
(25, 5, 3, 24.99),
(26, 14, 2, 13.99),(26, 15, 1, 19.99),
(27, 11, 1, 27.99),(27, 9, 1, 44.99),
(28, 1, 1, 49.99),(28, 13, 3, 14.99),
(29, 8, 1, 59.99),
(30, 2, 1, 79.99),(30, 4, 2, 29.99),
(31, 7, 1, 34.99),(31, 16, 2, 15.99),
(32, 10, 1, 69.99),(32, 17, 1, 29.99),
(33, 6, 1, 39.99),(33, 5, 2, 24.99),
(34, 18, 1, 89.99),(34, 12, 2, 19.99),
(35, 3, 1, 34.99),(35, 1, 2, 49.99),
(36, 14, 1, 13.99),(36, 15, 2, 19.99),
(37, 9, 1, 44.99),(37, 11, 1, 27.99),
(38, 2, 1, 79.99),(38, 16, 3, 15.99),
(39, 13, 2, 14.99),(39, 7, 1, 34.99),
(40, 1, 1, 49.99),(40, 17, 1, 29.99),
(41, 18, 1, 89.99),(41, 8, 1, 59.99),
(42, 5, 2, 24.99),(42, 6, 1, 39.99),
(43, 10, 1, 69.99),(43, 9, 1, 44.99),
(44, 3, 2, 34.99),(44, 12, 1, 19.99),
(45, 1, 2, 49.99),(45, 2, 1, 79.99),
(46, 14, 3, 13.99),(46, 15, 1, 19.99),
(47, 7, 1, 34.99),(47, 16, 2, 15.99),
(48, 11, 1, 27.99),(48, 13, 2, 14.99),
(49, 18, 1, 89.99),(49, 6, 1, 39.99);


-- ============================================================
-- PART 3: ANALYSIS QUERIES
-- ============================================================

-- Total revenue by month
SELECT 
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY month
ORDER BY month;

-- Top 5 best-selling products by revenue
SELECT 
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- Revenue by state
SELECT 
    c.state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.state
ORDER BY total_revenue DESC;

-- Average order value
SELECT 
    ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
    SELECT 
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY o.order_id
) AS order_totals;

-- Month-over-month revenue growth (CTE + LAG)
WITH monthly_revenue AS (
    SELECT 
        TO_CHAR(o.order_date, 'YYYY-MM') AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY month
),
growth AS (
    SELECT 
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
        ROUND(
            (revenue - LAG(revenue) OVER (ORDER BY month)) 
            / LAG(revenue) OVER (ORDER BY month) * 100, 2
        ) AS growth_pct
    FROM monthly_revenue
)
SELECT * FROM growth;

-- Product revenue ranking (CTE + RANK + PARTITION BY)
WITH product_revenue AS (
    SELECT 
        p.product_name,
        c.category_name,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN categories c ON p.category_id = c.category_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY p.product_name, c.category_name
),
ranked AS (
    SELECT *,
        RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
        RANK() OVER (PARTITION BY category_name ORDER BY revenue DESC) AS rank_in_category
    FROM product_revenue
)
SELECT * FROM ranked
ORDER BY revenue_rank;

-- Customer segmentation (CTE + CASE)
WITH customer_spend AS (
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.city,
        c.state,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY c.customer_id, customer_name, c.city, c.state
)
SELECT *,
    CASE 
        WHEN total_spent >= 200 THEN 'High Value'
        WHEN total_spent >= 100 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_spend
ORDER BY total_spent DESC;


-- ============================================================
-- PART 4: VIEWS
-- ============================================================

CREATE VIEW vw_monthly_revenue AS
SELECT 
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    ROUND(AVG(oi.quantity * oi.unit_price), 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY month
ORDER BY month;

CREATE VIEW vw_product_performance AS
SELECT 
    p.product_name,
    c.category_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS revenue_rank
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_name, c.category_name;

CREATE VIEW vw_customer_segments AS
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    CASE 
        WHEN SUM(oi.quantity * oi.unit_price) >= 200 THEN 'High Value'
        WHEN SUM(oi.quantity * oi.unit_price) >= 100 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, customer_name, c.city, c.state;


-- ============================================================
-- PART 5: STORED PROCEDURE
-- ============================================================

CREATE OR REPLACE PROCEDURE generate_monthly_report(target_month VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_orders INT;
    v_total_revenue NUMERIC;
    v_avg_order_value NUMERIC;
    v_top_product VARCHAR;
    v_top_state VARCHAR;
BEGIN
    SELECT 
        COUNT(DISTINCT o.order_id),
        SUM(oi.quantity * oi.unit_price),
        ROUND(AVG(oi.quantity * oi.unit_price), 2)
    INTO v_total_orders, v_total_revenue, v_avg_order_value
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE TO_CHAR(o.order_date, 'YYYY-MM') = target_month
    AND o.status = 'completed';

    SELECT p.product_name
    INTO v_top_product
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE TO_CHAR(o.order_date, 'YYYY-MM') = target_month
    AND o.status = 'completed'
    GROUP BY p.product_name
    ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    LIMIT 1;

    SELECT c.state
    INTO v_top_state
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE TO_CHAR(o.order_date, 'YYYY-MM') = target_month
    AND o.status = 'completed'
    GROUP BY c.state
    ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    LIMIT 1;

    RAISE NOTICE '========== SALES REPORT: % ==========', target_month;
    RAISE NOTICE 'Total Orders      : %', v_total_orders;
    RAISE NOTICE 'Total Revenue     : %', v_total_revenue;
    RAISE NOTICE 'Avg Order Value   : %', v_avg_order_value;
    RAISE NOTICE 'Top Product       : %', v_top_product;
    RAISE NOTICE 'Top State         : %', v_top_state;
    RAISE NOTICE '=====================================';
END;
$$;

-- To run the procedure for any month:
-- CALL generate_monthly_report('2024-12');


-- ============================================================
-- PART 6: INDEXES
-- ============================================================

CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orderitems_order ON order_items(order_id);
CREATE INDEX idx_orderitems_product ON order_items(product_id);
