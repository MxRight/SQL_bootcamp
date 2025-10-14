SELECT m.pizza_name, m.price, pz.name AS pizzeria_name, pv.visit_date
FROM person_visits pv
JOIN person p ON pv.person_id = p.id
JOIN pizzeria pz ON pz.id = pv.pizzeria_id
JOIN menu m ON m.pizzeria_id = pz.id
WHERE p.name = 'Kate' AND m.price BETWEEN 800 AND 1000
ORDER BY 1, 2, 3;