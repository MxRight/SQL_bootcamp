SELECT p.name AS person_name, m.pizza_name, pz.name AS pizzeria_name 
FROM person_order po
JOIN person p ON p.id = po.person_id
JOIN menu m ON m.id = po.menu_id
JOIN pizzeria pz ON pz.id = m.pizzeria_id
ORDER BY person_name, pizza_name, pizzeria_name;