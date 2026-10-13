USE loan_risk_analysis;
-- Duplicate key checks
SELECT customer_id, COUNT(*) FROM customers GROUP BY customer_id HAVING COUNT(*)>1;
SELECT loan_id, COUNT(*) FROM loans GROUP BY loan_id HAVING COUNT(*)>1;
SELECT payment_id, COUNT(*) FROM payments GROUP BY payment_id HAVING COUNT(*)>1;
-- Missing values
SELECT SUM(loan_amount IS NULL) AS missing_loan_amount,
       SUM(interest_rate_pct IS NULL) AS missing_interest_rate FROM loans;
SELECT SUM(payment_date IS NULL) AS missing_payment_date FROM payments;
-- Validation checks
SELECT * FROM customers WHERE age<18 OR age>100 OR credit_score<300 OR credit_score>900;
SELECT * FROM loans WHERE loan_amount<=0 OR loan_term_months<=0;
SELECT * FROM payments WHERE amount_due<0 OR amount_paid<0;
-- Reporting view: preserve source values; COALESCE only for reporting
CREATE OR REPLACE VIEW vw_loans_reporting AS
SELECT loan_id, customer_id, application_date, loan_type, loan_amount, loan_term_months,
       COALESCE(interest_rate_pct,0) AS interest_rate_pct, application_status, repayment_status
FROM loans;
