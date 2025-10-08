--Сессия 1:
BEGIN;

--Сессия 2:
BEGIN;

--Сессия 1:
UPDATE pizzeria
SET rating = 1.0
WHERE id = 1;

--Сессия 2:
UPDATE pizzeria
SET rating = 1.0
WHERE id = 2;

--Сессия 1:
UPDATE pizzeria
SET rating = 1.2 
WHERE id = 2;

--Сессия 2:
UPDATE pizzeria
SET rating = 1.1
WHERE id = 1;
--ERROR:  deadlock detected
--PostgreSQL определит «патовую ситуацию» и завершит одну из транзакций с ошибкой DEADLOCK DETECTED.

--Сессия 1:
COMMIT;

--Сессия 2:
COMMIT;
--ROLLBACK

--Сессия 1:
SELECT * FROM pizzeria;

--Сессия 2:
SELECT * FROM pizzeria;