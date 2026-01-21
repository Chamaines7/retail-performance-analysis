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


-- Average Ticket Value


-- Labor Cost %
SELECT
    s.store_name,
    ROUND(
        SUM(l.labor_cost) / SUM(t.quantity * p.price) * 100,
        2
    ) AS labor_pct
FROM labor l
JOIN stores s ON l.store_id = s.store_id
JOIN transactions t ON s.store_id = t.store_id
JOIN products p ON t.product_id = p.product_id
GROUP BY s.store_name
ORDER BY labor_pct DESC;

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

-- Week-over-Week Trends
SELECT
    DATE_TRUNC('week', t.transaction_date) AS week,
    SUM(t.quantity * p.price) AS weekly_revenue
FROM transactions t
JOIN products p ON t.product_id = p.product_id
GROUP BY week
ORDER BY week;


