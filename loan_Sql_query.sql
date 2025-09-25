create database loan_analysis;
use loan_analysis;

select * from loan_data limit 10;

-- Total Loans Approved vs Rejected --

SELECT 
    loanapprovedstatus, COUNT(*) AS totalaplication
FROM
    loan_data
GROUP BY 1;

-- Approval Rate --

SELECT 
    ROUND(SUM(CASE
                WHEN loanapprovedstatus = 'Approved' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS loan_Approval_Rate
FROM
    loan_data;
    
    
-- Approval Rate by AgeGroup --

SELECT 
    AgeGroup,
    COUNT(*) AS total_application,
    SUM(CASE
        WHEN loanapprovedstatus = 'approved' THEN 1
        ELSE 0
    END) AS Approved_loan,
    ROUND(SUM(CASE
                WHEN loanapprovedstatus = 'approved' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS Approved_loan_rate
FROM
    loan_data
GROUP BY 1
ORDER BY approved_loan DESC;


-- Approval Rate by Credit Score Category --

SELECT 
    creditscorecategor,
    COUNT(*) AS total_application,
    ROUND(SUM(CASE
                WHEN loanapprovedstatus = 'approved' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS approvel_rate
FROM
    loan_data
GROUP BY 1
ORDER BY 2 DESC;

-- Approval Rate by DTI Risk Category --

SELECT 
    dtiriskcategory,
    COUNT(*) AS total_application,
    ROUND(SUM(CASE
                WHEN loanapprovedstatus = 'approved' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS approvel_rate
FROM
    loan_data
GROUP BY 1;


-- Average Loan Amount by Income Group --

SELECT 
    CASE
        WHEN monthlyincome < 20000 THEN '<20k'
        WHEN monthlyincome BETWEEN 20000 AND 40000 THEN '20k-40k'
        WHEN monthlyincome BETWEEN 40000 AND 60000 THEN '40k-60k'
        ELSE '>60k'
    END AS Income_group,
    COUNT(*) AS total_application,
    SUM(CASE
        WHEN loanapprovedstatus = 'approved' THEN 1
        ELSE 0
    END) AS approved_application,
    ROUND(AVG(loanamount), 2) AS avg_loan_amount,
    ROUND(SUM(CASE
                WHEN loanapprovedstatus = 'approved' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS loan_approvel_rate
FROM
    loan_data
GROUP BY 1;

    





