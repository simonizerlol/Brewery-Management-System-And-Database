--load the data from HDFS and define the schema
movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);
moviegenre = LOAD '/data/moviegenres.csv' USING PigStorage(',') AS (movieid:INT, genre:CHARARRAY);

Fltrd = filter movies BY year==2015 OR year==2016;

jointable = JOIN moviegenre by movieid, Fltrd by movieid;

groupjoin = GROUP jointable BY (genre, year);

-- to answer question a, this is what the schema looks like after group by
DESCRIBE groupjoin;

groupcount = FOREACH groupjoin GENERATE ($0) as genre, COUNT(jointable) as nummovies;

ordergroupgenre = ORDER groupcount BY genre;

illustrate ordergroupgenre;

dump ordergroupgenre;
