## 📌 Project Overview
This project demonstrates an end-to-end modern data pipeline, from automated ingestion to business-ready dashboards. The goal is to showcase the integration of multiple tools and the transformation of raw data into insights.

**Pipeline:** Fivetran → Snowflake → dbt → Power BI

**Business Question:** What data points are in the epi analysis datasets and what are some trends they may point to?



## 📂 Repo Structure
| Folder | Purpose |
|--------|---------|
| `/data` | Example raw data |
| `/sql` | SQL scripts for Snowflake |
| `/screenshots` | Visual evidence of pipeline steps |
| `/documentation` | Tool-specific notes & setup steps |
| `/visualizations` | Power BI files |


## 🔍 Key Learnings
- Building a **bronze-silver-gold** data model
- Automating ingestion with Fivetran
- Writing modular SQL transformations
- Connecting Power BI to Snowflake for live dashboards

## ▶ How to Reproduce
1. Collect and organize datasets to use. In this case, CSV files proudced by ChatGPT on Epidemiological data for the purpose of using in this project. 
2. Set up a Snowflake account (free trial in this case).
3. Create a Fivetran connector from Google Sheets to Snowflake.
4. Run SQL scripts from a snowflake worksheet to go from bronze to silver layer.
5. Connect Power BI to Snowflake, do additional manipulations to go from silver layer to gold layer, and build visuals.

