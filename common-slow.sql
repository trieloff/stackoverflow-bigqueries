#standardSQL
SELECT
  IFNULL(hnslow.word, IFNULL(soslow.word, ghslow.word)) AS word,
  PERCENT_RANK() OVER (ORDER BY IFNULL(soslow.soslow, 0)) AS soslow,
  PERCENT_RANK() OVER (ORDER BY IFNULL(soslow.sofast, 0)) AS sofast,
  (PERCENT_RANK() OVER (ORDER BY soslow.sofast)) - (PERCENT_RANK() OVER (ORDER BY soslow.soslow)) AS sospeed,
  PERCENT_RANK() OVER (ORDER BY IFNULL(hnslow.hnslow, 0)) AS hnslow,
  PERCENT_RANK() OVER (ORDER BY IFNULL(hnslow.hnfast, 0)) AS hnfast,
  (PERCENT_RANK() OVER (ORDER BY hnslow.hnfast)) - (PERCENT_RANK() OVER (ORDER BY hnslow.hnslow)) AS hnspeed,
  PERCENT_RANK() OVER (ORDER BY IFNULL(ghslow.ghslow, 0)) AS ghslow,
  PERCENT_RANK() OVER (ORDER BY IFNULL(ghslow.ghfast, 0)) AS ghfast,
  (PERCENT_RANK() OVER (ORDER BY ghslow.ghfast)) - (PERCENT_RANK() OVER (ORDER BY ghslow.ghslow)) AS ghspeed,
  (PERCENT_RANK() OVER (ORDER BY soslow.sofast)) - (PERCENT_RANK() OVER (ORDER BY soslow.soslow)) + (PERCENT_RANK() OVER (ORDER BY hnslow.hnfast)) - (PERCENT_RANK() OVER (ORDER BY hnslow.hnslow)) + (PERCENT_RANK() OVER (ORDER BY ghslow.ghfast)) - (PERCENT_RANK() OVER (ORDER BY ghslow.ghslow)) AS consensusspeed,
  PERCENT_RANK() OVER (ORDER BY IFNULL(soslow.soold, 0)) AS soold,
  PERCENT_RANK() OVER (ORDER BY IFNULL(soslow.sofresh, 0)) AS sofresh,
  (PERCENT_RANK() OVER (ORDER BY soslow.sofresh)) - (PERCENT_RANK() OVER (ORDER BY soslow.soold)) AS sonovelty,
  PERCENT_RANK() OVER (ORDER BY IFNULL(hnslow.hnold, 0)) AS hnold,
  PERCENT_RANK() OVER (ORDER BY IFNULL(hnslow.hnfresh, 0)) AS hnfresh,
  (PERCENT_RANK() OVER (ORDER BY hnslow.hnfresh)) - (PERCENT_RANK() OVER (ORDER BY hnslow.hnold)) AS hnnovelty,
  PERCENT_RANK() OVER (ORDER BY IFNULL(ghslow.ghold, 0)) AS ghold,
  PERCENT_RANK() OVER (ORDER BY IFNULL(ghslow.ghfresh, 0)) AS ghfresh,
  (PERCENT_RANK() OVER (ORDER BY ghslow.ghfresh)) - (PERCENT_RANK() OVER (ORDER BY ghslow.ghold)) AS ghnovelty,
(PERCENT_RANK() OVER (ORDER BY soslow.sofresh)) - (PERCENT_RANK() OVER (ORDER BY soslow.soold)) + (PERCENT_RANK() OVER (ORDER BY hnslow.hnfresh)) - (PERCENT_RANK() OVER (ORDER BY hnslow.hnold)) + (PERCENT_RANK() OVER (ORDER BY ghslow.ghfresh)) - (PERCENT_RANK() OVER (ORDER BY ghslow.ghold)) AS consensusnovelty,
  PERCENT_RANK() OVER (ORDER BY IFNULL(soslow.soinsecure, 0)) AS soinsecure,
  PERCENT_RANK() OVER (ORDER BY IFNULL(soslow.sosecure, 0)) AS sosecure,
  (PERCENT_RANK() OVER (ORDER BY soslow.sosecure)) - (PERCENT_RANK() OVER (ORDER BY soslow.soinsecure)) AS sosecurity,
  PERCENT_RANK() OVER (ORDER BY IFNULL(hnslow.hninsecure, 0)) AS hninsecure,
  PERCENT_RANK() OVER (ORDER BY IFNULL(hnslow.hnsecure, 0)) AS hnsecure,
  (PERCENT_RANK() OVER (ORDER BY hnslow.hnsecure)) - (PERCENT_RANK() OVER (ORDER BY hnslow.hninsecure)) AS hnsecurity,
  PERCENT_RANK() OVER (ORDER BY IFNULL(ghslow.ghinsecure, 0)) AS ghinsecure,
  PERCENT_RANK() OVER (ORDER BY IFNULL(ghslow.ghsecure, 0)) AS ghsecure,
  (PERCENT_RANK() OVER (ORDER BY ghslow.ghsecure)) - (PERCENT_RANK() OVER (ORDER BY ghslow.ghinsecure)) AS ghsecurity,
(PERCENT_RANK() OVER (ORDER BY soslow.sosecure)) - (PERCENT_RANK() OVER (ORDER BY soslow.soinsecure)) + (PERCENT_RANK() OVER (ORDER BY hnslow.hnsecure)) - (PERCENT_RANK() OVER (ORDER BY hnslow.hninsecure)) + (PERCENT_RANK() OVER (ORDER BY ghslow.ghsecure)) - (PERCENT_RANK() OVER (ORDER BY ghslow.ghinsecure)) AS consensussecurity
FROM
  test.hnslow
FULL JOIN
  test.soslow
ON
  hnslow.word = soslow.word
FULL JOIN
  test.ghslow
ON
  hnslow.word = ghslow.word
ORDER BY
consensusspeed DESC