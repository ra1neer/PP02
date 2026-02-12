-- Обновление статуса проекта ПВЗ
UPDATE pvz_projects
SET
    status = $2,
    updated_at = CURRENT_TIMESTAMP,
    end_date = CASE
        WHEN $2 = 'completed' THEN CURRENT_DATE
        ELSE end_date
    END
WHERE project_id = $1
RETURNING project_id, project_name, status, start_date, end_date;

-- Логирование изменения статуса
INSERT INTO project_status_history (
    project_id,
    old_status,
    new_status,
    changed_by,
    changed_at
)
SELECT
    $1,
    status,
    $2,
    $3,
    CURRENT_TIMESTAMP
FROM pvz_projects
WHERE project_id = $1;