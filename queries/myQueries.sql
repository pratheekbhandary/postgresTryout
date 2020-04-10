-- how to get random dates
SELECT now() - (random() * interval '100 days');

-- create new column in posts with random dates
ALTER TABLE posts ADD COLUMN created_at date DEFAULT now() - (random() * interval '100 days');

-- Inner join with pagination ideas; all posts with creator;
SELECT
	created_at,
	title,
	substr(body, 1, 30) body,
	first_name
FROM
	posts p
	INNER JOIN users u ON p.creator_id = u.id
ORDER BY
	CREATED_AT desc
OFFSET 10	
LIMIT 10;

-- posts with comments and has been liked or not
SELECT
	pU.first_name posted_by,
	p.title post,
	c.message comment_detail,
	cU.first_name comment_by,
	f.user_id is not null has_liked
FROM
	posts p
Inner join 
	comments c on c.post_id = p.id
Inner join
	users pU on p.creator_id = pU.id
Inner join
	users cU on cU.id = c.creator_id
left join 
	favorites f on f.post_id = p.id
WHERE
	p.id = 11;

select * from users u 
inner join friends f on f.user_id1 = u.id;

select * from users u
inner join friends f on f.user_id1 = u.id;

select
       max(u.first_name),
       user_id1,
       array_agg(user_id2),
       count(*)
from friends f
inner join users u on u.id = f.user_id1
group by user_id1
order by count(*) desc;

-- Result table lists all friends of each and every user 
SELECT
	id,
	profile_name,
	ARRAY_AGG(friend) friend,
	count(*) total_friends
FROM (
	SELECT
		u.id id,
		u.first_name profile_name,
		u2.first_name friend
	FROM
		users u
		INNER JOIN friends f ON f.user_id1 = u.id
		LEFT JOIN users u2 ON u2.id = f.user_id2
	UNION ALL
	SELECT
		u.id id,
		u.first_name profile_name,
		u2.first_name friend
	FROM
		users u
		INNER JOIN friends f ON f.user_id2 = u.id
		LEFT JOIN users u2 ON u2.id = f.user_id1
		) t
GROUP BY
	profile_name,
	id;
