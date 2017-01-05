#standardSQL
SELECT
  LOWER(REGEXP_EXTRACT(message,r"(\w+) is (?:fast|slow|new|old|secure|insecure)")) AS word,
  #LOWER(REGEXP_EXTRACT(text,r"(?:\w+) is (fast|slow|new|old|secure|insecure)")) AS attribute,
  COUNTIF(REGEXP_CONTAINS(message,r"(?:\w+) is (fast)")) AS ghfast,
  COUNTIF(REGEXP_CONTAINS(message,r"(?:\w+) is (slow)")) AS ghslow,
  COUNTIF(REGEXP_CONTAINS(message,r"(?:\w+) is (new)")) AS ghfresh,
  COUNTIF(REGEXP_CONTAINS(message,r"(?:\w+) is (old)")) AS ghold,
  COUNTIF(REGEXP_CONTAINS(message,r"(?:\w+) is (secure)")) AS ghsecure,
  COUNTIF(REGEXP_CONTAINS(message,r"(?:\w+) is (insecure)")) AS ghinsecure
FROM 
  `bigquery-public-data.github_repos.commits`
GROUP BY
  word
HAVING
  word NOT IN ("this", "which", "", "it", "that", "and", "one", "what", "but", "really", "there", "he", "thing", "whatever", "1", "2", "who", "us","itself","else","or","exactly","way","wich","where","whichever","usually","used","two","thus","these","therefore","them","still","sometimes","other","on","once","neither")
ORDER BY
word ASC