--Project Name: Epi Analysis Mini Project
--Date: 8/20/25
--Environment: Snowflake Worksheet

--View all of the tables in the database and schema so I know what tables to reference
USE SCHEMA epi_analysis.google_drive;
SHOW TABLES;


DESCRIBE TABLE DISEASE_CASES -- This has: type of disease = flu, timing, region and # of cases
DESCRIBE TABLE REGION_POPULATION -- 1 line = 1 region and population
DESCRIBE TABLE VACCINE_COVERAGE -- This has region, timing, vaccine type = flu vaccine and coverage % 


SELECT DISTINCT REGION --checking for unique regions
FROM DISEASE_CASES

SELECT DISTINCT REGION --checking for unique regions
FROM REGION_POPULATION

SELECT DISTINCT REGION --checking for unique regions
FROM VACCINE_COVERAGE

--STEP 1: Try to join
--Foreign keys for joining: region, month, year combo
--Note disease_cases and vaccine_coverage tables have multiple rows per region whereas region pop has 1 row per region
--Plan: make unique key, merge all datasets together. 
--Main analysis: Trends over time by region 


SELECT * FROM VACCINE_COVERAGE
ORDER BY _LINE -- sorting to see if there is 1 row per month-year

SELECT * FROM DISEASE_CASES
ORDER BY _LINE -- sorting to see if there is 1 row per month-year

-- Start with disease_cases. Combine columns to product new column with unique value
CREATE OR REPLACE VIEW DISEASE_CASES_2 AS 
SELECT MONTH, YEAR, REGION, DISEASE, CASES, REGION || '_' || TO_VARCHAR(MONTH) || '_' || TO_VARCHAR(YEAR) AS UNIQUE_ID
FROM DISEASE_CASES;

SELECT * FROM DISEASE_CASES_2 --confirming it worked


-- Move to vaccine coverage table
CREATE OR REPLACE VIEW VACCINE_COVERAGE_2 AS 
SELECT MONTH, YEAR, REGION, VACCINE_TYPE, COVERAGE_PERCENTAGE, REGION || '_' || TO_VARCHAR(MONTH) || '_' || TO_VARCHAR(YEAR) AS UNIQUE_ID
FROM VACCINE_COVERAGE;

SELECT * FROM VACCINE_COVERAGE_2 --confirming it worked


--Now merge 2 tables on unique_ID
CREATE OR REPLACE VIEW MERGED AS
SELECT v.MONTH, v.YEAR, v.REGION, v.VACCINE_TYPE, v.coverage_percentage, v.unique_id, c.cases, c.disease
FROM VACCINE_COVERAGE_2 v
JOIN DISEASE_CASES_2 c ON v.unique_id = c.unique_ID;

SELECT * FROM MERGED --confirming it worked
ORDER BY MONTH, YEAR

-- now clean up dataset to make ready for silver layer
CREATE OR REPLACE VIEW MERGED_FINAL AS
SELECT REGION, VACCINE_TYPE, COVERAGE_PERCENTAGE, UNIQUE_ID, CASES AS CASES_PER_100K, DISEASE,
    TO_VARCHAR(YEAR)  AS YEAR,
    TO_VARCHAR(MONTH) AS MONTH
FROM MERGED;

SELECT * FROM MERGED_FINAL --confirming it worked


-- MERGED_FINAL can be imported into PowerBI

-- For Fun/Practice: Find aggregate values by region for each year and merge this to region population values. 
CREATE OR REPLACE VIEW AGG AS
SELECT 
    region,
    YEAR,
    ROUND(AVG(COVERAGE_PERCENTAGE)) AS avg_coverage,
    ROUND(MIN(COVERAGE_PERCENTAGE)) AS min_coverage,
    ROUND(MAX(COVERAGE_PERCENTAGE)) AS max_coverage, 
    ROUND(AVG(CASES_PER_100K)) AS avg_cases,
    MIN(CASES_PER_100K) AS min_cases,
    MAX(CASES_PER_100K) AS max_cases, 
    SUM(CASES_PER_100K)   AS sum_cases,   
FROM MERGED_FINAL
GROUP BY region, year; --I want agg values for 2024 and 2025

SELECT * FROM AGG --confirming it worked

CREATE OR REPLACE VIEW AGG_FINAL AS
SELECT a.*, p.population -- i only want to bring over the population values from the region_pop table
FROM AGG a
LEFT JOIN REGION_POPULATION p ON a.region = p.region;

SELECT * FROM AGG_FINAL --confirming it worked
