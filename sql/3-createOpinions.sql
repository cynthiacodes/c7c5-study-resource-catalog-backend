DROP TABLE IF EXISTS OPINIONS;

CREATE TABLE OPINIONS (
    opinion_id SERIAL PRIMARY KEY NOT NULL,
    user_id INT REFERENCES USERS(user_id),
    resource_id INT REFERENCES RESOURCES(resource_id),
    comment TEXT NOT NULL,
    likes INT DEFAULT 0 NOT NULL,
    dislikes INT DEFAULT 0 NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
);

INSERT INTO OPINIONS (user_id, resource_id, comment)
VALUES
    (4, 1, 'Amazing!');

INSERT INTO OPINIONS (user_id, resource_id, comment, likes, dislikes)
VALUES
    (4, 1, 'This is a great resource!', 15, 2);


SELECT * FROM OPINIONS;
