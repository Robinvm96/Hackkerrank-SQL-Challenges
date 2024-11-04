SELECT DISTINCT CITY FROM STATION WHERE LEFT(LOWER(CITY),1) in ('a','e','i','o','u') AND RIGHT(LOWER(CITY),1) in ('a','e','i','o','u');
