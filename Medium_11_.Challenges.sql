WITH combined AS (
SELECT h.hacker_id, h.name, COUNT(DISTINCT c.challenge_id) AS number_challenges FROM Hackers AS h
INNER JOIN Challenges AS c
ON h.hacker_id=c.hacker_id
GROUP BY h.hacker_id, h.name),

Ranked AS (
SELECT number_challenges,COUNT(hacker_id) AS cnt,
(SELECT MAX(number_challenges) FROM combined) AS max_value 
FROM combined
GROUP BY  number_challenges)

    SELECT hacker_id,name,number_challenges FROM Combined AS c
    WHERE number_challenges IN (SELECT number_challenges FROM Ranked WHERE cnt=1 OR (cnt!=1 AND number_challenges=max_value) )
    ORDER BY number_challenges DESC, hacker_id ASC;
