-- СОЗДАНИЕ БАЗЫ ДАННЫХ OZON.PVZ PRO
CREATE DATABASE ozon_pvz_pro
    WITH
    OWNER = ozon_admin
    ENCODING = 'UTF8'
    LC_COLLATE = 'ru_RU.UTF-8'
    LC_CTYPE = 'ru_RU.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = 100;

\c ozon_pvz_pro;

-- Расширение для UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Создание схемы
CREATE SCHEMA IF NOT EXISTS pvz AUTHORIZATION ozon_admin;

-- Установка search_path
ALTER DATABASE ozon_pvz_pro SET search_path TO pvz, public;