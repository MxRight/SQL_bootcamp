SELECT 
	(SELECT name 
	FROM person p
	WHERE o.person_id = p.id
	) as name
FROM person_order o  
WHERE menu_id = ANY(ARRAY[13, 14, 18]) AND order_date = '2022-01-07';