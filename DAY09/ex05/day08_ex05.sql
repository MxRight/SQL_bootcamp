--Сессия 1:
SHOW TRANSACTION ISOLATION LEVEL;
BEGIN;

--Сессия 2:
SHOW TRANSACTION ISOLATION LEVEL;
BEGIN;

--Сессия 1:
SELECT SUM(rating) FROM pizzeria;

--Сессия 2:
INSERT INTO pizzeria VALUES (10, 'Kazan Pizza', 5);
COMMIT;

--Сессия 1:
SELECT SUM(rating) FROM pizzeria;
-- сумма изменилась таким образом, «фантомная» строка повлияла на результат.