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
    (4, 1, 'This is a great resource!', true, false);


SELECT * FROM OPINIONS;
