#standardSQL
SELECT
  aggtag AS tag,
#  COUNT(tag) AS tags,
  period AS period,
  SUM(people) AS people
FROM (
  SELECT 
    tag,
    IF(COUNT(owner_user_id)>5000,tag,"other") AS aggtag, 
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
        (REGEXP_CONTAINS(tags, "(^|\\|)wordpress($|\\|)") OR REGEXP_CONTAINS(tags, "(^|\\|)drupal($|\\|)")) AND owner_user_id > 0
      GROUP BY
        owner_user_id
      ORDER BY
        questions DESC) AS cordova
    ON
      (sopq.owner_user_id = cordova.owner)
    WHERE
      last_question_date IS NOT NULL AND NOT (REGEXP_CONTAINS(tags, "(^|\\|)wordpress($|\\|)")) OR REGEXP_CONTAINS(tags, "(^|\\|)drupal($|\\|)"))  AS r
  LEFT JOIN
    r.tag
  GROUP BY
    period, tag
  HAVING
    people > 1
  ORDER BY
    tag ASC,
    period ASC,
    people DESC)
GROUP BY
  tag, period