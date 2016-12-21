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
  MAX(IF(TIMESTAMP_DIFF(answers.creation_date, questions.creation_date, HOUR)<25,TRUE,FALSE)) AS OneDay,
  MAX(IF(TIMESTAMP_DIFF(answers.creation_date, questions.creation_date, HOUR)<169,TRUE,FALSE)) AS OneWeek,
  questions.owner_user_id AS Asker,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)java($|\\|)")) AS Java,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)javascript($|\\|)")) AS JavaScript,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)php($|\\|)")) AS Php,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)python($|\\|)")) AS Python,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)c\\#($|\\|)")) AS CSharp,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)c\\+\\+($|\\|)")) AS Cplusplus,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)ruby($|\\|)")) AS Ruby,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)css($|\\|)")) AS Css,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)c($|\\|)")) AS C,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)objective\\-c($|\\|)")) AS ObjectiveC,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)shell($|\\|)")) AS Shell,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)r($|\\|)")) AS R,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)perl($|\\|)")) AS Perl,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)scala($|\\|)")) AS Scala,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)go($|\\|)")) AS Go,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)haskell($|\\|)")) AS Haskell,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)swift($|\\|)")) AS Swift,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)matlab($|\\|)")) AS Matlab,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)clojure($|\\|)")) AS Clojure,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)groovy($|\\|)")) AS Groovy,
  #add some Adobe technologies
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)(cq5|aem)($|\\|)")) AS AEM,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)pdf($|\\|)")) AS PDF,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)adobe($|\\|)")) AS Adobe,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)(phonegap|cordova)($|\\|)")) AS Phonegap,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)(flash|flex)($|\\|)")) AS Flash,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)(psd|photoshop)($|\\|)")) AS Photoshop,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)actionscript($|\\|)")) AS Actionscript,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)coldfusion($|\\|)")) AS Coldfusion,
  COUNTIF(REGEXP_CONTAINS(questions.tags, "(^|\\|)xmp($|\\|)")) AS Xmp,
  COUNT(answers.id) as Answers
FROM
  `bigquery-public-data.stackoverflow.posts_answers` AS answers
RIGHT OUTER JOIN
  `bigquery-public-data.stackoverflow.posts_questions` AS questions
ON
  questions.id = answers.parent_id
GROUP BY
  qid, Asker
HAVING
  Year > 2009
#LIMIT
#  10