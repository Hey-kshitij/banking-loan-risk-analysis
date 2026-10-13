# Power BI Dashboard Build Guide

## Page 1: Executive Overview
- KPI cards: Total Applications, Approval Rate %, Approved Loan Value, Default Rate %
- Line chart: applications by month
- Bar chart: applications by loan type
- Donut chart: application status
- Slicers: application date, loan type, city, employment type

## Page 2: Default & Risk Analysis
- Bar chart: default rate by loan type
- Column chart: default rate by income band
- Column chart: default rate by credit-score band
- Matrix: employment type × repayment status
- Slicers: loan type, credit score, income band, city

## Page 3: Payment Performance
- KPI cards: Total Payment Due, Total Payment Received, Overdue Payments
- Bar chart: payment status counts
- Bar chart: overdue payment rate by loan type
- Table: loan ID, amount due, amount paid, payment status, due date

## Data model
- customers (1) → loans (many) using customer_id
- loans (1) → payments (many) using loan_id
- Import the two SQL reporting views for a simpler first dashboard. Avoid summing loan amounts after joining to payment-level rows, which can double-count loans.
- Use INR currency format and a footer: "Synthetic dataset for portfolio demonstration; not real customer or lending data."

A native `.pbix` must be saved from Power BI Desktop. This package includes data, SQL, DAX, and dashboard instructions but cannot create the proprietary PBIX file directly.
