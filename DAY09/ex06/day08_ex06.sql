--Сессия 1:
BEGIN ISOLATION LEVEL REPEATABLE READ; 
SHOW TRANSACTION ISOLATION LEVEL;

--Сессия 2:
BEGIN ISOLATION LEVEL REPEATABLE READ; 
SHOW TRANSACTION ISOLATION LEVEL;

--Сессия 1:
SELECT SUM(rating) FROM pizzeria;

--Сессия 2:
INSERT INTO pizzeria VALUES (11, 'Kazan Pizza 2', 4);
COMMIT;

--Сессия 1:
SELECT SUM(rating) FROM pizzeria;
--сумма останется неизменной в рамках транзакции, так как поведение Repeatable Read защищает от «фантомов»
COMMIT;
SELECT SUM(rating) FROM pizzeria;

--Сессия 2:
SELECT SUM(rating) FROM pizzeria;