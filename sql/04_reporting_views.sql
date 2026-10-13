USE loan_risk_analysis;
CREATE OR REPLACE VIEW vw_loan_portfolio AS
SELECT l.loan_id,l.customer_id,c.age,c.annual_income,c.employment_type,c.city,c.credit_score,
 l.application_date,l.loan_type,l.loan_amount,l.loan_term_months,l.interest_rate_pct,
 l.application_status,l.repayment_status,
 CASE WHEN l.application_status='Approved' THEN 1 ELSE 0 END is_approved,
 CASE WHEN l.application_status='Approved' AND l.repayment_status='Defaulted' THEN 1 ELSE 0 END is_defaulted
FROM loans l JOIN customers c ON c.customer_id=l.customer_id;
CREATE OR REPLACE VIEW vw_payment_summary AS
SELECT l.loan_id,l.loan_type,l.customer_id,COUNT(p.payment_id) payment_count,
 SUM(p.amount_due) total_amount_due,SUM(p.amount_paid) total_amount_paid,
 SUM(p.payment_status='Overdue') overdue_payment_count,SUM(p.payment_status='Paid Late') late_payment_count
FROM loans l LEFT JOIN payments p ON p.loan_id=l.loan_id
GROUP BY l.loan_id,l.loan_type,l.customer_id;
