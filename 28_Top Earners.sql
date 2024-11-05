SELECT MAX(salary*months),COUNT(name) FROM EMPLOYEE WHERE salary*months=
(SELECT MAX(salary*months) FROM EMPLOYEE);
