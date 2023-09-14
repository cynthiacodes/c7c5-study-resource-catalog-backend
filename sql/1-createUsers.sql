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

SELECT * FROM USERS;