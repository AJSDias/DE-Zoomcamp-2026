import duckdb
import requests
from pathlib import Path

con = duckdb.connect("taxi_rides_ny.duckdb")
con.execute("CREATE SCHEMA IF NOT EXISTS prod")

con.execute("""
SELECT *
FROM read_csv_auto('data/fhv/fhv_tripdata_2019-01.csv')
LIMIT 5
""").fetchall()
