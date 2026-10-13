# Banking & Loan Risk Analysis (SQL + Power BI)

Portfolio project for entry-level Data Analyst roles using MySQL 8+, synthetic customer/loan/payment data, and Power BI reporting materials.

## Included
- `data/customers.csv` — 350 synthetic customers
- `data/loans.csv` — 600 synthetic loan applications
- `data/payments.csv` — synthetic payments for approved loans
- `sql/01_schema.sql` — database schema
- `sql/02_data_quality_checks.sql` — missing-value, duplicate, and validation checks
- `sql/03_analysis_queries.sql` — 15 business questions/queries
- `sql/04_reporting_views.sql` — reusable Power BI views
- `powerbi/DAX_measures.md` — KPI measures
- `powerbi/Dashboard_build_guide.md` — report page blueprint
- `docs/data_dictionary.md` — field and metric definitions
- `python/validate_dataset.py` — basic dataset validation
- `docs/resume_bullets.md` — resume entry and interview talking points

## Quick start (MySQL Workbench)
1. Run `sql/01_schema.sql`.
2. Import `customers.csv`, then `loans.csv`, then `payments.csv` using each table's Table Data Import Wizard. Keep headers mapped and blank fields as NULL.
3. Run `sql/02_data_quality_checks.sql`.
4. Run `sql/03_analysis_queries.sql`.
5. Run `sql/04_reporting_views.sql`.
6. Connect Power BI Desktop to MySQL or import the reporting views. Use the DAX measures and dashboard guide.

## Resume entry
**Banking & Loan Risk Analysis | MySQL, SQL, Power BI**
- Analyzed synthetic loan application and repayment data to study approval trends and default patterns across loan types and customer segments.
- Wrote SQL queries using JOINs, CTEs, window functions, conditional aggregation, and NULL handling to calculate portfolio KPIs and identify data-quality issues.
- Prepared a Power BI dashboard blueprint with measures for approval rate, default rate, approved loan value, and overdue payment performance.

## Interview pitch
"I created a loan-risk analysis project using synthetic customer, loan, and payment tables. I validated data quality, joined related tables, calculated approval and default rates, segmented results by credit score and income, and ranked loan types with CTEs and window functions. I then prepared Power BI measures and a dashboard plan."

## Important
The dataset is synthetic and not suitable for lending decisions. Do not describe synthetic findings as real-world results. A native `.pbix` file must be saved from Power BI Desktop; this bundle contains the data, SQL, DAX, and dashboard instructions to build it.
