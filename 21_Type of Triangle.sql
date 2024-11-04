SELECT 
CASE
    WHEN A=B AND A=C THEN 'Equilateral'
    WHEN A+B<=C OR A+C<=B OR B+C<=A THEN 'Not A Triangle'
    WHEN (A=B AND A!=C) OR (A!=B AND A=C) THEN 'Isosceles'
    WHEN A!=B AND A!=C AND B!=C THEN 'Scalene'
    END
FROM TRIANGLES;

'iMPORTANT: If onetime a Condition is true it will not be further checked
