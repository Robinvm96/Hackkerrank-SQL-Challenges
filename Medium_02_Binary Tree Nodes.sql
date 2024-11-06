WITH 
children AS (SELECT DISTINCT N FROM BST WHERE P IS NOT NULL),
parents AS  (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL)

SELECT * FROM (
    Select children.N AS Number,'Inner' AS Label FROM children
    INNER JOIN parents
    ON children.N = parents.P
    UNION
    Select children.N AS Number,'Leaf' AS Label FROM children
    LEFT JOIN parents
    ON children.N = parents.P
    WHERE parents.P IS NULL
    UNION
    SELECT N AS Number,'Root' AS Label FROM BST WHERE P IS NULL) AS Combined_result
ORDER BY Number;
