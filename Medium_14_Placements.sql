SELECT s.Name FROM Students AS s
INNER JOIN Friends AS f
ON s.ID = f.ID
INNER JOIN Packages AS p
ON f.ID = p.ID
INNER JOIN Packages AS p2
ON f.Friend_ID = p2.ID
WHERE p2.Salary>p.Salary
ORDER BY p2.Salary;
