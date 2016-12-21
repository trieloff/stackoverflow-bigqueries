#standardSQL
SELECT
  #COUNT(answers.id) as aid,
  questions.id as qid,
  #COUNT(answers.parent_id) as apid,
  MIN(questions.creation_date) AS Date,
  MIN(EXTRACT(YEAR FROM questions.creation_date)) AS Year,
  MIN(EXTRACT(MONTH FROM questions.creation_date)) AS Month,
  MIN(TIMESTAMP_DIFF(answers.creation_date, questions.creation_date, HOUR)) AS DelayMin,
  MAX(TIMESTAMP_DIFF(answers.creation_date, questions.creation_date, HOUR)) AS DelayMax,
  COUNT(answers.id) as Answers
FROM
  `bigquery-public-data.stackoverflow.posts_answers` AS answers
JOIN
  `bigquery-public-data.stackoverflow.posts_questions` AS questions
ON
  questions.id = answers.parent_id
GROUP BY
  qid
HAVING
  Year > 2009