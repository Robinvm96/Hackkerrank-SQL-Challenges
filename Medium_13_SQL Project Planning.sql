WITH switch_project AS (
SELECT Task_ID,Start_Date,End_Date, 
        CASE 
        WHEN LAG(End_Date,1) OVER(ORDER BY End_Date) = DATEADD(day,-1,End_Date) THEN 0
        ELSE 1 END AS tf_switch
FROM Projects),

id_projects AS (
    SELECT Task_ID,Start_Date,End_Date, SUM(tf_switch) OVER(ORDER BY End_Date) AS project_id FROM switch_project )

SELECT MIN(Start_Date) AS Start_date,MAX(End_Date) AS End_date FROM id_projects
GROUP BY project_id 
ORDER BY DATEDIFF(day,MIN(Start_Date),MAX(End_Date)) ASC, Start_date ASC;
