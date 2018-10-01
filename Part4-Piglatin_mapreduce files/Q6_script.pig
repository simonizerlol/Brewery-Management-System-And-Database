--load the data from HDFS and define the schema
movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);
ratings = LOAD '/data/ratings.csv' USING PigStorage(',') AS (userid:INT, movieid:INT, rating:DOUBLE, TIMESTAMP);

Fltrd = filter movies BY year==2015;

joinTable = JOIN Fltrd by movieid, ratings by movieid;

groupTable = GROUP joinTable by title;

countGroup = FOREACH groupTable GENERATE ($0) as title, COUNT(joinTable) as numRatings;

order_rating = ORDER countGroup BY numRatings DESC;

l = limit order_rating 5;

dump l;
