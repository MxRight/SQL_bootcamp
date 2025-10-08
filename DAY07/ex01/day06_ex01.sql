--DELETE FROM person_discounts;

WITH last_id AS (
    SELECT COALESCE(MAX(id), 0) AS id
    FROM person_discounts
),
orders AS (
    SELECT po.person_id,
           m.pizzeria_id,
           COUNT(*) AS quantity
    FROM person_order po
    JOIN menu m ON po.menu_id = m.id
    GROUP BY po.person_id, m.pizzeria_id
)
INSERT INTO person_discounts (id, person_id, pizzeria_id, discount)
SELECT last_id.id + ROW_NUMBER() OVER (ORDER BY o.person_id, o.pizzeria_id) AS id,
       o.person_id,
       o.pizzeria_id,
       CASE
           WHEN o.quantity = 1 THEN 10.5
           WHEN o.quantity = 2 THEN 22
           ELSE 30
       END AS discount
FROM orders o
CROSS JOIN last_id;

--SELECT * FROM person_discounts;