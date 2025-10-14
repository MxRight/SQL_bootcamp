INSERT INTO person_visits(id, person_id, pizzeria_id, visit_date)
VALUES 
((SELECT MAX(id) + 1 FROM person_visits),
	(SELECT p.id FROM person p WHERE p.name = 'Denis'),
	(SELECT pz.id FROM pizzeria pz WHERE pz.name = 'Dominos'),
	DATE '2022-02-24'),
	
	((SELECT MAX(id) + 2 FROM person_visits),
	(SELECT p.id FROM person p WHERE p.name = 'Irina'),
	(SELECT pz.id FROM pizzeria pz WHERE pz.name = 'Dominos'),
	DATE '2022-02-24');