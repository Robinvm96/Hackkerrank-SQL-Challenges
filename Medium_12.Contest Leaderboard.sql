WITH max_table AS
    (SELECT hacker_id, challenge_id, MAX(score) AS total_score FROM Submissions GROUP BY hacker_id, challenge_id)

SELECT m.hacker_id, h.name, SUM(total_score) AS total_score FROM max_table AS m
INNER JOIN Hackers AS h
ON h.hacker_id = m.hacker_id
GROUP BY m.hacker_id, h.name
HAVING SUM(total_score)>1
ORDER BY total_score DESC, hacker_id ASC
