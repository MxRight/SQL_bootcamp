WITH visits AS (
    SELECT pz.name,
           COUNT(*) AS count
    FROM person_visits pv
    JOIN pizzeria pz ON pz.id = pv.pizzeria_id
    GROUP BY pz.name
),
orders AS (
    SELECT pz.name,
           COUNT(*) AS count
    FROM person_order po
    JOIN menu m ON m.id = po.menu_id
    JOIN pizzeria pz ON pz.id = m.pizzeria_id
    GROUP BY pz.name

)
SELECT name, SUM(count) AS total_count
FROM (
	SELECT name, count
	FROM visits
	UNION ALL
	SELECT name, count
	FROM orders) AS combined
GROUP BY name
ORDER BY total_count DESC, name;