DROP TABLE IF EXISTS USERS;

CREATE TABLE  USERS(
    user_id    serial PRIMARY KEY,
    name       varchar(40) NOT NULL,
    is_faculty boolean NOT NULL default false
);



INSERT INTO USERS (name)
VALUES
    ('Adil'),
    ('Ana'),
    ('Beth'),
    ('Carlton'),
    ('Cynthia'),
    ('Dani'),
    ('Henry'),
    ('HoKei'),
    ('Julieta'),
    ('Laura'),
    ('Lucja'),
    ('Oskar'),
    ('Rosie'),
    ('Silviu'),
    ('Stephanie'),
    ('Tom'),
    ('Tomasz'),
    ('Viki');

DROP TABLE IF EXISTS RESOURCES;


CREATE TYPE STAGE AS ENUM  ('Foundation Week 0 - 3','React Week 1','React Week 2', 'React Week 3', 'Nodejs and Express Week', 'SQL and Persistence');
CREATE TYPE OPINION AS ENUM  ('I recommend this resource after having used it',  'I do not recommend this resource, having used it','I haven''t used this resource but it looks promising');


CREATE TABLE RESOURCES (
    resources_id serial PRIMARY KEY NOT NULL,
    resource_name varchar(100) NOT NULL,
    author_name varchar(50) NOT NULL,
    url varchar(255) NOT NULL,
    description text NOT NULL,
    tags text NOT NULL,
    content_type text NOT NULL,
    recommended_stage STAGE,
    date_created timestamp,
    user_id integer REFERENCES users(user_id), 
    creator_opinion OPINION,
    creator_reason text
);

INSERT INTO
  RESOURCES (
    resource_name,
    author_name,
    url,
    description,
    tags,
    content_type,
    recommended_stage,
    date_created,
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
    'React, Frontend, Web Development',
    'Course',
    'React Week 1',
    '2023-09-10 10:00:00',
    1,
    'I recommend this resource after having used it',
    'Clear and concise content'
  );