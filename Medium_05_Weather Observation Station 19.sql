SELECT CAST(POWER((POWER((MAX(LAT_N)-MIN(LAT_N)),2)+POWER((MAX(LONG_W)-MIN(LONG_W)),2)),0.5) AS DECIMAL(10,4)) FROM STATION;
