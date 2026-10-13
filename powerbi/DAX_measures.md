# Power BI DAX Measures

Import `vw_loan_portfolio` and `vw_payment_summary`. Adjust table names if you rename them.

```DAX
Total Applications = DISTINCTCOUNT(vw_loan_portfolio[loan_id])
Approved Applications = CALCULATE([Total Applications], vw_loan_portfolio[application_status] = "Approved")
Approval Rate % = DIVIDE([Approved Applications], [Total Applications], 0)
Approved Loans = CALCULATE([Total Applications], vw_loan_portfolio[application_status] = "Approved")
Defaulted Loans = CALCULATE(DISTINCTCOUNT(vw_loan_portfolio[loan_id]), vw_loan_portfolio[application_status] = "Approved", vw_loan_portfolio[repayment_status] = "Defaulted")
Default Rate % = DIVIDE([Defaulted Loans], [Approved Loans], 0)
Total Approved Loan Value = CALCULATE(SUM(vw_loan_portfolio[loan_amount]), vw_loan_portfolio[application_status] = "Approved")
Average Loan Amount = AVERAGE(vw_loan_portfolio[loan_amount])
Average Credit Score = AVERAGE(vw_loan_portfolio[credit_score])
Total Payment Due = SUM(vw_payment_summary[total_amount_due])
Total Payment Received = SUM(vw_payment_summary[total_amount_paid])
Overdue Payments = SUM(vw_payment_summary[overdue_payment_count])
```
Format approval/default rates as percentages and loan values as INR. Results are for synthetic data only.
