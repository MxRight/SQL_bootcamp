WITH stats AS (SELECT 
	address, 
	ROUND(MAX(age) - (MIN(age)/MAX(age)::NUMERIC),2) AS formula,
	ROUND(AVG(age),2) AS average
	FROM person
	GROUP BY address)

SELECT 
	address,
	formula,
	average,
	CASE
		WHEN formula > average THEN 'true'
		ELSE 'false'
	END AS comparison
FROM stats
ORDER by 1;