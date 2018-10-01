-- Find all the beer details of distinct batches of beers brewed by brewers named 'Alex'.

SELECT *
FROM beer
JOIN
	(SELECT beerid, batchnum
	FROM brews
	WHERE employeeid
	IN
		(SELECT *
		FROM brewer
		WHERE employeeid
		IN
			(SELECT employeeid
			FROM employee
			WHERE employeename
			LIKE 'Alex%')))
			AS beerinfo
ON beer.beerid=beerinfo.beerid
;

-- List all beer names and quantity of cases purchased by customers named ‘Morty’

SELECT beername, COUNT(customerid)
AS number_of_cases
FROM beer
JOIN purchase 
ON beer.beerid=purchase.beerid
WHERE beer.beerid
IN
	(SELECT beerid
	FROM purchase
	WHERE customerid
	IN
		(SELECT customerid
		FROM customer
		WHERE customername
		LIKE 'Morty%'))
GROUP BY beername
;


-- List all beer names, batchnum, abv, and their brewer with abv above 8.0% that were brewed by either 'Tynan' or 'Alex'. Order by employeename.

SELECT beername, batchnum, abv, employeename AS brewer
FROM beer
JOIN brews
ON beer.beerid=brews.beerid
JOIN employee
ON brews.employeeid=employee.employeeid
WHERE beer.abv > 8.0
AND brews.employeeid
IN
	(SELECT *
	FROM brewer
	WHERE employeeid
	IN
		(SELECT employeeid
		FROM employee
		WHERE employeename
		LIKE 'Alex%'
		OR employeename
		LIKE 'Tynan%'))
ORDER BY employeename
;

-- Find all ingredients in beer 'SaltySeaWater' ORDER BY ingredient.

SELECT ingredientname
FROM recipe
WHERE beerid
IN
	(SELECT beerid
	FROM beer
	WHERE beername = 'SaltySeaWater')
ORDER BY ingredientname
;

-- Find the average abv of all beers except for the strongest beer.

SELECT AVG(abv)
AS avg_abv
FROM beer
WHERE beerid
NOT IN
	(SELECT beerid
	FROM beer
	WHERE abv
	IN
		(SELECT MAX(abv)
		FROM beer))
;

