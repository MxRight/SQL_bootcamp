CREATE OR REPLACE FUNCTION func_minimum(arr NUMERIC[])
RETURNS NUMERIC AS
$$
    SELECT MIN(val) 
    FROM unnest(arr) AS val; --встроенная функция PostgreSQL, 
	--разворачивает массив в строки и создаёт таблицу с колонкой val
$$ LANGUAGE sql;


SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);