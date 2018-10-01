-- Add new beers to repetoire.
INSERT INTO beer (beerid, beername, abv, ibu, pricepervolume)  VALUES (114571418, 'DoubleDouble', 4.9, 50, 2.99);
INSERT INTO beer (beerid, beername, abv, ibu, pricepervolume)  VALUES (366260827, 'DarkerBetter', 5.5, 10, 0.50);

-- Maintain List of Active Customers.
DROP TABLE activecustomers;
CREATE TABLE activecustomers
(
	customerid INTEGER NOT NULL
	,customername VARCHAR(60) NOT NULL
);

INSERT INTO activecustomers (
    SELECT customer.customerid, customer.customername
    FROM customer, purchase 
    WHERE customer.customerid = purchase.customerid);

-- Fire two active customers.
DELETE FROM activecustomers WHERE customerid IN (340733760, 596793719);

-- Update customer personal details.
UPDATE customer 
SET emailaddress = 'beerlover42@gmail.com', deliveraddress = '2 Wallaby Lane'
WHERE customername LIKE 'Rick%';
