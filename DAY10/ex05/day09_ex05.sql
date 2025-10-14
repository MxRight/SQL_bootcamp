DROP FUNCTION IF EXISTS fnc_persons_female();
DROP FUNCTION IF EXISTS fnc_persons_male();

CREATE OR REPLACE FUNCTION fnc_persons(pgender text DEFAULT 'female')
RETURNS SETOF person AS
$$
BEGIN
    RETURN QUERY
    SELECT * FROM person
    WHERE gender = pgender;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fnc_persons(pgender := 'male');
SELECT * FROM fnc_persons();