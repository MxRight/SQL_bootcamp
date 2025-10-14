CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop int DEFAULT 10)
RETURNS TABLE (fib INT) AS
$$
DECLARE
	a INT := 0;
	b INT := 1;
	tmp INT;
BEGIN
   	WHILE a < pstop LOOP
	   fib := a;
	   RETURN NEXT;
	   tmp:= a + b;
	   a := b;
	   b := tmp;
	   END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fnc_fibonacci(100);
SELECT * FROM fnc_fibonacci();