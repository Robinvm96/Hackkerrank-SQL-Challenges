WITH numbers AS
    (
        SELECT 1 as n
        UNION ALL
        SELECT n+1 FROM numbers
        WHERE n<100
        ),
lu AS (
        SELECT Grades.Grade AS Grade,numbers.n AS Marks FROM numbers 
        CROSS JOIN Grades
        WHERE numbers.n>=Grades.Min_Mark AND numbers.n<=Grades.Max_Mark
        )

SELECT CASE
    WHEN lu.Grade>=8 THEN Students.Name
    END
, lu.Grade, Students.Marks FROM Students
INNER JOIN lu
ON Students.Marks = lu.Marks
ORDER BY lu.Grade DESC,Students.Name ASC;
