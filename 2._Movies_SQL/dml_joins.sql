USE movies;
SHOW TABLES;
SELECT directors.name, movies.title, movies.year FROM directors, movies
WHERE directors.movie_id=movies.id;