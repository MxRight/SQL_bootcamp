WITH orders AS (
SELECT pz.name AS pizzeria_name, p.gender
FROM person_order po
JOIN person p ON p.id = po.person_id
JOIN menu m ON m.id = po.menu_id
JOIN pizzeria pz ON pz.id = m.pizzeria_id
),
male AS (
SELECT pizzeria_name
FROM orders
GROUP BY pizzeria_name
HAVING COUNT(*) FILTER(WHERE gender = 'male') = COUNT(*)
),
female AS (
SELECT pizzeria_name
FROM orders
GROUP BY pizzeria_name
HAVING COUNT(*) FILTER(WHERE gender = 'female') = COUNT(*)
)

SELECT pizzeria_name
FROM male
UNION
SELECT pizzeria_name
FROM female
ORDER BY 1;