--load the data from HDFS and define the schema
movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);

--we first group movies by year
group_movie_by_yr = GROUP movies BY year;

--then we count the number of movies every year
count_movie_per_yr = FOREACH group_movie_by_yr GENERATE ($0) AS year, COUNT($1) AS nummovies;

--then we make a copy of count_movie_per_yr so we can cross the two
copy_of_count_movie_per_yr = FOREACH group_movie_by_yr GENERATE ($0) AS prevyear, COUNT($1) AS prevmovies;

--then we find the cross product of the two
cp_of_yearcount = CROSS count_movie_per_yr, copy_of_count_movie_per_yr;

--then we filter out tuples where current movies > previous movies and are 1 year apart
filtered_years = FILTER cp_of_yearcount BY (prevyear + 1 == year) AND (prevmovies > nummovies);

--lastly, output the result
result_output = FOREACH filtered_years GENERATE (year) AS year, (nummovies) AS currentmovies, (prevmovies) AS previousmovies;

-- Store the results in HDFS under your home directory as 'q4', in CSV format
STORE result_output INTO 'q4/result_output.csv' USING PigStorage(',');
