-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Set-up the project environment for GizmoBox Data Lakehouse

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### 1. Access the container gizmobox

-- COMMAND ----------

-- %fs ls 'abfss://gizmobox@deacourseextdl.dfs.core.windows.net/landing/operational_data/'


-- COMMAND ----------

-- MAGIC %fs ls 's3://pnovok-demo-workspace-ext/landing/operational_data/addresses'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### 2. Create External Location

-- COMMAND ----------

CREATE EXTERNAL LOCATION IF NOT EXISTS dea_course_ext_dl_gizmobox
    URL 's3://pnovok-demo-workspace-ext/landing/operational_data/'
    WITH (STORAGE CREDENTIAL dea_course_ext_sc)
    COMMENT 'External Location For the Gizmobox Data Lakehouse'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### 3. Create the catalog - gizmobox

-- COMMAND ----------

SHOW CATALOGS;

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS gizmobox
      MANAGED LOCATION 's3://pnovok-demo-workspace-ext/'
      COMMENT 'This is the catalog for the Gizmobox Data Lakehouse' ;

-- COMMAND ----------

DROP  CATALOG gizmobox CASCADE; 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### 4. Create Schemas
-- MAGIC 1. Landing
-- MAGIC 1. Bronze
-- MAGIC 1. Silver
-- MAGIC 1. Gold

-- COMMAND ----------

SELECT current_catalog();

-- COMMAND ----------

USE CATALOG gizmobox;


CREATE SCHEMA IF NOT EXISTS landing
    MANAGED LOCATION 's3://pnovok-demo-workspace-ext/landing';  
CREATE SCHEMA IF NOT EXISTS bronze
   MANAGED LOCATION 's3://pnovok-demo-workspace-ext/bronze';  
CREATE SCHEMA IF NOT EXISTS silver
     MANAGED LOCATION 's3://pnovok-demo-workspace-ext/silver';  
CREATE SCHEMA IF NOT EXISTS gold
   MANAGED LOCATION 's3://pnovok-demo-workspace-ext/gold';            

-- COMMAND ----------

SHOW SCHEMAS;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### 5. Create Volume

-- COMMAND ----------

USE CATALOG gizmobox;
USE SCHEMA landing;

CREATE EXTERNAL VOLUME IF NOT EXISTS operational_data
    LOCATION 's3://pnovok-demo-workspace-ext/landing/operational_data';

-- COMMAND ----------

-- MAGIC %fs ls /Volumes/gizmobox/landing/operational_data/addresses
