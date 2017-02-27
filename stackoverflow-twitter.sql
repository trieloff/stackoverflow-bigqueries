#standardSQL
SELECT COUNT(URL) AS tweets, SUM(posts) AS links,  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_EXTRACT(URL, "twitter.com/.*/[0-9]"),"twitter.com/","@"),"/status/[0-9].*","") AS user  FROM (
SELECT
  COUNT(id) AS posts, REGEXP_EXTRACT(body, r'(?i:(?:(?:(?:ftp|https?):\/\/)(?:www\.)?|www\.)(?:[\da-z-_\.]+)(?:[a-z\.]{2,7})(?:[\/\w\.-_\?\&]*)*\/?)') AS URL
FROM
  `bigquery-public-data.stackoverflow.stackoverflow_posts`
WHERE
  REGEXP_EXTRACT(body, r'(?i:(?:(?:(?:ftp|https?):\/\/)(?:www\.)?|www\.)(?:[\da-z-_\.]+)(?:[a-z\.]{2,7})(?:[\/\w\.-_\?\&]*)*\/?)') LIKE "http%://twitter.com/%/status/%"
GROUP BY
  URL
)
GROUP BY
  user
ORDER BY
  links DESC, tweets DESC
  LIMIT 100