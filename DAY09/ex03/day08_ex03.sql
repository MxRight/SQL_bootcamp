--Сессия 1:
SHOW TRANSACTION ISOLATION LEVEL;
BEGIN;

--Сессия 2:
SHOW TRANSACTION ISOLATION LEVEL;
BEGIN;

--Сессия 1:
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 2:
UPDATE pizzeria
SET rating = 3.6
WHERE name = 'Pizza Hut';
COMMIT;

--Сессия 1:
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';
-- на данном этапе возникает аномалия неповторяющегося чтения, 
--когда данные после транзакции во второй сессии, отображаются измененными до момента транзакции в первой сессии
COMMIT;
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';

--Сессия 2:
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';