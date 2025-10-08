insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

WITH currency_rates AS (
    SELECT 
        b.user_id,
        b.money,
        b.currency_id,
        b.updated as balance_updated,
    	-- самый близкий курс в прошлом
        (SELECT rate_to_usd FROM currency c 
         WHERE c.id = b.currency_id AND c.updated <= b.updated 
         ORDER BY c.updated DESC LIMIT 1) as past_rate,
    	-- самый близкий курс в будущем
        (SELECT rate_to_usd FROM currency c 
         WHERE c.id = b.currency_id AND c.updated > b.updated 
         ORDER BY c.updated ASC LIMIT 1) as future_rate
    FROM balance b
),
final_rates AS (
    SELECT user_id, money, currency_id, balance_updated, COALESCE(past_rate, future_rate) AS final_rate
    FROM currency_rates
    WHERE COALESCE(past_rate, future_rate) IS NOT NULL
),
currency_names(id, name) AS (
	SELECT id, name 
	FROM currency
	GROUP BY id, name
)
SELECT 
    COALESCE(u.name, 'not defined') AS name,
    COALESCE(u.lastname, 'not defined') AS lastname,
    cn.name AS currency_name,
    (fr.money * fr.final_rate) AS currency_in_usd
FROM final_rates fr
LEFT JOIN "user" u ON u.id = fr.user_id
LEFT JOIN currency_names cn ON cn.id = fr.currency_id
ORDER BY name DESC, lastname ASC, currency_name ASC;