from pyspark.sql.functions import date_format
from pyspark.sql import SparkSession
import os
import pyodbc

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
    
class OLTPtoIDB:

    def __init__(self, URL_REPRES, URL_SALE, URL_IDB, properties, spark):
        self.URL_REPRES = URL_REPRES
        self.URL_SALE = URL_SALE
        self.URL_IDB = URL_IDB
        self.properties = properties
        self.spark = spark


    def SaleToIDB(self, sale_table, idb_table, start, end):
        condition = f"time<='{end}' and time >'{start}'"
        if sale_table=="Orders":
            condition = f"OrderDate<='{end}' and OrderDate >'{start}'"
        print(sale_table,condition)
        df = self.spark.read.jdbc(url=self.URL_SALE, table=sale_table, properties=self.properties).filter(condition)
        df.write.jdbc(url=self.URL_IDB,
                table=idb_table,
                mode = "append",
                properties=self.properties)
        return 0
    
    def RepreToIDB(self, repres_table, idb_table, start, end):
        condition = f"time<='{end}' and time >'{start}'"
        if repres_table=="Customers":
            condition = f"FirstOrderDate<='{end}' and FirstOrderDate >'{start}'"
        print(repres_table,condition)
        df = self.spark.read.jdbc(url=self.URL_REPRES, table=repres_table, properties=self.properties).filter(condition)
        df.write.jdbc(url=self.URL_IDB,
                table=idb_table,
                mode = "append",
                properties=self.properties)
        return 0
    
class IDBtoDWH:

    def __init__(self, URL_IDB, URL_DW, properties, spark):
        self.URL_IDB = URL_IDB
        self.URL_DW = URL_DW
        self.properties = properties
        self.spark = spark

    def nochange_table_idb_to_dw(self, idb_table, wh_table,start, end):
        condition = f"time<='{end}' and time >'{start}'"
        print(idb_table,condition)
        df = self.spark.read.jdbc(url=self.URL_IDB, table=idb_table, properties=self.properties).filter(condition)
        if idb_table=="RepresentativeOffices":
            df = df.withColumnRenamed("CityId", "CityKey")
        if idb_table=="Stores":
            df = df.withColumnRenamed("StoreId", "StoreKey")
            df = df.withColumnRenamed("CityId", "CityKey")
        if idb_table=="Items":
            df = df.withColumnRenamed("ItemId", "ItemKey")
        df.write.jdbc(url=self.URL_DW,
                table=wh_table,
                mode = "append",
                properties=self.properties)
        return 0
    
    def idb_customer_to_dw_customer(self, start, end):
        df = self.spark.read.jdbc(url=self.URL_IDB, table="Customers", properties=self.properties)
        df.createOrReplaceTempView("Customers")
        dft = self.spark.read.jdbc(url=self.URL_IDB, table="TravelCustomers", properties=self.properties)
        dft.createOrReplaceTempView("TravelCustomers")
        dfp = self.spark.read.jdbc(url=self.URL_IDB, table="PostalCustomers", properties=self.properties)
        dfp.createOrReplaceTempView("PostalCustomers")
        query = f"""
        SELECT cus.Customerid, cus.CustomerName, cus.CityId,
        CASE
        WHEN EXISTS (SELECT customerid FROM TravelCustomers WHERE customerid = cus.customerid) THEN 1
        ELSE 0
        END AS Travel,
        CASE
        WHEN EXISTS (SELECT customerid FROM PostalCustomers WHERE customerid = cus.customerid) THEN 1
        ELSE 0
        END AS Postal,
        cus.FirstOrderDate
        FROM Customers AS cus
        WHERE cus.FirstOrderDate>='{start}' and cus.FirstOrderDate<'{end}';
        """
        result = self.spark.sql(query)
        dwdf = result.toDF("CustomerKey","CustomerName","CityKey","Travel","Postal","FirstOrderDate")
        dwdf.write.jdbc(url=self.URL_DW,
                table="DimCustomer",
                mode = "append",
                properties=self.properties)
        return 0
    
    def idb_to_order_item_facts(self ,start, end):
        df = self.spark.read.jdbc(url=self.URL_IDB, table="Customers", properties=self.properties)
        df.createOrReplaceTempView("Customers")
        df_it = self.spark.read.jdbc(url=self.URL_IDB, table="Items", properties=self.properties)
        df_it.createOrReplaceTempView("Items")
        df_od = self.spark.read.jdbc(url=self.URL_IDB, table="Orders", properties=self.properties)
        df_od.createOrReplaceTempView("Orders")
        df_ot = self.spark.read.jdbc(url=self.URL_IDB, table="OrderedItems", properties=self.properties)
        df_ot.createOrReplaceTempView("OrderedItems")
        query = f""" SELECT ot.Time, ot.ItemId AS ItemKey, cus.CustomerId AS CustomerKey,
            ot.OrderedQuantity, ot.OrderCost, ot.OrderCost - (ot.OrderedQuantity * it.Price) AS Profit
        FROM OrderedItems ot, Items it, Customers cus, Orders od
        WHERE ot.time>='{start}' and ot.time<'{end}' and ot.ItemId = it.ItemId AND ot.OrderId = od.OrderId AND od.CustomerId = cus.CustomerId;
        """
        result = self.spark.sql(query)
        result = result.withColumn("TimeKey", date_format(result.Time, "yyyyMMdd"))
        result = result.select("TimeKey","ItemKey","CustomerKey","OrderedQuantity","OrderCost","Profit")
        dwdf = result.toDF("TimeKey","ItemKey","CustomerKey","OrderedQuantity","OrderedCost","Profit")
        dwdf.write.jdbc(url=self.URL_DW,
                table="FactOrderItems",
                mode = "append",
                properties=self.properties)
        return 0
    
    def idb_to_store_item_facts(self, start, end):
        df =  self.spark.read.jdbc(url=self.URL_IDB, table="StoredItems", properties=self.properties)
        df.createOrReplaceTempView("StoredItems")
        query = f"""
        SELECT Time,ItemId,StoreId,StoredQuantity
        FROM StoredItems
        where Time>='{start}' and Time<'{end}';
        """
        result = self.spark.sql(query)
        result = result.withColumn("TimeKey", date_format(result.Time, "yyyyMMdd"))
        result = result.select("TimeKey","ItemId","StoreId","StoredQuantity")
        dwdf =  result.toDF("TimeKey","ItemKey","StoreKey","Quantity")
        dwdf.write.jdbc(url=self.URL_DW,
                table="FactStoreItems",
                mode = "append",
                properties=self.properties)
        return 0


class startETL:
    def __init__(self, URL_REPRES, URL_SALE, URL_IDB, URL_DW, properties, spark_connector):
        self.URL_REPRES = URL_REPRES
        self.URL_SALE = URL_SALE
        self.URL_IDB = URL_IDB
        self.URL_DW = URL_DW
        self.properties = properties
        self.spark = SparkSession.builder \
        .appName("Read from MSSQL") \
        .config("spark.driver.extraClassPath", spark_connector) \
        .getOrCreate()
        self.database = [("RepresentativeOffices","RepresentativeOffices","sale"),
           ("Stores","Stores","sale"),
           ("Items","Items","sale"),
           ("Customers","Customers","repres"),
           ("TravelCustomers","TravelCustomers","repres"),
           ("PostalCustomers","PostalCustomers","repres"),
           ("StoredItems","StoredItems","sale"),
           ("Orders","Orders","sale"),
           ("OrderedItems","OrderedItems","sale")
          ]
        self.datawarehouse = [
            ("RepresentativeOffices","DimRepresentativeOffice"),
            ("Stores","DimStore"),
            ("Items","DimItem"),
        ]

    def executeOLTPtoIDB(self,time_start,time_end):
        process = OLTPtoIDB(self.URL_REPRES, self.URL_SALE, self.URL_IDB, self.properties, self.spark)
        for x in self.database:
            if x[2]=="sale":
                process.SaleToIDB(x[0],x[1],time_start,time_end)
            else:
                process.RepreToIDB(x[0],x[1],time_start,time_end)
    
    def executeIDBtoDWH(self,time_start,time_end):
        process = IDBtoDWH(self.URL_IDB, self.URL_DW, self.properties, self.spark)
        for x in self.datawarehouse:
            process.nochange_table_idb_to_dw(x[0],x[1],time_start,time_end)
        process.idb_customer_to_dw_customer(time_start,time_end)
        process.idb_to_order_item_facts(time_start,time_end)
        process.idb_to_store_item_facts(time_start,time_end)
        



# URL_REPRES = "jdbc:sqlserver://PHUONGHAM\KDL:1433;databaseName=RepresentativeOffice;user=sa;password=12345;"
# URL_SALE = "jdbc:sqlserver://PHUONGHAM\KDL:1433;databaseName=sale;user=sa;password=12345;"
# URL_IDB =  "jdbc:sqlserver://PHUONGHAM\KDL:1433;databaseName=Integration;user=sa;password=12345;"
# URL_DW =  "jdbc:sqlserver://PHUONGHAM\KDL:1433;databaseName=datawarehouse;user=sa;password=12345;"
# time_start = "2008-01-01"
# time_end = "2023-12-02"
# properties = {
#         "user": "sa",
#         "password": "12345",
#         "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
#     }
# spark = SparkSession.builder \
#         .appName("Read from MSSQL") \
#         .config("spark.driver.extraClassPath", "E:/S2Y4/KDL/tech/spark/spark-3.5.1-bin-hadoop3/jars/apache-spark-sql-connector.jar") \
#         .getOrCreate()

# execute = startETL(URL_REPRES, URL_SALE, URL_IDB, URL_DW, properties, spark, time_start, time_end)
# # execute.executeOLTPtoIDB()
# execute.executeIDBtoDWH()

