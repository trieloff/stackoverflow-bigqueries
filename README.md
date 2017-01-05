# Prerequisites

Install Google Cloud SDK: https://cloud.google.com/sdk/docs/

# Running the query

````
$ bq query --format csv -n 10000 < delay.sql| tee delay.csv
````

# Prepare for advanced queries

You need to add billing information to your account to save data. We are creating a temporary table that joins information about the question with information about the first response.

````
$ bq query --destination_table "test.soquestions" --replace  < join.sql
````

# Building Sankey diagrams

````
bq query -n 10000 --format csv  < devjourney.sql | grep -v tag  | grep -v "between" | sed -e "s/\(.*\),before,\(.*\).*/+\1 \[\2\] cordova/" | sed -e "s/\(.*\),after,\(.*\).*/cordova \[\2\] -\1/" | pbcopy
````

Then copy the result into Sankeymatic.