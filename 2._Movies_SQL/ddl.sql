SHOW TABLES;

CREATE TABLE IF NOT EXISTS movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year YEAR
);

CREATE TABLE IF NOT EXISTS directors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    movie_id INT,
    FOREIGN KEY(movie_id) REFERENCES movies(id)
);

CREATE TABLE IF NOT EXISTS actors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS movies_actors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    actor_id INT,
    FOREIGN KEY(movie_id) REFERENCES movies(id),
    FOREIGN KEY(actor_id) REFERENCES actors(id)
);

CREATE TABLE IF NOT EXISTS production_teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS movies_production_teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    production_team_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (production_team_id) REFERENCES production_teams(id) ON DELETE CASCADE
);

ALTER TABLE movies ADD COLUMN year YEAR NOT NULL AFTER title;
ALTER TABLE movies DROP COLUMN  year;
ALTER TABLE movies MODIFY year INT(4);

DROP TABLE movies;

# DATA DEFINITION LANGUAGE (DDL) vs. DATA MANIPULATION LANGUAGE (DML)
# CREATE, READ, UPDATE, and UPDATE (CRUD)

# DATABASES,TABLES,COLUMNS vs. DATA (in ROWS)
# DDL                      vs. DML
# CRUD

