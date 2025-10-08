--Сессия 1:
BEGIN ISOLATION LEVEL SERIALIZABLE;
SHOW TRANSACTION ISOLATION LEVEL;

--Сессия 2:
BEGIN ISOLATION LEVEL SERIALIZABLE;
SHOW TRANSACTION ISOLATION LEVEL;

--Сессия 1:
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 2:
UPDATE pizzeria
SET rating = 3.0
WHERE name = 'Pizza Hut';
COMMIT;

--Сессия 1:
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';
--PostgreSQL не даст Сессии №1 увидеть противоречивый результат на данном уровне изоляции
COMMIT;
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 2:
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';