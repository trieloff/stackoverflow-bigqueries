# Prerequisites

Install Google Cloud SDK: https://cloud.google.com/sdk/docs/

# Running the query

````
$ bq query --format csv -n 10000 < delay.sql| tee delay.csv
````