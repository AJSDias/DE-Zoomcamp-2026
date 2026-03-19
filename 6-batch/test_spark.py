import os
os.environ["HADOOP_HOME"] = r"C:\hadoop"
os.environ["PATH"] += r";C:\hadoop\bin"

import sys
os.environ['PYSPARK_PYTHON'] = sys.executable
os.environ['PYSPARK_DRIVER_PYTHON'] = sys.executable

if "SPARK_HOME" in os.environ:
    del os.environ["SPARK_HOME"]

import pyspark
from pyspark.sql import SparkSession
import traceback

try:
    spark = SparkSession.builder \
        .master("local[*]") \
        .appName('test') \
        .getOrCreate()

    print("Spark initialized.")
    data = [{"id": 1, "val": "A"}, {"id": 2, "val": "B"}]
    df = spark.createDataFrame(data)
    
    # Try writing a file to see if NativeIO still errors
    df.repartition(2).write.mode("overwrite").parquet("./test_output/")
    print("SUCCESS: Parquet file written successfully.")
except Exception as e:
    print(f"FAILED:")
    traceback.print_exc()