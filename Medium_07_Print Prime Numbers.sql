WITH Numbers AS
    ( SELECT 2 AS num
    UNION ALL 
   SELECT num+1 FROM Numbers
    WHERE num<1001),
    
    primenum AS
    (SELECT num FROM Numbers AS n1
    WHERE NOT EXISTS
        (SELECT 1 FROM Numbers AS n2
        WHERE n1.num>n2.num
        AND n1.num>1
        AND n1.num%n2.num=0)
    )
   
SELECT STRING_AGG(CAST(num AS VARCHAR),'&') FROM primenum OPTION (MAXRECURSION 1001);
