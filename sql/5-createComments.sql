DROP TABLE IF EXISTS COMMENTS;

CREATE TABLE COMMENTS(
    comment_id SERIAL PRIMARY KEY NOT NULL,
    user_id INT REFERENCES USERS(user_id),
    resource_id INT REFERENCES RESOURCES(resource_id),
    comment TEXT NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO COMMENTS (user_id, resource_id, comment)
VALUES
    (4, 1, 'Amazing!');

INSERT INTO COMMENTS (user_id, resource_id, comment)
VALUES
    (4, 3, 'This is a great resource!'),
    (5, 6, 'Too time consuming'),
    (1, 8, 'straight to the point'),
    (1, 3, 'Worth reading'),
    (5, 6, 'Not great');
    


SELECT * FROM COMMENTS;

-- edit comment
UPDATE COMMENTS
SET comment = 'New edited comment text'
WHERE comment_id = 3;
















