SELECT *
FROM all_tours
WHERE total_cost = (SELECT MIN(total_cost) FROM all_tours)
UNION ALL 
SELECT * 
FROM all_tours
WHERE total_cost = (SELECT MAX(total_cost) FROM all_tours)
ORDER BY total_cost, tour;