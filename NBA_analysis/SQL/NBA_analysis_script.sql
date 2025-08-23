--Project Name: NBA Analysis Mini Project
--Date: 8/22/25

--View all of the tables in the database and schema so I know what tables to reference
USE SCHEMA nba_analysis.google_drive;
SHOW TABLES;


DESCRIBE TABLE NBA_TEAM_COSTS -- This has: ops costs, marketiong costs, travel costs, year, teams and player salaries. 
DESCRIBE TABLE NBA_TEAM_REVENUE -- revenues, teams and year

SELECT * FROM NBA_TEAM_COSTS --2021-2023 for 10 teams
ORDER BY _LINE

SELECT * FROM NBA_TEAM_REVENUE --2021 - 2023 for 10 teams again
ORDER BY _LINE

SELECT DISTINCT TEAM --checking for unique teams
FROM NBA_TEAM_COSTS

SELECT DISTINCT TEAM --checking for unique teams


SELECT DISTINCT TEAM
FROM NBA_TEAM_COSTS
WHERE TEAM NOT IN (SELECT DISTINCT TEAM FROM NBA_TEAM_REVENUE); -- checking to see if the unique Team values are the same between the tables. They are.
--Since the Teams are the same, I can treat this as the foreign key to merge.

--PART 1: Merge the datasets together on a TEAM_YEAR combo unique ID. The combo will preserve all of the rows

--Create TEAM_YEAR unique_id
--First in Costs table
CREATE OR REPLACE VIEW COSTS AS
SELECT TRAVEL_COST, OPERATIONS_COST, YEAR, MARKETING_COST, TEAM, PLAYER_SALARIES, TEAM || '_' || TO_VARCHAR(YEAR) AS UNIQUE_ID
FROM NBA_TEAM_COSTS
ORDER BY YEAR, TEAM;

SELECT * FROM COSTS --confirming it worked

--Next in revenue table
CREATE OR REPLACE VIEW REV AS
SELECT SPONSORSHIP_REVENUE, TICKET_SALES, YEAR, TEAM, MERCHANDISE_REVENUE, TOTAL_REVENUE, TEAM || '_' || TO_VARCHAR(YEAR) AS UNIQUE_ID
FROM NBA_TEAM_REVENUE
ORDER BY YEAR, TEAM;

SELECT * FROM REV --confirming it worked


--Now merge, and then make the column names shorter for easier scripting
CREATE OR REPLACE TABLE MERGED AS 
SELECT  c.*,
        r.sponsorship_revenue,
        r.merchandise_revenue,
        r.ticket_sales,
        r.total_revenue
FROM COSTS c
INNER JOIN REV r ON c.UNIQUE_ID = r.UNIQUE_ID;

SELECT * FROM MERGED --confirming it worked

-- Change column types and make column names shorter for silver layer
ALTER TABLE MERGED
RENAME COLUMN OPERATIONS_COST TO OPS_COST;
ALTER TABLE MERGED 
RENAME COLUMN SPONSORSHIP_REVENUE TO SPONSOR_REV;
ALTER TABLE MERGED
RENAME COLUMN MERCHANDISE_REVENUE TO MERCH_REV; 
ALTER TABLE MERGED
RENAME COLUMN TOTAL_REVENUE TO TOTAL_REV;

-- Change Year from num to character; also add a total costs and total_profit column for more in-depth analysis
CREATE OR REPLACE VIEW MERGED_FINAL AS
SELECT  TRAVEL_COST,
        OPS_COST,
        MARKETING_COST,
        PLAYER_SALARIES,
        (TRAVEL_COST + OPS_COST+MARKETING_COST + PLAYER_SALARIES) AS TOTAL_COST,
        SPONSOR_REV,
        MERCH_REV,
        TICKET_SALES,
        TOTAL_REV,
        (TOTAL_REV - TOTAL_COST) AS TOTAL_PROFIT,
        TEAM,
        UNIQUE_ID,
        TO_VARCHAR(YEAR) AS YEAR
FROM MERGED;

SELECT * FROM MERGED_FINAL --confirming it worked
