
--load the data from HDFS and define the schema
movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);

moviesperyear = GROUP movies BY year;

yearcount = FOREACH moviesperyear GENERATE year, COUNT(movies) as nummovies;

-- Order that by year.
orderyc = ORDER yearcount BY year;

store orderyc into 'q1';

-- Send the output to the screen.
-- dump orderyc;
illustrate orderyc;
