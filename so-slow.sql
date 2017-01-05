#standardSQL
SELECT
  LOWER(REGEXP_EXTRACT(body,r"(\w+) is (?:fast|slow|new|old|secure|insecure)")) AS word,
  #LOWER(REGEXP_EXTRACT(text,r"(?:\w+) is (fast|slow|new|old|secure|insecure)")) AS attribute,
  COUNTIF(REGEXP_CONTAINS(body,r"(?:\w+) is (fast)")) AS sofast,
  COUNTIF(REGEXP_CONTAINS(body,r"(?:\w+) is (slow)")) AS soslow,
  COUNTIF(REGEXP_CONTAINS(body,r"(?:\w+) is (new)")) AS sofresh,
  COUNTIF(REGEXP_CONTAINS(body,r"(?:\w+) is (old)")) AS soold,
  COUNTIF(REGEXP_CONTAINS(body,r"(?:\w+) is (secure)")) AS sosecure,
  COUNTIF(REGEXP_CONTAINS(body,r"(?:\w+) is (insecure)")) AS soinsecure
FROM 
  `bigquery-public-data.stackoverflow.stackoverflow_posts`
GROUP BY
  word
HAVING
  word NOT IN ("this", "which", "", "it", "that", "and", "one", "what", "but", "really", "there", "he", "thing", "whatever", "1", "2", "who", "us","itself","else","or","exactly","way","wich","where","whichever","usually","used","two","thus","these","therefore","them","still","sometimes","other","on","once","neither")
ORDER BY
word ASC