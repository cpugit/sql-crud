SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.price * o.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;
--
SELECT c.*
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
--
SELECT 
    p.product_id,
    p.product_name,
    SUM(o.quantity) AS total_sold
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 1;
--
SELECT *
FROM (
    SELECT 
        p.product_name,
        SUM(o.quantity) AS total_sold,
        ROW_NUMBER() OVER (ORDER BY SUM(o.quantity) DESC) AS rn
    FROM products p
    JOIN orders o ON p.product_id = o.product_id
    GROUP BY p.product_name
) t
WHERE rn <= 3;
--
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.price * o.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(p.price * o.quantity) > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(p.price * o.quantity) AS total
        FROM orders o
        JOIN products p ON o.product_id = p.product_id
        GROUP BY o.customer_id
    ) sub
);
--
SELECT p.product_name, c.first_name, c.last_name
FROM products p
JOIN orders o ON p.product_id = o.product_id
JOIN customers c ON o.customer_id = c.customer_id;

SELECT * FROM products
WHERE price > 1.0;
--
SELECT c.customer_id, c.first_name, c.last_name, SUM(o.quantity) AS total_items
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_items DESC
LIMIT 5;
--
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;
