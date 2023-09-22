DROP TABLE
  IF EXISTS OPINIONS;

CREATE TABLE
  OPINIONS (
    opinion_id SERIAL PRIMARY KEY NOT NULL,
    user_id INT REFERENCES USERS(user_id),
    resource_id INT REFERENCES RESOURCES(resource_id),
    is_like BOOLEAN DEFAULT false,
    is_dislike BOOLEAN DEFAULT false,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (
      NOT (
        is_like
        AND is_dislike
      )
    )
  );

INSERT INTO
  OPINIONS (user_id, resource_id, is_like, is_dislike)
VALUES
  (4, 3, true, false),
  (5, 6, false, true),
  (1, 8, true, false),
  (1, 3, true, false);

SELECT
  *
FROM
  OPINIONS;

-- to dislike a resource
UPDATE
  OPINIONS
SET
  is_like = CASE
    WHEN is_like THEN false
    ELSE is_like
  END,
  is_dislike = NOT is_dislike
WHERE
  user_id = 4
  AND resource_id = 1;

-- to like a resource
UPDATE
  OPINIONS
SET
  is_dislike = CASE
    WHEN is_dislike THEN false
    ELSE is_dislike
  END,
  is_like = NOT is_like
WHERE
  user_id = 4
  AND resource_id = 1;

-- Count the number of likes for a resource
SELECT
  COUNT(*)
FROM
  OPINIONS
WHERE
  resource_id = 3
  AND is_like = true;

-- Count the number of dislikes for a resource
SELECT
  COUNT(*)
FROM
  OPINIONS
WHERE
  resource_id = 6
  AND is_dislike = true;

-- add unique constraint 
ALTER TABLE
  OPINIONS
ADD
  CONSTRAINT unique_user_resource UNIQUE (user_id, resource_id);

-- insert a new opinion to like a resource or update the like column
INSERT INTO
  OPINIONS (user_id, resource_id, is_like, is_dislike)
VALUES
  (4, 1, true, false) ON CONFLICT (user_id, resource_id)
DO
UPDATE
SET
  is_dislike = CASE
    WHEN EXCLUDED.is_dislike THEN FALSE
    ELSE false
  END,
  is_like = CASE
    WHEN EXCLUDED.is_dislike THEN OPINIONS.is_like
    ELSE NOT OPINIONS.is_like
  END;

-- dislike a resource and insert a dislike if the opinion does not exist
INSERT INTO OPINIONS (user_id, resource_id, is_like, is_dislike)
VALUES (4, 1, false, true)
ON CONFLICT (user_id, resource_id)
DO UPDATE SET
  is_like = CASE
    WHEN EXCLUDED.is_dislike THEN FALSE
    ELSE NOT OPINIONS.is_like
  END,
  is_dislike = CASE
    WHEN EXCLUDED.is_dislike THEN NOT OPINIONS.is_dislike
    ELSE EXCLUDED.is_dislike
  END;
