SELECT tmp.action_date, p.name AS person_name
FROM
	(SELECT order_date AS action_date, person_id
	FROM person_order
	INTERSECT
	SELECT visit_date AS action_date, person_id
	FROM person_visits) tmp
JOIN person p ON tmp.person_id = p.id
ORDER BY action_date ASC, person_name DESC;