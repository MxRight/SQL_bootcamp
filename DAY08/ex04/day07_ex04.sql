SELECT 
	name, 
	COUNT(*) AS count_of_visits 
FROM person_visits pv
JOIN person p ON p.id = pv.person_id
GROUP BY pv.person_id, p.name
HAVING COUNT(*) > 3;