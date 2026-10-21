# Customer Data Quality & Master Data Management System

**Project 1 | Days 1–4 of the Nexus 21-Day Data & Automation Portfolio**

## Overview
This project demonstrates a customer master-data quality workflow using **Excel, Power Query, MySQL and Python**. It consolidates source data, validates customer records, reconciles quality results across tools, and exports a validated master alongside exceptions for review.

## Business problem
Incomplete, inconsistent and duplicate customer data can undermine reporting, customer communication and operational decisions. The goal was to establish a repeatable process for identifying issues and producing a reliable customer master.

## Objectives
- Combine and standardise customer records.
- Validate identifiers, contact details and registration dates.
- Flag invalid or incomplete records.
- Reconcile validation metrics across Excel/Power Query, SQL and Python.
- Export quality KPIs, exception records and the validated master.

## Tools
| Tool | Application |
| --- | --- |
| Excel & Power Query | Source consolidation, cleaning and inspection |
| MySQL | SQL-based validation and reconciliation |
| Python (pandas) | Automated quality checks and CSV exports |
| Jupyter Notebook | Reproducible Python analysis |

## Workflow
1. Inspect and combine source spreadsheets.
2. Standardise field types and formats, including dates.
3. Validate IDs, required fields and email formatting.
4. Reconcile totals and record classifications across tools.
5. Export validated customer data, exceptions and KPIs.

## Verified results
| Metric | Result |
| --- | ---: |
| Final customer records | **601** |
| Unique customer IDs | **601** |
| Duplicate customer IDs | **0** |
| Valid records | **568 (94.51%)** |
| Invalid records | **33 (5.49%)** |
| Missing phone values | **16** |
| Missing email values | **9** |
| Missing registration dates | **7** |
| Malformed email flags | **9** |
| Classification matches | **601 / 601** |

These metrics describe the final 601-record master, not intermediate consolidation totals.

## Key findings
- **33 records** required exception handling.
- Missing phone values were the most frequent missing-field issue among the tracked contact/date fields.
- The final master contained **no duplicate customer IDs**.
- Validation classifications reconciled across the checks performed.

## Repository files
| File | Purpose |
| --- | --- |
| `Customer Data Quality Analysis.xlsx` | Excel quality analysis |
| `Customer Data Quality Project.sql` | SQL queries |
| `Customer Data Quality Project.xlsx` | Spreadsheet working file |
| `Customer_Data_Quality_Analysis.ipynb` | Python notebook |
| `customer_data_quality_exceptions.csv` | Flagged records |
| `customer_data_quality_project.xlsx` | Source/earlier workbook |
| `data_quality_kpi_summary.csv` | Quality KPI export |
| `master_customers_python_validated.csv` | Validated customer master |
| `master_customers_sql.xlsx` | SQL-related workbook |
| `master_customers_sql_clean.csv` | Cleaned SQL export |

Multiple spreadsheets are preserved as separate working stages; they should not be assumed to be identical.

## How to explore
1. Open `Customer_Data_Quality_Analysis.ipynb` in Jupyter or Colab to inspect Python validation.
2. Review `Customer Data Quality Project.sql` in MySQL Workbench; local database setup may be required.
3. Examine `data_quality_kpi_summary.csv`, `customer_data_quality_exceptions.csv`, and `master_customers_python_validated.csv`.
4. Review the Excel workbooks for spreadsheet and Power Query work.

## Business value
This workflow demonstrates a practical approach to building a more trustworthy customer master while retaining traceable exception records for correction. It supports better reporting, CRM operations and downstream automation.

## Publication and privacy
**Before uploading files publicly**, review all spreadsheets, CSVs, SQL scripts and notebooks for real personal data, credentials and local paths. Replace personal data with anonymised or synthetic records where needed.

## Portfolio context
The first of five connected projects: Customer Data Quality → Business Operations Intelligence → Service Request & SLA Automation → Churn Analytics → Customer Retention Automation.
