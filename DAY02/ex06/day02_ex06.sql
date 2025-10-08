SELECT m.pizza_name, p.name AS pizzeria_name
FROM person_order AS po
JOIN menu m ON po.menu_id = m.id
JOIN person prsn ON po.person_id = prsn.id
JOIN pizzeria p ON p.id = m.pizzeria_id
WHERE prsn.name IN ('Denis', 'Anna')
ORDER BY m.pizza_name, pizzeria_name;