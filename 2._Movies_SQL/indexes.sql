# todo create an index on movie ids
#  and another one on movies.title
USE movies;
CREATE INDEX id_index ON movies (id);

CREATE INDEX title_index ON movies (title);

CREATE INDEX id_title_index ON movies (id, title);

SHOW ENGINES;
