--load the data from HDFS and define the schema
movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);
ratings = LOAD '/data/ratings.csv' USING PigStorage(',') AS (userid:INT, movieid:INT, rating:DOUBLE, TIMESTAMP);

Jnd = join movies by movieid, ratings by movieid;

ratingspermovies = group Jnd by title;

count_rating = FOREACH ratingspermovies GENERATE ($0) as title, COUNT(Jnd) as numratings;

order_rating = ORDER count_rating BY numratings DESC;

l = limit order_rating 10;

dump l;
