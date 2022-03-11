USE movies;
SHOW TABLES;
SELECT directors.name, movies.title, movies.year FROM directors, movies
WHERE directors.movie_id=movies.id;

INSERT INTO production_teams(team_name)
VALUES ('A - Team');
INSERT INTO movies_production_teams (movie_id, production_team_id)
VALUES (3, 1);

DELETE FROM production_teams
WHERE id = 1;

SELECT * FROM production_teams;
SELECT * FROM movies_production_teams;