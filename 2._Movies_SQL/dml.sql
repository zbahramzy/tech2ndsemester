SELECT * FROM movies;
SELECT * FROM movies WHERE BINARY title='the predator';
SELECT * FROM movies WHERE title='the predator';
SELECT * FROM movies WHERE title='World War Z' LIMIT 1;

INSERT INTO movies (title) VALUES ('The Predator');
INSERT INTO movies VALUES ('The Predator 2');
INSERT INTO movies VALUES ('World War Z');
INSERT INTO movies VALUES ('King Kong');

DELETE FROM movies WHERE title='World War Z' LIMIT 1;
DELETE FROM movies WHERE title="Don't Look Up";

UPDATE movies SET title='King Kong Vs. Godzilla'
WHERE title='King Kong vs. Godzilla';

# CRUD

