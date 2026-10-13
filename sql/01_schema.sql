-- Banking & Loan Risk Analysis | MySQL 8.0+
CREATE DATABASE IF NOT EXISTS loan_risk_analysis;
USE loan_risk_analysis;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
 customer_id VARCHAR(10) PRIMARY KEY, age TINYINT, annual_income DECIMAL(12,2),
 employment_type VARCHAR(30), city VARCHAR(50), education_level VARCHAR(30), credit_score SMALLINT
);
CREATE TABLE loans (
 loan_id VARCHAR(10) PRIMARY KEY, customer_id VARCHAR(10), application_date DATE, loan_type VARCHAR(30),
 loan_amount DECIMAL(14,2), loan_term_months SMALLINT, interest_rate_pct DECIMAL(5,2),
 application_status VARCHAR(20), repayment_status VARCHAR(30),
 CONSTRAINT fk_loans_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE payments (
 payment_id VARCHAR(12) PRIMARY KEY, loan_id VARCHAR(10), due_date DATE, payment_date DATE NULL,
 amount_due DECIMAL(14,2), amount_paid DECIMAL(14,2), payment_status VARCHAR(20),
 CONSTRAINT fk_payments_loan FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
-- Import CSVs into matching tables in this order: customers, loans, payments.
