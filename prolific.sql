#standardSQL
SELECT
  author,
  LOWER(author) AS shahash,
  PERCENT_RANK() OVER (ORDER BY commits DESC) AS crank,
  PERCENT_RANK() OVER (ORDER BY repos DESC) AS rrank,
  repos,
  commits,
  SQRT((PERCENT_RANK() OVER (ORDER BY commits DESC)*PERCENT_RANK() OVER (ORDER BY commits DESC))+(PERCENT_RANK() OVER (ORDER BY repos DESC)*PERCENT_RANK() OVER (ORDER BY repos DESC))) AS orank
FROM (
  SELECT
    author.name AS author, 
    COUNT(DISTINCT REGEXP_REPLACE(repo_name,".*/","")) AS repos, 
    COUNT(commit) AS commits
  FROM 
    `bigquery-public-data.github_repos.commits` AS c
  LEFT JOIN
    c.repo_name
  WHERE
    EXTRACT(YEAR FROM author.date) = 2016
  GROUP BY
    author)
JOIN
  `test.lowercase`
ON
  LOWER(author) = name
ORDER BY
orank ASC