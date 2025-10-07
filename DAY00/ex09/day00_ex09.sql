SELECT 
    (SELECT name FROM person p WHERE pv.person_id = p.id) AS person_name,
    (SELECT name FROM pizzeria pz WHERE pv.pizzeria_id = pz.id) AS pizzeria_name
FROM (SELECT pizzeria_id, person_id FROM person_visits WHERE visit_date BETWEEN '2022-01-07' AND '2022-01-09') AS pv
ORDER BY person_name ASC, pizzeria_name DESC;