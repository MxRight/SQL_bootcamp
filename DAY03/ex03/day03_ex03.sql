WITH visits AS (
SELECT pz.name AS pizzeria_name, p.gender
FROM person_visits pv
JOIN person p ON p.id = pv.person_id
JOIN pizzeria pz ON pz.id = pv.pizzeria_id
),
male AS (
SELECT pizzeria_name
FROM visits
GROUP BY pizzeria_name
HAVING COUNT(*) FILTER(WHERE gender = 'male') > COUNT(*) FILTER(WHERE gender = 'female')
),
female AS (
SELECT pizzeria_name
FROM visits
GROUP BY pizzeria_name
HAVING COUNT(*) FILTER(WHERE gender = 'female') > COUNT(*) FILTER(WHERE gender = 'male')
)

SELECT pizzeria_name
FROM male
UNION ALL
SELECT pizzeria_name
FROM female
ORDER BY 1;