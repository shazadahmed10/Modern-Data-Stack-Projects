## 📌 Project Overview
This project demonstrates an end-to-end modern data pipeline, from automated ingestion to business-ready dashboards. The goal is to showcase the integration of multiple tools and the transformation of raw data into insights.

**Pipeline:** Fivetran → Snowflake → Power BI

**Business Question:** What data points are in the epi analysis datasets and what are some trends they may point to?



## 📂 Repo Structure
| Folder | Purpose |
|--------|---------|
| `/data` | Example raw data |
| `/SQL` | SQL scripts for Snowflake |
| `/Screenshots` | Visual evidence of pipeline steps |
| `/Documentation` | Tool-specific notes & setup steps |
| `/Viz` | Power BI files |


## 🔍 Key Learnings
- Building a **bronze-silver-gold** data model
- Automating ingestion with Fivetran
- Writing modular SQL transformations
- Connecting Power BI to Snowflake for live dashboards

## ▶ How to Reproduce
1. Collect and organize datasets to use. In this case, CSV files proudced by ChatGPT on Epidemiological data for the purpose of using in this project.
2. Place datasets in a central location like Google Drive so Fivetran can easily connect to it.
3. Set up a Snowflake account (free trial in this case).
4. Create a Fivetran connector from Google Sheets to Snowflake.
5. Run SQL scripts from a snowflake worksheet to go from bronze to silver layer.
6. Connect Power BI to Snowflake, do additional manipulations to go from silver layer to gold layer, and build visuals.

