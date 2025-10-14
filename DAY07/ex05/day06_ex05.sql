COMMENT ON TABLE person_discounts IS 'Таблица хранит персональные скидки для клиентов в пиццериях';
COMMENT ON COLUMN person_discounts.id IS 'Уникальный идентификатор записи о скидке (первичный ключ)';
COMMENT ON COLUMN person_discounts.person_id IS 'Внешний ключ на таблицу person (ID клиента)';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Внешний ключ на таблицу pizzeria (ID пиццерии)';
COMMENT ON COLUMN person_discounts.discount IS 'Размер персональной скидки клиента в процентах (0-100)';