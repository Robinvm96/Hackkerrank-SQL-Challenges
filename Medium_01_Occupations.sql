WITH
Concat AS 
(SELECT ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name) AS ID,Name,Occupation FROM OCCUPATIONS WHERE Occupation='Doctor'
UNION
SELECT ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name) AS ID,Name,Occupation FROM OCCUPATIONS WHERE Occupation='Professor'
UNION
SELECT ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name) AS ID,Name,Occupation FROM OCCUPATIONS WHERE Occupation='Singer'
UNION
SELECT ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name) AS ID,Name,Occupation FROM OCCUPATIONS WHERE Occupation='Actor'),

Pivot_concat AS ( SELECT ID, [Doctor] AS Doctor,[Professor] AS Professor, [Singer] AS Singer, [Actor] AS Actor FROM Concat
                PIVOT 
                 (MAX(Name) 
                  FOR Occupation IN ([Doctor],[Professor],[Singer],[Actor])
                 ) AS Pivottable
                )

SELECT Doctor,Professor,Singer,Actor FROM Pivot_concat;
