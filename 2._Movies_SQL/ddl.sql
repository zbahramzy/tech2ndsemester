SHOW TABLES;
# comment, like this
-- comment, or this
/*
or like this
*/

SHOW TABLES;

CREATE TABLE IF NOT EXISTS movies (
    id INT AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    year YEAR,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS directors (
    id INT AUTO_INCREMENT,
    name VARCHAR(255),
    movie_id INT,
    FOREIGN KEY(movie_id) REFERENCES movies(id),
    PRIMARY KEY(id)
);

ALTER TABLE movies
ADD COLUMN year INT(4) AFTER title;

ALTER TABLE movies
MODIFY year YEAR;

DROP TABLE movies;
# DATABASES, TABLES, COLUMNS    vs. DATA (in ROWS)
# DATA DEFINITION LANGUAGE (DDL) vs. DATA MANIPULATION LANGUAGE (DML)
# CREATE, READ, UPDATE, and UPDATE (CRUD)
