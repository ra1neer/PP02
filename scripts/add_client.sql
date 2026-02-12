-- Добавление нового клиента (или обновление существующего)
INSERT INTO clients (
    phone,
    full_name,
    passport_serial,
    passport_number,
    passport_issued_by,
    passport_issue_date,
    email,
    created_at
) VALUES (
    $1,  -- телефон
    $2,  -- ФИО
    $3,  -- серия паспорта
    $4,  -- номер паспорта
    $5,  -- кем выдан
    $6,  -- дата выдачи
    $7,  -- email
    CURRENT_TIMESTAMP
) ON CONFLICT (phone) DO UPDATE SET
    full_name = EXCLUDED.full_name,
    passport_serial = EXCLUDED.passport_serial,
    passport_number = EXCLUDED.passport_number,
    updated_at = CURRENT_TIMESTAMP
RETURNING client_id;