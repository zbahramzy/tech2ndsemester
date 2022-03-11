# CRUD

SELECT movies.title, movies.year, actors.name
FROM movies, actors, movies_actors
WHERE movies.id=movies_actors.movie_id AND actors.id=movies_actors.actor_id;

