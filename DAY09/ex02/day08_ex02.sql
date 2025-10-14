--Сессия 1:
BEGIN ISOLATION LEVEL REPEATABLE READ; 
SHOW TRANSACTION ISOLATION LEVEL;

--Сессия 2:
BEGIN ISOLATION LEVEL REPEATABLE READ; 
SHOW TRANSACTION ISOLATION LEVEL;

--Сессия 1:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 2:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

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
--ERROR:  could not serialize access due to concurrent update
COMMIT;
--ROLLBACK

--Сессия 1:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 2:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';