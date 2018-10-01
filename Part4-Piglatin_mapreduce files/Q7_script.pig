--load the data from HDFS and define the schema
movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);
ratings = LOAD '/data/ratings.csv' USING PigStorage(',') AS (userid:INT, movieid:INT, rating:DOUBLE, TIMESTAMP);
moviegenres = LOAD '/data/moviegenres.csv' USING PigStorage(',') AS (movieid:INT, genre:CHARARRAY);

-- find the movies released in 2016 and generate a table that has movieid and title
movies_in_2016 = FOREACH (FILTER movies BY year == 2016) GENERATE movieid AS movieID, title AS title;

-- then we join movies_in_2016 table with moviegenres table using movieid, and generate a table that has movieid and genre
movies2016_genre_join = FOREACH (JOIN movies_in_2016 BY movieID, moviegenres BY movieid) GENERATE movies_in_2016::movieID AS movieID, moviegenres::genre AS genre;

-- then we group movies2016_genre_join table and count
movie2016_Genres_group = GROUP movies2016_genre_join BY movieID ;
movie2016_Genres_count = FOREACH movie2016_Genres_group GENERATE group AS movieID, COUNT(movies2016_genre_join.genre) AS count;

-- then we join movies_in_2016 table with ratings table using movieid, and generate a table that has movieid and userid
user_ratings_Join = FOREACH (JOIN movies_in_2016 BY movieID, ratings BY movieid) GENERATE movies_in_2016::movieID AS movieID, ratings::userid AS ratingID;

-- then we group user_ratings_Join table and count
user_ratings_group = GROUP user_ratings_Join BY movieID;
user_ratings_count = FOREACH user_ratings_group GENERATE group AS movieID, COUNT(user_ratings_Join.ratingID) AS count;

-- we output the result which contains movieid, title, number of genres to which the movie belongs and the number of user ratings it has received
result = FOREACH (JOIN movies_in_2016 BY movieID, movie2016_Genres_count BY movieID, user_ratings_count BY movieID) GENERATE movies_in_2016::movieID AS movieID, movies_in_2016::title AS title, movie2016_Genres_count::count AS genresCount, user_ratings_count::count AS ratingsCount;

-- generate the explain for the entire Q7 script
EXPLAIN  result

-- Store the results in HDFS under your home directory as 'q7', in CSV format
STORE result INTO 'q7/result.csv' USING PigStorage(',');
