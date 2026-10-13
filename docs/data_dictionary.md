# Data Dictionary
## customers.csv
- customer_id: synthetic unique customer key
- age: age in years
- annual_income: annual income in INR
- employment_type: employment category
- city: sample Maharashtra city
- education_level: education category
- credit_score: synthetic credit score

## loans.csv
- loan_id: synthetic unique loan/application key
- customer_id: references customers
- application_date: application date
- loan_type: Personal, Home, Auto, Education, or Business
- loan_amount: requested amount in INR
- loan_term_months: term in months
- interest_rate_pct: synthetic annual rate; intentionally missing in a few rows for practice
- application_status: Approved, Rejected, Pending
- repayment_status: Current, Closed, Defaulted, Late, Not Applicable

## payments.csv
- payment_id: synthetic unique payment key
- loan_id: references loans
- due_date: scheduled due date
- payment_date: sample payment date; blank for unpaid or selected missing-value practice rows
- amount_due: scheduled payment in INR
- amount_paid: amount received
- payment_status: Paid, Paid Late, Overdue

## Metric definitions
- Approval rate = approved applications / all applications.
- Default rate = approved loans marked Defaulted / all approved loans.
- Overdue payment rate = payment rows marked Overdue / all payment rows.
- All values and records are synthetic and should not be used for real lending decisions.
