
CREATE INDEX movies_ids ON movies(id);

CREATE INDEX movies_titles ON movies(title);

CREATE INDEX movies_ids_titles ON movies(id, title);

/* Specified key was too long; max key length is 3072 bytes */

# Pros: SELECT is much faster
# Cons: INSERT, UPDATE, DELETE is much slower