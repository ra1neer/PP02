-- Создание таблицы проектов ПВЗ
CREATE TABLE IF NOT EXISTS pvz_projects (
    project_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_name VARCHAR(255) NOT NULL,
    pvz_code VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(50) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы сотрудников проекта
CREATE TABLE IF NOT EXISTS project_employees (
    id SERIAL PRIMARY KEY,
    project_id UUID REFERENCES pvz_projects(project_id) ON DELETE CASCADE,
    employee_id VARCHAR(50) NOT NULL,
    role VARCHAR(100),
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Индексы
CREATE INDEX IF NOT EXISTS idx_pvz_projects_status ON pvz_projects(status);
CREATE INDEX IF NOT EXISTS idx_pvz_projects_pvz ON pvz_projects(pvz_code);