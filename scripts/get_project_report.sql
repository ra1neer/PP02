-- Отчет по проекту ПВЗ: эффективность, заказы, возвраты
SELECT
    p.project_name,
    p.pvz_code,
    p.start_date,
    p.status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT CASE WHEN o.status = 'issued' THEN o.order_id END) AS issued_orders,
    COUNT(DISTINCT CASE WHEN o.status = 'returned' THEN o.order_id END) AS returned_orders,
    AVG(o.issue_duration_seconds) AS avg_issue_time,
    SUM(o.amount) AS total_revenue,
    COUNT(DISTINCT e.employee_id) AS employees_count
FROM pvz_projects p
LEFT JOIN orders o ON o.pvz_code = p.pvz_code
    AND o.created_at BETWEEN p.start_date AND COALESCE(p.end_date, CURRENT_DATE)
LEFT JOIN project_employees e ON e.project_id = p.project_id
WHERE p.project_id = $1
GROUP BY p.project_id, p.project_name, p.pvz_code, p.start_date, p.status;