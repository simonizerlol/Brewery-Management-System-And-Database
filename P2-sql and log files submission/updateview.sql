CREATE OR REPLACE [Light Beer List] AS
SELECT beername, abv
FROM beer
WHERE abv < 5.0

CREATE OR REPLACE [All Employees] AS
SELECT employeename, employeeid
FROM employees
