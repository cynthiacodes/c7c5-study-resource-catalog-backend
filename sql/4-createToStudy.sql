DROP TABLE
  IF EXISTS TO_STUDY;

CREATE TABLE
  TO_STUDY(
    study_item_id SERIAL PRIMARY KEY NOT NULL,
    user_id INT REFERENCES USERS(user_id),
    resource_id INT REFERENCES RESOURCES(resource_id)
  );

INSERT INTO
  TO_STUDY (user_id, resource_id)
VALUES
  (6, 1);
  
  SELECT * from TO_STUDY;

SELECT
  TO_STUDY.study_item_id,
  TO_STUDY.user_id,
  TO_STUDY.resource_id,
  RESOURCES.resource_name
FROM
  TO_STUDY
  INNER JOIN RESOURCES ON TO_STUDY.resource_id = RESOURCES.resource_id;

SELECT
  TO_STUDY.*,
  RESOURCES.*
FROM
  TO_STUDY
  INNER JOIN RESOURCES ON TO_STUDY.resource_id = RESOURCES.resource_id;