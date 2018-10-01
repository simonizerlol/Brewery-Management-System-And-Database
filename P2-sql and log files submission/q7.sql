CREATE VIEW light_beer_list AS
SELECT beername
FROM beer
WHERE abv < 8.0;

CREATE VIEW all_employees AS
SELECT employeename
FROM employee;
