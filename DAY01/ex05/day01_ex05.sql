SELECT ps.id AS "person.id", 
	ps.name AS "person.name",	
	ps.age,	ps.gender,	
	ps.address,	
	pz.id AS "pizzeria.id",	
	pz.name AS "pizzeria.name", 
	pz.rating
FROM person ps, pizzeria pz
ORDER BY ps, pz;