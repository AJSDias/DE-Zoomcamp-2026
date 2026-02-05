# create external table
CREATE OR REPLACE EXTERNAL TABLE `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://de_zoomcamp26_homework_ad123/yellow_tripdata_2024-*.parquet']
);

# create materialized table (non-partioned)
CREATE OR REPLACE TABLE dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_non_partioned AS
SELECT * FROM dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data;

# What is count of records for the 2024 Yellow Taxi Data?
SELECT count(*) FROM `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_non_partioned`;

# Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
SELECT COUNT(DISTINCT(PULocationID)) FROM `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data`;

# Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
SELECT COUNT(DISTINCT(PULocationID)) FROM `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_non_partioned`;

# Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery.
SELECT PULocationID FROM `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_non_partioned`;

# Now write a query to retrieve the PULocationID and DOLocationID on the same table.
SELECT PULocationID,DOLocationID FROM `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_non_partioned`;

# How many records have a fare_amount of 0?
SELECT COUNT(*) FROM `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_non_partioned`
WHERE fare_amount=0;

# What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy)
CREATE OR REPLACE TABLE `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_partioned`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS (
  SELECT * FROM `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data`
);

# Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive).
# Use the materialized table you created earlier in your from clause and note the estimated bytes.
SELECT DISTINCT(VendorID) FROM dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_non_partioned
WHERE tpep_dropoff_datetime BETWEEN "2024-03-01" AND "2024-03-15";

# Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive).
# Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed.
SELECT DISTINCT(VendorID) FROM dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_partioned
WHERE tpep_dropoff_datetime BETWEEN "2024-03-01" AND "2024-03-15";

# No Points: Write a SELECT count(*) query FROM the materialized table you created. How many bytes does it estimate will be read? Why?
SELECT COUNT(*) FROM `dezoomcamp26_yellowtaxidata_ad.yellow_taxi_2024data_non_partioned`;