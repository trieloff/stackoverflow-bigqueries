#standardSQL
SELECT 
  tag, 
  period, 
  COUNT(owner_user_id) AS people 
FROM (
  SELECT
    title,
    owner_user_id,
    last_question_date,
    first_question_date,
    creation_date AS this_question_date,
    IF(creation_date < first_question_date, "before", IF(creation_date > last_question_date, "after", "between")) AS period,
    SPLIT(tags, "|") AS tag
  FROM
    `bigquery-public-data.stackoverflow.posts_questions` AS sopq
  LEFT JOIN
    (SELECT 
      owner_user_id AS owner, 
      COUNT(id) AS questions, 
      MAX(creation_date) AS last_question_date,
      MIN(creation_date) AS first_question_date
    FROM 
      `bigquery-public-data.stackoverflow.posts_questions`
    WHERE
      (REGEXP_CONTAINS(tags, "(^|\\|)phonegap($|\\|)") OR REGEXP_CONTAINS(tags, "(^|\\|)cordova($|\\|)")) AND owner_user_id > 0
    GROUP BY
      owner_user_id
    ORDER BY
      questions DESC) AS cordova
  ON
    (sopq.owner_user_id = cordova.owner)
  WHERE
    last_question_date IS NOT NULL AND NOT (REGEXP_CONTAINS(tags, "(^|\\|)phonegap($|\\|)")) OR REGEXP_CONTAINS(tags, "(^|\\|)cordova($|\\|)"))  AS r
LEFT JOIN
  r.tag
GROUP BY
  period, tag
HAVING
  people > 5000
ORDER BY
  tag ASC,
  period ASC,
  people DESC