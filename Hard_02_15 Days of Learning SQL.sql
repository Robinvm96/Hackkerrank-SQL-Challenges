WITH combined AS (
        SELECT 
        h.hacker_id,
        h.name,
        s.submission_date,
        COUNT(s.submission_id) AS cnt
    FROM Hackers AS h
    INNER JOIN Submissions AS s
    ON s.hacker_id = h.hacker_id
    GROUP BY h.hacker_id,h.name,s.submission_date
),

ranks AS (
    SELECT 
        ROW_NUMBER() OVER(PARTITION BY submission_date ORDER BY cnt DESC,hacker_id ASC) as rank,
        hacker_id,
        name,
        submission_date
    FROM combined),

sol_1 AS (
    SELECT 
        submission_date,
        hacker_id,
        name
    FROM ranks
    WHERE rank=1),
    
all_hid_dates AS (
    SELECT DISTINCT 
        c1.hacker_id,
        c2.submission_date 
    FROM combined AS c1
    CROSS JOIN combined AS c2),
    
overview_submission AS (
    SELECT 
        a.hacker_id,
        a.submission_date,
        CASE
            WHEN c.submission_date is null THEN 0 ELSE 1
        END AS tf_sub
    FROM all_hid_dates AS a
    LEFT OUTER JOIN combined AS c
        ON c.hacker_id = a.hacker_id
        AND c.submission_date = a.submission_date),
 
sol_2_bridge1 AS (
    SELECT
        hacker_id,
        submission_date,
        SUM(tf_sub) OVER (PARTITION BY hacker_id ORDER BY submission_date) AS run_sum,
        DATEDIFF(day,'2016-03-01',submission_date)+1 AS day_diff
    FROM overview_submission),

sol_2 AS (
    SELECT 
        submission_date,
        COUNT(DISTINCT hacker_id) AS unique_submitters
    FROM sol_2_bridge1
    WHERE run_sum=day_diff
    GROUP BY submission_date)

SELECT 
    sol_1.submission_date,
    sol_2.unique_submitters,
    sol_1.hacker_id,
    sol_1.name
FROM sol_2
INNER JOIN sol_1
ON sol_1.submission_date=sol_2.submission_date
ORDER BY submission_date;
