--Aggregate expressions that appear in WHEN arguments to a CASE expression 
--are evaluated first, then provided to the CASE expression. 
--For example, the following query produces a divide by zero error 
--when producing the value of the MAX aggregate.
--This occurs prior to evaluating the CASE expression.

WITH Data (value)
AS (
    SELECT 0
    UNION ALL
    SELECT 1
    )
SELECT CASE
        WHEN MIN(value) <= 0 THEN 0
        WHEN MAX(1 / value) >= 100 THEN 1
        END
FROM Data;
GO