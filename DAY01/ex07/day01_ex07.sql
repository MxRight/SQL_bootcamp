SELECT order_date, (p.name || ' (age:' || p.age || ')') AS person_information 
FROM person_order o
JOIN person p ON o.person_id = p.id
ORDER BY order_date, person_information;