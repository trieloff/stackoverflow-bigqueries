#standardSQL
SELECT
  LOWER(REGEXP_EXTRACT(text,r"(\w+) is (?:fast|slow|new|old|secure|insecure)")) AS word,
  #LOWER(REGEXP_EXTRACT(text,r"(?:\w+) is (fast|slow|new|old|secure|insecure)")) AS attribute,
  COUNTIF(REGEXP_CONTAINS(text,r"(?:\w+) is (fast)")) AS hnfast,
  COUNTIF(REGEXP_CONTAINS(text,r"(?:\w+) is (slow)")) AS hnslow,
  COUNTIF(REGEXP_CONTAINS(text,r"(?:\w+) is (new)")) AS hnfresh,
  COUNTIF(REGEXP_CONTAINS(text,r"(?:\w+) is (old)")) AS hnold,
  COUNTIF(REGEXP_CONTAINS(text,r"(?:\w+) is (secure)")) AS hnsecure,
  COUNTIF(REGEXP_CONTAINS(text,r"(?:\w+) is (insecure)")) AS hninsecure
FROM 
  `bigquery-public-data.hacker_news.comments`
GROUP BY
  word
HAVING
  word NOT IN ("this", "which", "", "it", "that", "and", "one", "what", "but", "really", "there", "he", "thing", "whatever", "1", "2", "who", "us","itself","else","or","exactly","way")
ORDER BY
  word ASC