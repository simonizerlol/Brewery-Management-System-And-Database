--load the data from HDFS and define the schema
movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);
moviegenres = LOAD '/data/moviegenres.csv' USING PigStorage(',') AS (movieid:INT, genre:CHARARRAY);

Fltrd = filter movies BY year==2015;

Fltrd2 = filter moviegenres BY genre=='Comedy' OR genre=='Sci-Fi';

-- to answer question 2, we added PARALLEL 4 at the end of the join step
Jnd = join Fltrd2 BY movieid, Fltrd BY movieid PARALLEL 4;

-- to answer question 1b, this is what the schema looks like after join
DESCRIBE Jnd;

Smmd = foreach Jnd generate title;

Smmd = DISTINCT Smmd;

-- Order that by title.
ordersmmd = ORDER Smmd BY title;

dump ordersmmd;
