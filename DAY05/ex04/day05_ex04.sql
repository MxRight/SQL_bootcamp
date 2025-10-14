CREATE UNIQUE INDEX idx_menu_unique ON menu (pizzeria_id, pizza_name);

SET enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT pizzeria_id, pizza_name
FROM menu
WHERE pizzeria_id = 1 AND pizza_name = 'pepperoni pizza';


/* 
Если индекс уникальный по нескольким колонкам, 
то комбинация значений должна быть уникальной, 
при этом каждая колонка сама по себе может содержать дубликаты.

Для примера попробуем добавить в меню пиццерии пицуу с тем же названием, пусть и по другой цене
и получим сообщение: duplicate key value violates unique constraint "idx_menu_unique"
Key (pizzeria_id, pizza_name)=(5, supreme pizza) already exists. 
*/

INSERT INTO
      menu (id, pizzeria_id, pizza_name, price)
VALUES
      (21,1,'pepperoni pizza', 1400);