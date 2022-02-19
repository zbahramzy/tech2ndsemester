SELECT title, year FROM movies;
SELECT year FROM movies;

SELECT * FROM movies WHERE year<2016;
SELECT * FROM movies WHERE year=2016;
SELECT * FROM movies WHERE year < NOW();
SELECT * FROM movies WHERE year is NOT NULL;
SELECT * FROM movies WHERE TRUE;

SELECT * FROM movies ORDER BY title;
SELECT * FROM movies ORDER BY year;
SELECT * FROM movies ORDER BY year DESC;
SELECT * FROM movies ORDER BY year ASC;

INSERT INTO movies (title, year)
VALUES ('Avengers: Infinity War', '2018');

INSERT INTO movies (title)
VALUES ('Avengers: Infinity War');

INSERT INTO movies (year)
VALUES (1990);

INSERT INTO movies
VALUES ('Avengers: Infinity War', '2018');