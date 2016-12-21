#standardSQL
SELECT
  EXTRACT(YEAR FROM creation_date) AS Year,
  EXTRACT(MONTH FROM creation_date) AS Month,
  MAX(creation_date) AS Date,
  APPROX_COUNT_DISTINCT(IF(post_type_id=1,owner_display_name,NULL)) AS Users1,
  APPROX_COUNT_DISTINCT(IF(post_type_id=2,owner_display_name,NULL)) AS Users2
  #post_type_id AS Type
FROM
  `bigquery-public-data.stackoverflow.stackoverflow_posts`
GROUP BY
  Year, Month
HAVING
  # Use to query a range of years (warning this query processes all records)
  Year > 2009
 # AND Year < 2017
  #Year = 2016 AND Javascript = true
ORDER BY
Date