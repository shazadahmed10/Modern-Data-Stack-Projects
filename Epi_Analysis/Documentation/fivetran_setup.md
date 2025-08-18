
# Fivetran Setup Notes

**Source:** Google Drive  
**Destination:** Snowflake (Schema: bronze)  
**Sync Frequency:** Every 24 hours (incremental)  

### Steps:
1. Established a 'Destination' with my desired Snowflake account, warehouse and database.
2. Initiated a Google Drive connection in Fivetran.
3. Pointed connection to Snowflake destination created in Step 1.
5. In connection steup menu, selected Snowflake schema name and google drive URL
6. Selected "Incremental" load method.
7. Tested the connection. 
8. In snowflake, checked for datasets loaded into the schema created during Fivetran connection setup (step 5).
9. Proceeded to open Snowflake worksheet, started manipulations to create silver/gold layer data.
