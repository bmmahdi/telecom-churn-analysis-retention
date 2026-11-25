-- Business question: Do support and security add-ons reduce churn for internet customers?
-- Cross-tabulates internet service type with tech support / online security adoption.
SELECT
    InternetService,
    TechSupport,
    OnlineSecurity,
    COUNT(*)                                                   AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)             AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2)                              AS avg_monthly_charges
FROM telco_churn
WHERE InternetService <> 'No'
GROUP BY InternetService, TechSupport, OnlineSecurity
ORDER BY InternetService, churn_rate_pct DESC;
