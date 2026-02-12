-- Восстановление базы из бэкапа
BEGIN;

-- Очистка таблиц перед восстановлением
TRUNCATE TABLE orders, returns, issuance_log, clients CASCADE;

-- Восстановление заказов
COPY orders(order_id, pvz_code, client_phone, amount, status, created_at, issued_at)
FROM '/var/backups/pvz/orders_backup_${RESTORE_DATE}.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ';');

-- Восстановление возвратов
COPY returns(return_id, order_id, client_phone, amount, reason, act_number, created_at)
FROM '/var/backups/pvz/returns_backup_${RESTORE_DATE}.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ';');

-- Восстановление логов выдачи
COPY issuance_log(log_id, order_id, employee_id, cis_code, created_at)
FROM '/var/backups/pvz/issuance_backup_${RESTORE_DATE}.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ';');

COMMIT;

-- Валидация восстановления
SELECT 'orders' AS table_name, COUNT(*) AS records FROM orders
UNION ALL
SELECT 'returns', COUNT(*) FROM returns
UNION ALL
SELECT 'issuance_log', COUNT(*) FROM issuance_log;