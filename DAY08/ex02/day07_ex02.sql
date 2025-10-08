WITH top_visits AS (
    SELECT pz.name,
           COUNT(*) AS count,
           'visit' AS action_type
    FROM person_visits pv
    JOIN pizzeria pz ON pz.id = pv.pizzeria_id
    GROUP BY pz.name
    ORDER BY count DESC
    LIMIT 3
),
top_orders AS (
    SELECT pz.name,
           COUNT(*) AS count,
           'order' AS action_type
    FROM person_order po
    JOIN menu m ON m.id = po.menu_id
    JOIN pizzeria pz ON pz.id = m.pizzeria_id
    GROUP BY pz.name
    ORDER BY count DESC
    LIMIT 3
)
SELECT name, count, action_type
FROM top_visits
UNION ALL
SELECT name, count, action_type
FROM top_orders
ORDER BY action_type ASC, count DESC;