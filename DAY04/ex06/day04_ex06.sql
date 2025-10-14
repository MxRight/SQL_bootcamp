CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
	SELECT DISTINCT pz.name FROM person_visits pv
	JOIN person p ON p.id = pv.person_id
	JOIN pizzeria pz ON pz.id = pv.pizzeria_id
	JOIN menu m ON pz.id = m.pizzeria_id
	WHERE p.name ='Dmitriy' AND pv.visit_date = DATE '2022-01-08' AND m.price < 800;