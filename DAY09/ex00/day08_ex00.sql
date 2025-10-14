SHOW default_transaction_isolation;
--BEGIN ISOLATION LEVEL READ COMMITTED; -- уже стоит по умолчанию

-- уровень изоляции READ UNCOMMITTED в PostgreSQL практически идентичен уровню READ COMMITED, 
-- т.к. реализация уровня изоляции READ UNCOMMITTED в PostgreSQL более строгая, чем того требует стандарт языка SQL

--Сессия 1:
BEGIN;
UPDATE pizzeria
SET rating = 5
WHERE name = 'Pizza Hut';
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 2:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 1:
COMMIT;

--Сессия 2:
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';