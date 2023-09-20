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
  creator_reason)
VALUES
	('Introduction to React','John Doe','https://example.com/react_intro','A beginner-friendly introduction to React','React','Course','React Week 1',1,'I recommend this resource after having used it','Clear and concise content'),

    ('PostgreSQL Fundamentals', 'John Doe', 'https://www.example.com/postgresql-fundamentals', 'A beginner''s guide to PostgreSQL', 'PostgreSQL', 'Article', 'Foundation Week 0 - 3',1, 'I recommend this resource after having used it', 'I found this article very helpful for beginners'),
    
    ('React State Management', 'Jane Smith', 'https://www.example.com/react-state-management', 'Exploring state management in React', 'React', 'Article', 'React Week 1',4, 'I recommend this resource after having used it', 'This article provides a clear explanation of React state management'),
    
    ('Frontend Frameworks Comparison', 'Alice Johnson', 'https://www.example.com/frontend-frameworks-comparison', 'A comparison of popular frontend frameworks', 'Frontend', 'Article', 'React Week 3',5, 'I recommend this resource after having used it', 'Helpful resource for choosing the right frontend framework'),
    
    ('Node.js Authentication', 'Bob Williams', 'https://www.example.com/nodejs-authentication', 'Securing your Node.js application', 'Node.js', 'Article', 'Nodejs and Express Week',6, 'I recommend this resource after having used it', 'Great insights into Node.js authentication techniques'),
    
    ('TypeScript Crash Course', 'Sarah Davis', 'https://www.example.com/typescript-crash-course', 'A quick introduction to TypeScript', 'TypeScript', 'Course', 'Foundation Week 0 - 3',7, 'I recommend this resource after having used it', 'A solid TypeScript introduction course'),
    
    ('GitHub Workflow', 'Mike Lee', 'https://www.example.com/github-workflow', 'Mastering GitHub collaboration', 'GitHub', 'Article', 'React Week 2',4, 'I recommend this resource after having used it', 'This article helped me understand GitHub workflows better'),
    
    ('CSS Animation Techniques', 'Emily Wilson', 'https://www.example.com/css-animation-techniques', 'Advanced CSS animation tips', 'CSS', 'Article', 'Foundation Week 0 - 3',3, 'I haven''t used this resource but it looks promising', 'I''m planning to use this for my next project'),
    
    ('HTML5 Canvas Tutorial', 'Chris Martin', 'https://www.example.com/html5-canvas-tutorial', 'Creating interactive graphics with HTML5 Canvas', 'HTML', 'Video', 'Foundation Week 0 - 3',2, 'I recommend this resource after having used it', 'Great tutorial on HTML5 Canvas'),
    
    ('Continuous Integration with Jenkins', 'David White', 'https://www.example.com/ci-cd-jenkins', 'Setting up CI/CD with Jenkins', 'CI/CD', 'Course', 'Foundation Week 0 - 3',5, 'I do not recommend this resource, having used it', 'Outdated information and errors in the course');



SELECT * FROM RESOURCES;
SELECT * FROM RESOURCES INNER JOIN USERS ON USERS.user_id = RESOURCES.user_id;
SELECT * FROM RESOURCES WHERE resource_id = 10;
SELECT * FROM RESOURCES ORDER BY resource_id DESC;
