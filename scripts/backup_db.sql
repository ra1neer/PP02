-- Бэкап данных ПВЗ за указанную дату
COPY (
    SELECT * FROM orders
    WHERE created_at >= CURRENT_DATE - INTERVAL '1 day'
) TO '/var/backups/pvz/orders_backup_${BACKUP_DATE}.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ';');

COPY (
    SELECT * FROM returns
    WHERE created_at >= CURRENT_DATE - INTERVAL '1 day'
) TO '/var/backups/pvz/returns_backup_${BACKUP_DATE}.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ';');

COPY (
    SELECT * FROM issuance_log
    WHERE created_at >= CURRENT_DATE - INTERVAL '1 day'
) TO '/var/backups/pvz/issuance_backup_${BACKUP_DATE}.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ';');

-- Логирование бэкапа
INSERT INTO backup_log (backup_date, tables, status, file_path)
VALUES (CURRENT_DATE, 'orders,returns,issuance_log', 'success', '/var/backups/pvz/');