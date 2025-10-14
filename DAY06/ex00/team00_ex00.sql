CREATE TABLE graph (
 point1 VARCHAR(1),
 point2 VARCHAR(1),
 cost INTEGER
);

INSERT INTO graph (point1, point2, cost) VALUES
('a','b', 10),
('b','a', 10),
('b','c', 35),
('c','b', 35),
('a','c', 15),
('c','a', 15),
('a','d', 20),
('d','a', 20),
('b','d', 25),
('d','b', 25),
('d','c', 30),
('c','d', 30);

CREATE VIEW all_tours AS (
	WITH RECURSIVE path (point, total_cost, tour) AS (
	    SELECT 
	        'a'::VARCHAR, 
	        0::INTEGER, 
	        ARRAY['a']::VARCHAR[]
	    UNION ALL
	    SELECT 
	        g.point2, 
	        p.total_cost + g.cost, 
	        p.tour || g.point2
	    FROM path p
	    JOIN graph g ON g.point1 = p.point
	    WHERE NOT (g.point2 = ANY(p.tour))
	)
    SELECT 
        p.total_cost + g.cost AS total_cost,
        p.tour || ARRAY['a'] AS tour
    FROM path p
    JOIN graph g 
        ON g.point1 = p.point 
       AND g.point2 = 'a'
    WHERE cardinality(tour) = 4
);

SELECT *
FROM all_tours
WHERE total_cost = (SELECT MIN(total_cost) FROM all_tours)
ORDER BY total_cost, tour;