-- Business question: How does churn rate vary by contract type, and how much
-- revenue is exposed in each contract segment?
-- One row per contract type with customer count, churn rate and monthly revenue at risk.
SELECT
    Contract,
    COUNT(*)                                                   AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)             AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2)                              AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS monthly_revenue_at_risk
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate_pct DESC;
