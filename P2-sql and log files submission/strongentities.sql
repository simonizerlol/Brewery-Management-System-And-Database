CREATE TABLE ingredients
(
	ingredientname VARCHAR(40) NOT NULL UNIQUE
	, PRIMARY KEY(ingredientname)
);

CREATE TABLE beer
(
	beerid INTEGER NOT NULL UNIQUE
	, beername VARCHAR(60)
	, abv FLOAT NOT NULL
	, ibu INTEGER NOT NULL
	, pricepervolume FLOAT NOT NULL
	, ingredientname VARCHAR(40) UNIQUE
	, PRIMARY KEY(beerid)
);

CREATE TABLE equipment
(
	equipmentid INTEGER NOT NULL UNIQUE
	,equipmentname VARCHAR(60) NOT NULL
	,purchasedate DATE NOT NULL
	,PRIMARY KEY (equipmentID)
);

CREATE TABLE employee
(
	employeeid INTEGER NOT NULL UNIQUE
	, employeename VARCHAR(60) NOT NULL
	, salary FLOAT NOT NULL
	, address VARCHAR(200) NOT NULL
	, startdate DATE NOT NULL
	, PRIMARY KEY(employeeid)
);

CREATE TABLE brewer
(
	employeeid INTEGER NOT NULL UNIQUE
	,PRIMARY KEY(employeeid)
	,FOREIGN KEY(employeeid) REFERENCES employee(employeeid)
);

CREATE TABLE sales
(
	employeeid INTEGER NOT NULL UNIQUE
	,PRIMARY KEY(employeeid)
	,FOREIGN KEY(employeeid) REFERENCES employee(employeeid)

);

CREATE TABLE maintenance
(
	employeeid INTEGER NOT NULL UNIQUE
	,PRIMARY KEY(employeeid)
	,FOREIGN KEY(employeeid) REFERENCES employee(employeeid)

);

CREATE TABLE customer
(
	customerid INTEGER NOT NULL UNIQUE
	,customername VARCHAR(60) NOT NULL
	,emailaddress VARCHAR(100) NOT NULL
	,deliveraddress VARCHAR(100) NOT NULL
    ,employeeid INTEGER NOT NULL
	,PRIMARY KEY(customerid)
    ,FOREIGN KEY(employeeid) references sales(employeeid)
);
