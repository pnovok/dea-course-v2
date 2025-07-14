-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Create or Replace & CTAS
-- MAGIC 1. Difference between Create or Replace and Drop and Create Table statements
-- MAGIC 2. CTAS statement
-- MAGIC
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### 1. Difference between Create or Replace and Drop and Create Table statements
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Behaviour of the DROP and CREATE statements

-- COMMAND ----------

DROP TABLE IF EXISTS dbdemos_pavel.delta_lake.companies;

CREATE TABLE dbdemos_pavel.delta_lake.companies
  (company_id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   company_name STRING,
   founded_date DATE,
   country      STRING);

INSERT INTO dbdemos_pavel.delta_lake.companies 
(company_name, founded_date, country)
VALUES ("Apple", "1976-04-01", "USA"),
       ("Microsoft", "1975-04-04", "USA"),
       ("Google", "1998-09-04", "USA"),
       ("Amazon", "1994-07-05", "USA"),
       ("Tencent", "1998-11-11", "China");   

-- COMMAND ----------

DESC HISTORY dbdemos_pavel.delta_lake.companies;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Behaviour of the CREATE OR REPLACE statement

-- COMMAND ----------

DROP TABLE IF EXISTS dbdemos_pavel.delta_lake.companies;

-- COMMAND ----------

CREATE OR REPLACE TABLE dbdemos_pavel.delta_lake.companies
  (company_id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   company_name STRING,
   founded_date DATE,
   country      STRING);

INSERT INTO dbdemos_pavel.delta_lake.companies 
(company_name, founded_date, country)
VALUES ("Apple", "1976-04-01", "USA"),
       ("Microsoft", "1975-04-04", "USA"),
       ("Google", "1998-09-04", "USA"),
       ("Amazon", "1994-07-05", "USA"),
       ("Tencent", "1998-11-11", "China");   

-- COMMAND ----------

DESC HISTORY dbdemos_pavel.delta_lake.companies;

-- COMMAND ----------

select * from dbdemos_pavel.delta_lake.companies;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### 2. CTAS statement

-- COMMAND ----------

DROP TABLE dbdemos_pavel.delta_lake.companies_china;

-- COMMAND ----------

CREATE TABLE dbdemos_pavel.delta_lake.companies_china
AS
SELECT CAST(company_id AS INT) AS company_id,
       company_name,
       founded_date,
       country 
  FROM dbdemos_pavel.delta_lake.companies
 WHERE country = 'China';

-- COMMAND ----------

DESC dbdemos_pavel.delta_lake.companies_china;

-- COMMAND ----------

ALTER TABLE dbdemos_pavel.delta_lake.companies_china 
  ALTER COLUMN founded_date COMMENT 'Date the company was founded';

-- COMMAND ----------

ALTER TABLE dbdemos_pavel.delta_lake.companies_china 
  ALTER COLUMN company_id SET NOT NULL;

-- COMMAND ----------

DESC EXTENDED dbdemos_pavel.delta_lake.companies_china ;

-- COMMAND ----------

SELECT * FROM dbdemos_pavel.delta_lake.companies_china;

-- COMMAND ----------

DESC HISTORY dbdemos_pavel.delta_lake.companies_china;
