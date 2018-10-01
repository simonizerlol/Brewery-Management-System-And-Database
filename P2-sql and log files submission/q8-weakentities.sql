CREATE TABLE batch
(
batchnum INTEGER NOT NULL UNIQUE
, batchsize INTEGER NOT NULL CHECK (batchsize > 0)
, datemade DATE NOT NULL
, beerid INTEGER NOT NULL
, PRIMARY KEY(batchnum, beerid)
, FOREIGN KEY(beerid) REFERENCES beer(beerid)
);

CREATE TABLE beercase
(
caseid INTEGER NOT NULL UNIQUE
, caseprice FLOAT NOT NULL CHECK (caseprice > 0)
, casesize INTEGER NOT NULL CHECK (casesize > 5 AND casesize < 61)
, batchnum INTEGER NOT NULL CHECK (batchnum > 0)
, PRIMARY KEY(caseid, batchnum)
, FOREIGN KEY(batchnum) REFERENCES batch(batchnum)
);
