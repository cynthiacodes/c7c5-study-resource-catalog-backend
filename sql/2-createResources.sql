DROP TYPE IF EXISTS STAGE, OPINION, CATEGORIES,CONTENT;

CREATE TYPE STAGE AS ENUM  ('Foundation Week 0 - 3','React Week 1','React Week 2', 'React Week 3', 'Nodejs and Express Week', 'SQL and Persistence');
CREATE TYPE OPINION AS ENUM  ('I recommend this resource after having used it',  'I do not recommend this resource, having used it','I haven''t used this resource but it looks promising');
CREATE TYPE CATEGORIES AS ENUM('PostgreSQL','React', 'Frontend', 'Backend', 'TypeScript', 'JavaScript', 'GitHub', 'Express.js', 'CSS', 'HTML', 'Jest', 'CI/CD', 'Node.js');
CREATE TYPE CONTENT AS ENUM('Video', 'Article', 'Ebook', 'Podcast', 'Exercise', 'Exercise set', 'Software tool', 'Course', 'Diagram', 'Cheat-sheet', 'Reference', 'Resource list', 'Youtube channel', 'Organisation');


DROP TABLE IF EXISTS RESOURCES;



CREATE TABLE RESOURCES (
    resource_id serial PRIMARY KEY NOT NULL,
    resource_name varchar(100) NOT NULL,
    author_name varchar(50) NOT NULL,
    url varchar(255) NOT NULL,
    description text NOT NULL,
    tags CATEGORIES,
    content_type CONTENT,
    recommended_stage STAGE,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id integer REFERENCES users(user_id), 
    creator_opinion OPINION,
    creator_reason text
);

ALTER TABLE RESOURCES ADD CONSTRAINT unique_url UNIQUE (url);

INSERT INTO
  RESOURCES (
    resource_name,
    author_name,
    url,
    description,
    tags,
    content_type,
    recommended_stage,
    user_id,
    creator_opinion,
    creator_reason
  )
VALUES
  (
    'Introduction to React',
    'John Doe',
    'https://example.com/react_intro',
    'A beginner-friendly introduction to React',
    'React',
    'Course',
    'React Week 1',
    1,
    'I recommend this resource after having used it',
    'Clear and concise content'
  );



SELECT * FROM RESOURCES;
SELECT * FROM RESOURCES INNER JOIN USERS ON USERS.user_id = RESOURCES.user_id;

