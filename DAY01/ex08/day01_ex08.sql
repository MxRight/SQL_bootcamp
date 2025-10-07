SELECT order_date, (p.name || ' (age:' || p.age || ')') AS person_information 
FROM person_order o
NATURAL JOIN person p(person_id)
ORDER BY order_date, person_information;