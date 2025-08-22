
## Steps for Starting PowerBI report

1. Open PowerBI Desktop
2. Click on 'Get data from other sources' and Click on Snowflake button
3. In the pop up connector menu, input the server name(found in Snowflake) and warehouse name where silver layer tables sit. Click OK
4. All of the databases from the WH should appear in PowerBI navigator. Expand the Epi_analysis database
5. Expand the google_drive schema and check the boxes for the relvant datasets: agg_final and merged_final
6. Click Load to import into PowerBI. For the connection settings, choose 'Import' since this is a one time import.
7. To transform data even more, click on 'transform data' instead of load.
8. Once loaded, start building visuals. 
