#standardSQL
SELECT
  MIN(Date) AS Date,
  Year AS Year,
  Month AS Month,
  AVG(DelayMin) AS DelayMin,
  AVG(DelayMax) AS DelayMax,
  COUNT(qid) as Answers
FROM
  test.soquestions
GROUP BY
  Year, Month
HAVING
Year > 2009