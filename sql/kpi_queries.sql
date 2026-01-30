-- Revenue by Store
SELECT
	s.store_id,
	s.store_name,
	SUM(t.quantity * p.price) AS total_revenue
FROM transactions t
JOIN products p ON t.product_id = p.product_id
JOIN stores s ON t.store_id = s.store_id
GROUP BY s.store_id, s.store_name
ORDER BY total_revenue DESC;

-- Units per Transaction
SELECT 
	s.store_name,
	SUM(t.quantity) / COUNT(DISTINCT t.transaction_id)AS upt
FROM transactions t
JOIN stores s ON t.store_id = s.store_id
GROUP BY s.store_name
ORDER BY s.store_name ASC;

-- Average Ticket Value
SELECT 
	s.store_name,
	ROUND(
	SUM(t.quantity *p.price) / COUNT(DISTINCT t.transaction_id),
	2) 
	AS average_ticket_value
FROM transactions t
JOIN products p ON t.product_id = p.product_id
JOIN stores s ON t.store_id = s.store_id
GROUP BY s.store_name
ORDER BY average_ticket_value DESC;

-- Store vs Goal
SELECT
    s.store_name,
    SUM(t.quantity * p.price) AS actual_sales,
    s.monthly_sales_goal,
    SUM(t.quantity * p.price) - s.monthly_sales_goal AS variance
FROM transactions t
JOIN products p ON t.product_id = p.product_id
JOIN stores s ON t.store_id = s.store_id
GROUP BY s.store_name, s.monthly_sales_goal
ORDER BY variance DESC;



