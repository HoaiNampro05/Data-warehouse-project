from ETL import *
import datetime
import pyodbc
from pyspark.sql import SparkSession
from pyspark.sql.functions import date_format
import os
import sys

def execute_sql_files_in_folder(folder_path, conn):
    # Get the list of files in the folder
    files = os.listdir(folder_path)

    # Iterate through each file in the folder
    for file_name in files:
        file_path = os.path.join(folder_path, file_name)

        # Check if the file is a SQL file
        if file_name.endswith(".sql"):
            print("Executing file:", file_name)

            # Execute the SQL file using the provided connection
            execute_sql_file(file_path, conn)

def execute_sql_file(file_path, conn):
    # Read the contents from the SQL file
    with open(file_path, 'r') as file:
        sql_content = file.read()

    # Execute the SQL statements using the provided connection
    cursor = conn.cursor()
    try:
        cursor.execute(sql_content)
        conn.commit()
        print("Successfully executed SQL file:", file_path)
    except Exception as e:
        print("Error executing SQL file:", file_path)
        print("Error message:", str(e))
    cursor.close()


URL_REPRES = "jdbc:sqlserver://Admin\TRAM1:1433;databaseName=RepresentativeOffice;user=sa;password=12345;"
URL_SALE = "jdbc:sqlserver://Admin\TRAM1:1433;databaseName=Sale;user=sa;password=12345;"
URL_IDB =  "jdbc:sqlserver://Admin\TRAM1:1433;databaseName=Integration;user=sa;password=12345;"
URL_DW =  "jdbc:sqlserver://Admin\TRAM1:1433;databaseName=datawarehouse;user=sa;password=12345;"
spark_connector = "C:/SPARK/spark-3.5.1-bin-hadoop3/jars/apache-spark-sql-connector.jar"
properties = {
    "user": "sa",
    "password": "12345",
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}

server_name = 'Admin\TRAM1'
database_name = 'datawarehouse'
username = 'sa'
password = '12345'
folder_path = 'F:/Ky2Nam4/KDL/Data-warehouse-project/cube'



END = datetime.date.today()
START = END - datetime.timedelta(days=1)
END = END.strftime("%Y-%m-%d")
START = START.strftime("%Y-%m-%d")

execute = startETL(URL_REPRES, URL_SALE, URL_IDB, URL_DW, properties, spark_connector)
execute.executeOLTPtoIDB(START,END)
execute.executeIDBtoDWH(START,END)

conn = pyodbc.connect(
    'DRIVER={SQL Server};SERVER=' + server_name + ';DATABASE=' + database_name + ';UID=' + username + ';PWD=' + password
)
execute_sql_files_in_folder(folder_path, conn)
conn.close()
sys.exit()