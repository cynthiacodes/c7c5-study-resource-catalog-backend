DROP TABLE IF EXISTS OPINIONS;

CREATE TABLE OPINIONS (
    opinion_id SERIAL PRIMARY KEY NOT NULL,
    user_id INT REFERENCES USERS(user_id),
    resource_id INT REFERENCES RESOURCES(resource_id),
    comment TEXT NOT NULL,
    is_like BOOLEAN DEFAULT false,
    is_dislike BOOLEAN DEFAULT false,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  	CHECK (NOT (is_like AND is_dislike))
);

INSERT INTO OPINIONS (user_id, resource_id, comment)
VALUES
    (4, 1, 'Amazing!');


INSERT INTO OPINIONS (user_id, resource_id, comment, is_like, is_dislike)
VALUES
    (4, 3, 'This is a great resource!', true, false),
    (5, 6, 'Too time consuming', false, true),
    (1, 8, 'straight to the point', true, false),
    (1, 3, 'Worth reading', true, false),
    (5, 6, 'Not great', false, true);
    

SELECT * FROM OPINIONS;

-- to dislike a resource
UPDATE OPINIONS
SET
  is_like = CASE WHEN is_like THEN false ELSE is_like END,
  is_dislike = NOT is_dislike
WHERE user_id = 4 AND resource_id = 1;


-- to like a resource
UPDATE OPINIONS
SET
  is_dislike = CASE WHEN is_dislike THEN false ELSE is_dislike END,
  is_like = NOT is_like
WHERE user_id = 4 AND resource_id = 1;