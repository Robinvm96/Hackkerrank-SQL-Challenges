WITH 
submissions_aggregated AS(
    SELECT challenge_id, SUM(total_submissions) AS total_submissions, SUM(total_accepted_submissions) AS total_accepted_submissions FROM Submission_Stats
    GROUP BY challenge_id
    ),
    
views_aggregated AS(
    SELECT challenge_id, SUM(total_views) AS total_views,SUM(total_unique_views) AS total_unique_views FROM View_Stats
    GROUP BY challenge_id
    ),


lu_challenge_contest_hacker AS(
    SELECT chal.challenge_id,col.contest_id,con.hacker_id,con.name FROM Challenges AS chal
    INNER JOIN Colleges AS col
    on col.college_id = chal.college_id
    INNER JOIN Contests AS con
    on con.contest_id = col.contest_id
    ),

joined_submissions AS (
SELECT l.contest_id,l.hacker_id,l.name,SUM(s.total_submissions) AS total_submissions,SUM(s.total_accepted_submissions) AS total_accepted_submissions FROM submissions_aggregated AS s
INNER JOIN lu_challenge_contest_hacker AS l
ON l.challenge_id=s.challenge_id
GROUP BY l.contest_id,l.hacker_id,l.name),

joined_views AS (
SELECT l.contest_id,l.hacker_id,l.name,SUM(v.total_views) AS total_views,SUM(v.total_unique_views) AS total_unique_views FROM views_aggregated AS v
INNER JOIN lu_challenge_contest_hacker AS l
ON l.challenge_id=v.challenge_id
GROUP BY l.contest_id,l.hacker_id,l.name)

SELECT s.contest_id,s.hacker_id,s.name,s.total_submissions,s.total_accepted_submissions, v.total_views,v.total_unique_views
FROM joined_submissions AS s
INNER JOIN joined_views AS v
ON s.contest_id=v.contest_id
AND s.hacker_id=v.hacker_id
AND s.name = v.name
WHERE NOT (s.total_submissions=0 AND s.total_accepted_submissions=0 AND v.total_views=0 AND v.total_unique_views=0)
ORDER BY s.contest_id;
