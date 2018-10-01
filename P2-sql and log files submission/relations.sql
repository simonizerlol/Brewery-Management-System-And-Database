CREATE TABLE maintains
(
latestinspection DATE NOT NULL
,equipmentid INTEGER NOT NULL 
,employeeid INTEGER NOT NULL 
,FOREIGN KEY(equipmentid) REFERENCES equipment(equipmentid)
,FOREIGN KEY(employeeid) REFERENCES employee(employeeid)
);

CREATE TABLE brews
(
	brewstart DATE NOT NULL
	, brewend DATE NOT NULL
	, employeeid INTEGER NOT NULL 
	, batchnum INTEGER NOT NULL 
	, beerid INTEGER NOT NULL
	, FOREIGN KEY(employeeid) REFERENCES employee(employeeid)
	, FOREIGN KEY(batchnum) REFERENCES batch(batchnum)
	, FOREIGN KEY(beerid) REFERENCES beer(beerid)
);

CREATE TABLE purchase
(
	customerid INTEGER NOT NULL
	, caseid INTEGER NOT NULL UNIQUE
	, beerid INTEGER NOT NULL 
	, FOREIGN KEY(customerid) REFERENCES customer(customerid)
	, FOREIGN KEY(caseid) REFERENCES beercase(caseid)
	, FOREIGN KEY(beerid) REFERENCES beer(beerid)
);

CREATE TABLE recipe
(
	beerid INTEGER NOT NULL
	, ingredientname VARCHAR(20) NOT NULL
	, FOREIGN KEY(beerid) REFERENCES beer(beerid)
	, FOREIGN KEY(ingredientname) REFERENCES ingredients(ingredientname)
);
