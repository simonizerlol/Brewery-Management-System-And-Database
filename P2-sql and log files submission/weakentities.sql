CREATE TABLE batch
(
batchnum INTEGER NOT NULL UNIQUE
, batchsize INTEGER NOT NULL
, datemade DATE NOT NULL
, beerid INTEGER NOT NULL
, PRIMARY KEY(batchnum, beerid)
, FOREIGN KEY(beerid) REFERENCES beer(beerid)
);

CREATE TABLE beercase
(
caseid INTEGER NOT NULL UNIQUE
, caseprice FLOAT NOT NULL
, casesize INTEGER NOT NULL
, batchnum INTEGER NOT NULL
, PRIMARY KEY(caseid, batchnum)
, FOREIGN KEY(batchnum) REFERENCES batch(batchnum)
);