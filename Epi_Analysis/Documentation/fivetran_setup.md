
# Fivetran Setup Notes

**Source:** Google Sheets  
**Destination:** Snowflake (Schema: bronze)  
**Sync Frequency:** Every 1 hour (incremental)  

### Steps:
1. Created a Google Sheets connector in Fivetran.
2. Selected "Incremental" load method.
3. Mapped column names to Snowflake table fields.
4. Set up basic transformation to drop unused columns.
