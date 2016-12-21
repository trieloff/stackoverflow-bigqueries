#standardSQL
SELECT
  EXTRACT(YEAR FROM creation_date) AS Year,
  EXTRACT(MONTH FROM creation_date) AS Month,
  MAX(creation_date) AS Date,
  COUNT(*) AS Number_of_Questions,
  SUM(IF(answer_count > 0, 1, 0)) / COUNT(*) AS AnswerRate,
  APPROX_COUNT_DISTINCT(owner_display_name) AS Users,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)java($|\\|)")) AS JavaQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)java($|\\|)") AND (answer_count > 0)) AS JavaA,
  AVG(IF(REGEXP_CONTAINS(tags, "(^|\\|)java($|\\|)"),IF(answer_count > 0, 1, 0),NULL)) AS JavaRate,
  
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)javascript($|\\|)")) AS JavascriptQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)javascript($|\\|)") AND (answer_count > 0)) AS JavascriptA,
  AVG(IF(REGEXP_CONTAINS(tags, "(^|\\|)javascript($|\\|)"),IF(answer_count > 0, 1, 0),NULL)) AS JavascriptRate,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)php($|\\|)")) AS PhpQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)php($|\\|)") AND (answer_count > 0)) AS PhpA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)python($|\\|)")) AS PythonQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)python($|\\|)") AND (answer_count > 0)) AS PythonA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)c\\#($|\\|)")) AS CSQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)c\\#($|\\|)") AND (answer_count > 0)) AS CSA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)c\\+\\+($|\\|)")) AS CppQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)c\\+\\+($|\\|)") AND (answer_count > 0)) AS CppA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)ruby($|\\|)")) AS RubyQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)ruby($|\\|)") AND (answer_count > 0)) AS RubyA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)css($|\\|)")) AS CssQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)css($|\\|)") AND (answer_count > 0)) AS CssA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)c($|\\|)")) AS CQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)c($|\\|)") AND (answer_count > 0)) AS CA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)objective-c($|\\|)")) AS OCQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)objective-c($|\\|)") AND (answer_count > 0)) AS OCA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)shell($|\\|)")) AS ShellQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)shell($|\\|)") AND (answer_count > 0)) AS ShellA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)r($|\\|)")) AS RQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)r($|\\|)") AND (answer_count > 0)) AS RA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)perl($|\\|)")) AS PerlQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)perl($|\\|)") AND (answer_count > 0)) AS PerlA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)scala($|\\|)")) AS ScalaQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)scala($|\\|)") AND (answer_count > 0)) AS ScalaA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)go($|\\|)")) AS GoQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)go($|\\|)") AND (answer_count > 0)) AS GoA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)haskell($|\\|)")) AS HaskellQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)haskell($|\\|)") AND (answer_count > 0)) AS HaskellA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)swift($|\\|)")) AS SwiftQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)swift($|\\|)") AND (answer_count > 0)) AS SwiftA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)matlab($|\\|)")) AS MatlabQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)matlab($|\\|)") AND (answer_count > 0)) AS MatlabA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)clojure($|\\|)")) AS ClojureQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)clojure($|\\|)") AND (answer_count > 0)) AS ClojureA,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)groovy($|\\|)")) AS GroovyQ,
  COUNTIF(REGEXP_CONTAINS(tags, "(^|\\|)groovy($|\\|)") AND (answer_count > 0)) AS GroovyA
  # Javascript, Java, PHP, Python, C#, C++, Ruby, CSS, C, Objective-C, Shell, R, Perl, Scala, Go, Haskell, Swift, Matlab, Clojure, Groovy
FROM
  `bigquery-public-data.stackoverflow.posts_questions`
GROUP BY
  Year, Month
HAVING
  # Use to query a range of years (warning this query processes all records)
  Year > 2009
 # AND Year < 2017
  #Year = 2016 AND Javascript = true
ORDER BY
Year