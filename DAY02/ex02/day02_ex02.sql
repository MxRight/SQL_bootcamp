WITH visit_filtered AS (
	SELECT * FROM person_visits
	WHERE visit_date BETWEEN DATE '2022-01-01' AND DATE '2022-01-03'
)

SELECT 
	COALESCE(p.name, '-') AS person_name, 
	COALESCE(vf.visit_date::TEXT, 'null') AS visit_date, 
	COALESCE(pz.name,'-') AS pizzeria_name
FROM person p
FULL JOIN visit_filtered vf ON p.id = vf.person_id
FULL JOIN pizzeria pz ON pz.id = vf.pizzeria_id
ORDER BY person_name, visit_date, pizzeria_name;