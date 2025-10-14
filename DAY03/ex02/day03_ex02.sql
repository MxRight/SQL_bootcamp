WITH bad_pizzas AS 
	(SELECT m.id AS menu_id 
	FROM menu m
	EXCEPT
	SELECT menu_id
	FROM person_order)

SELECT m.pizza_name, m.price, pz.name AS pizzeria_name
FROM bad_pizzas bp
JOIN menu m ON bp.menu_id = m.id
JOIN pizzeria pz ON pz.id = m.pizzeria_id
ORDER BY 1, 2;