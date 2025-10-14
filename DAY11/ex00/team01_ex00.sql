WITH last_currency AS (
    SELECT DISTINCT ON (id) *
    FROM currency
    ORDER BY id, updated DESC
),
customers AS (
	SELECT 
		COALESCE(u.name, 'not defined') AS name, 
		COALESCE(u.lastname, 'not defined') AS lastname, 
		b.type,
		SUM(b.money) AS volume,
		COALESCE(c.name, 'not defined') AS currency_name,
		COALESCE(c.rate_to_usd, 1) AS last_rate_to_usd
	FROM balance b
	LEFT JOIN "user" u ON b.user_id = u.id
	LEFT JOIN last_currency c ON c.id = b.currency_id
	GROUP BY u.id, u.name, u.lastname, b.type, c.id, c.name, last_rate_to_usd
)

SELECT *, volume * last_rate_to_usd AS total_volume_in_usd 
FROM customers
ORDER BY name DESC, lastname ASC, type ASC;