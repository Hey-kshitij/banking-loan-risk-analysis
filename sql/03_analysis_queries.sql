USE loan_risk_analysis;
-- Q1 Portfolio overview
SELECT COUNT(*) total_applications, SUM(application_status='Approved') approved_applications,
 ROUND(100.0*SUM(application_status='Approved')/NULLIF(COUNT(*),0),2) approval_rate_pct,
 SUM(repayment_status='Defaulted') defaulted_loans FROM loans;
-- Q2 Default rate among approved loans
SELECT COUNT(*) approved_loans, SUM(repayment_status='Defaulted') defaults,
 ROUND(100.0*SUM(repayment_status='Defaulted')/NULLIF(COUNT(*),0),2) default_rate_pct
FROM loans WHERE application_status='Approved';
-- Q3 Default rate by loan type
SELECT loan_type, COUNT(*) approved_loans, SUM(repayment_status='Defaulted') defaults,
 ROUND(100.0*SUM(repayment_status='Defaulted')/NULLIF(COUNT(*),0),2) default_rate_pct
FROM loans WHERE application_status='Approved' GROUP BY loan_type ORDER BY default_rate_pct DESC;
-- Q4 Default rate by annual-income band
SELECT CASE WHEN c.annual_income<300000 THEN 'Under 3L'
 WHEN c.annual_income<700000 THEN '3L-7L' WHEN c.annual_income<1200000 THEN '7L-12L' ELSE '12L+' END income_band,
 COUNT(*) approved_loans, SUM(l.repayment_status='Defaulted') defaults,
 ROUND(100.0*SUM(l.repayment_status='Defaulted')/NULLIF(COUNT(*),0),2) default_rate_pct
FROM loans l JOIN customers c ON c.customer_id=l.customer_id
WHERE l.application_status='Approved' GROUP BY income_band ORDER BY default_rate_pct DESC;
-- Q5 Default rate by credit-score band
SELECT CASE WHEN c.credit_score<600 THEN 'Below 600' WHEN c.credit_score<670 THEN '600-669'
 WHEN c.credit_score<740 THEN '670-739' ELSE '740+' END credit_band,
 COUNT(*) approved_loans, SUM(l.repayment_status='Defaulted') defaults,
 ROUND(100.0*SUM(l.repayment_status='Defaulted')/NULLIF(COUNT(*),0),2) default_rate_pct
FROM loans l JOIN customers c ON c.customer_id=l.customer_id
WHERE l.application_status='Approved' GROUP BY credit_band ORDER BY default_rate_pct DESC;
-- Q6 Monthly applications and approval rate
SELECT DATE_FORMAT(application_date,'%Y-%m') application_month, COUNT(*) applications,
 SUM(application_status='Approved') approvals,
 ROUND(100.0*SUM(application_status='Approved')/NULLIF(COUNT(*),0),2) approval_rate_pct
FROM loans GROUP BY application_month ORDER BY application_month;
-- Q7 Average requested loan by application status
SELECT application_status, COUNT(*) applications, ROUND(AVG(loan_amount),2) avg_loan_amount
FROM loans GROUP BY application_status;
-- Q8 Payment performance
SELECT payment_status, COUNT(*) payment_count, ROUND(SUM(amount_due),2) total_due,
 ROUND(SUM(amount_paid),2) total_paid FROM payments GROUP BY payment_status;
-- Q9 Overdue payment rate by loan type
SELECT l.loan_type, COUNT(*) payment_rows, SUM(p.payment_status='Overdue') overdue_payments,
 ROUND(100.0*SUM(p.payment_status='Overdue')/NULLIF(COUNT(*),0),2) overdue_rate_pct
FROM payments p JOIN loans l ON l.loan_id=p.loan_id GROUP BY l.loan_type ORDER BY overdue_rate_pct DESC;
-- Q10 Largest approved loans
SELECT l.loan_id,l.loan_type,l.loan_amount,c.customer_id,c.annual_income,c.credit_score
FROM loans l JOIN customers c ON c.customer_id=l.customer_id
WHERE l.application_status='Approved' AND l.loan_amount IS NOT NULL ORDER BY l.loan_amount DESC LIMIT 10;
-- Q11 CTE + window function: rank loan types by default rate
WITH risk AS (
 SELECT loan_type, COUNT(*) approved_loans, SUM(repayment_status='Defaulted') defaults,
 100.0*SUM(repayment_status='Defaulted')/NULLIF(COUNT(*),0) default_rate_pct
 FROM loans WHERE application_status='Approved' GROUP BY loan_type
)
SELECT loan_type,approved_loans,defaults,ROUND(default_rate_pct,2) default_rate_pct,
 DENSE_RANK() OVER(ORDER BY default_rate_pct DESC) risk_rank FROM risk;
-- Q12 Customers with multiple applications
SELECT c.customer_id,COUNT(l.loan_id) applications,ROUND(SUM(COALESCE(l.loan_amount,0)),2) total_requested_amount
FROM customers c JOIN loans l ON l.customer_id=c.customer_id
GROUP BY c.customer_id HAVING COUNT(l.loan_id)>1 ORDER BY applications DESC,total_requested_amount DESC;
-- Q13 Default rate by employment type
SELECT c.employment_type,COUNT(*) approved_loans,SUM(l.repayment_status='Defaulted') defaults,
 ROUND(100.0*SUM(l.repayment_status='Defaulted')/NULLIF(COUNT(*),0),2) default_rate_pct
FROM loans l JOIN customers c ON c.customer_id=l.customer_id
WHERE l.application_status='Approved' GROUP BY c.employment_type ORDER BY default_rate_pct DESC;
-- Q14 Orphan payment records
SELECT p.* FROM payments p LEFT JOIN loans l ON l.loan_id=p.loan_id WHERE l.loan_id IS NULL;
-- Q15 Late/overdue payment share
SELECT ROUND(100.0*SUM(payment_status IN ('Paid Late','Overdue'))/NULLIF(COUNT(*),0),2) late_or_overdue_share_pct
FROM payments;
