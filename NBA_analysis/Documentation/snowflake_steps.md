## Snowflake Steps/Notes

1. Create database before establishing FIvetran connection (home for schema and datasets/tables)
2. Create databases from the DATA tab on the left
3. Once fivetran connection is established to desired database, look for schema name created from fivetran connection and tables that should have the datasets
4. To start using SQL for transformations, go to PROJECTS tab and then start a new worksheet
5. At the top of the worksheet, there is a drop down that says 'Database;. Select the database and schema combination that has the tables from the Fivetran connection
6. The SQL code will then point to the datasets brought over from Fivetran.  
