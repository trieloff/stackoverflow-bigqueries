#standardSQL
SELECT
  questions.owner_user_id AS Asker,
  COUNT(questions.id) as Questions
FROM
  `bigquery-public-data.stackoverflow.posts_answers` AS answers
JOIN
  `bigquery-public-data.stackoverflow.posts_questions` AS questions
ON
  questions.id = answers.parent_id
WHERE
  questions.owner_user_id = answers.owner_user_id
GROUP BY
  Asker
ORDER BY
  Questions DESC
LIMIT
  10