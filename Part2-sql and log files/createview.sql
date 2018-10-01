CREATE VIEW [Light Beer List] AS
SELECT beername
FROM beer
WHERE abv < 5.0

CREATE VIEW [All Employees] AS
SELECT employeename
FROM employees
