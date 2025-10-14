SELECT day::DATE AS missing_date
FROM generate_series(DATE '2022-01-01', DATE '2022-01-10', '1 day') AS day
LEFT JOIN person_visits pv 
ON pv.visit_date = day AND (pv.person_id=1 OR pv.person_id=2)
WHERE pv.visit_date IS NULL
ORDER BY missing_date;