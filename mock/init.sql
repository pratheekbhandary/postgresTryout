CREATE TABLE users (
	id serial PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name text,
	age int,
	email text UNIQUE NOT NULL
);

DROP TABLE users;

INSERT INTO users (first_name, last_name, age, email)
		VALUES('prathvi', 'bhandary', 12, 'ppp.b@gmail.com');
SELECT
	*
FROM
	users
WHERE
	id = 3
	OR first_name = 'pratheek';

UPDATE
	users
SET
	first_name = 'arjun',
	last_name = last_name || ' ton'
WHERE
	id = 9;

CREATE TABLE posts (
	id serial PRIMARY KEY,
	title text NOT NULL,
	body text DEFAULT '...',
	creatorId int REFERENCES users (id) NOT NULL
);


INSERT INTO posts (title, creatorId)
		values('my 4th post', 1);
SELECT
	*
FROM
	posts;

-- Inner join
SELECT
	users.id user_id,
	first_name,
	title,
	posts.id posts_id
FROM
	users
	INNER JOIN posts ON users.id = posts.creatorid;

-- Where clause in joins
SELECT
	u.id user_id,
	first_name,
	title,
	p.id posts_id
FROM
	users u
	INNER JOIN posts p ON u.id = p.creatorid
WHERE
	p.title LIKE '%2%';

-- ILKIE -> ignore case
-- Outer join

SELECT
	users.id,
	first_name,
	title,
	posts.id
FROM
	users
	LEFT JOIN posts ON users.id = posts.creatorid;

DELETE FROM posts
WHERE id = 9;

-- Comments TABLE
CREATE TABLE comments (
	id serial PRIMARY KEY,
	message text NOT NULL,
	post_id int REFERENCES posts (id),
	creator_id int REFERENCES users (id)
);

INSERT INTO comments (message, post_id, creator_id)
		VALUES('Good One! Hey its Arjun!', 10, 9);
UPDATE
	comments
SET
	message = 'Hey Pratheek! Nice Post'
WHERE
	id = 1;

SELECT
	pu.first_name,
	p.title,
	c.message,
	cu.first_name
FROM
	comments c
	INNER JOIN posts p ON c.post_id = p.id
	INNER JOIN users pu ON p.creatorid = pu.id
	INNER JOIN users cu ON c.creator_id = cu.id;

-- favorites/upvotes/likes
-- user - post
-- NOT a 1 to many relationship
-- many to many relationship
-- join table

CREATE TABLE favorites (
	user_id int REFERENCES users (id),
	post_id int REFERENCES posts (id),
	PRIMARY KEY (user_id, post_id) -- composite key
);

INSERT INTO favorites (user_id, post_id)
		values(2, 10);
-- friends table
-- many to many

CREATE TABLE friends (
	user_id1 int REFERENCES users (id),
	user_id2 int REFERENCES users (id)
);

ALTER TABLE friends
	ADD PRIMARY KEY (user_id1, user_id2);

INSERT INTO friends (user_id1, user_id2)
		values(2, 2);

Alter table friends add CONSTRAINT self_friend check (user_id1 != user_id2);
