WITH Submission_agg AS (
SELECT hacker_id,challenge_id,MAX(score) AS score FROM Submissions
GROUP BY hacker_id,challenge_id),

Submission_agg_name AS (
    SELECT s.hacker_id,s.challenge_id,s.score, h.name FROM Submissions AS s
    INNER JOIN Hackers AS h
    on h.hacker_id=s.hacker_id),

sub_add_difflevel AS (
    SELECT s.hacker_id,s.challenge_id,s.score, s.name,c.difficulty_level FROM Submission_agg_name AS s
    INNER JOIN Challenges AS c
    on c.challenge_id = s.challenge_id
    ),
    
sub_fullscore AS (
    SELECT s.hacker_id,COUNT(DISTINCT s.challenge_id) AS cnt, s.name FROM sub_add_difflevel AS s
    INNER JOIN Difficulty AS d
    ON s.difficulty_level=d.difficulty_level
    WHERE s.score=d.score
    GROUP BY s.hacker_id,s.name
)

SELECT hacker_id, name FROM sub_fullscore
WHERE cnt>1
ORDER BY cnt DESC,hacker_id ASC;
