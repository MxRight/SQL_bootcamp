SELECT name, (name = 'Denis') AS check_name
FROM (
	SELECT (
		SELECT p.name
		FROM person p
		WHERE p.id = o.person_id
		) AS name	
	FROM person_order o
WHERE menu_id = ANY(ARRAY[13, 14, 18]) AND order_date = '2022-01-07'
) AS sub;