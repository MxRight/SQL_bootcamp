SHOW TRANSACTION ISOLATION LEVEL;
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--Сессия 1:
BEGIN;

--Сессия 2:
BEGIN;

--Сессия 1:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 2:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 1:
UPDATE pizzeria
SET rating = 4
WHERE name = 'Pizza Hut';

--Сессия 2:
UPDATE pizzeria
SET rating = 3.6
WHERE name = 'Pizza Hut';
--ожидание завершения транзакции 1ой сессии

--Сессия 1:
COMMIT;

--Сессия 2:
-- ожидание завершено, данные обновлены
COMMIT;


--Сессия 1:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 2:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';


-- При последовательной фиксации двух транзакций, вторая транзакция ожидаемо затерла изменения первой транзакции