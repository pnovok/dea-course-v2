-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Extract Data From the Returns SQL Table
-- MAGIC 1. Create Bronze Schema in Hive Metastore
-- MAGIC 1. Create External Table

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### 1. Create Bronze Schema in Hive Metastore

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS hive_metastore.bronze;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### 2. Create External Table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS hive_metastore.bronze.refunds
USING JDBC
OPTIONS (
  url 'jdbc:sqlserver://gizmobox-srv.database.windows.net:1433;database=gizmobox-db',
  dbtable 'refunds',
  user 'gizmoboxadm',
  password 'Gizmobox@Adm'
);  

-- COMMAND ----------

SELECT * FROM hive_metastore.bronze.refunds;

-- COMMAND ----------

DESC EXTENDED hive_metastore.bronze.refunds;

-- COMMAND ----------

CREATE TABLE gizmobox.bronze.Refunds (  
    refund_id INT PRIMARY KEY,  
    payment_id INT NOT NULL,  
    refund_timestamp TIMESTAMP NOT NULL,  
    refund_amount DECIMAL(10, 2) NOT NULL,  
    refund_reason STRING NOT NULL 
);

INSERT INTO gizmobox.bronze.Refunds  (refund_id, payment_id, refund_timestamp, refund_amount, refund_reason)  
VALUES  
(1, 66, '2025-01-10 11:30:00', 85.75, 'Payment Error:Retailer'),  
(2, 69, '2025-01-03 12:40:15', 120.50, 'Order Cancelled:Customer'),  
(3, 72, '2025-01-06 14:45:30', 65.00, 'Product Returned:Customer'),  
(4, 73, '2025-01-07 16:10:45', 210.99, 'Order Cancelled:Customer'),  
(5, 75, '2025-01-09 18:25:00', 45.20, 'Payment Error:Retailer'),  
(6, 80, '2025-01-10 09:35:20', 130.15, 'Order Cancelled:Customer'),  
(7, 83, '2025-01-12 11:20:40', 150.00, 'Product Returned:Customer'),  
(8, 85, '2025-01-14 13:15:30', 89.99, 'Order Cancelled:Customer'),  
(9, 89, '2025-01-15 15:00:00', 78.50, 'Payment Error:Retailer'),  
(10, 91, '2025-01-17 16:45:15', 250.75, 'Product Returned:Customer');
