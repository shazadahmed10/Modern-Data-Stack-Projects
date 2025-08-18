
# Fivetran Setup Notes

**Source:** Google Drive  
**Destination:** Snowflake (Schema: bronze)  
**Sync Frequency:** Every 24 hours (incremental)  

### Steps:
1. Created a Google Drive connector in Fivetran.
2. Selected "Incremental" load method.
3. Mapped column names to Snowflake table fields.
4. Proceeded to open Snowflake worksheet and start manipulations to create silver/gold layer data.
