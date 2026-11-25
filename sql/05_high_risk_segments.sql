-- Business question: Which customer segments combine high churn risk with high revenue?
-- Ranks segments by monthly revenue at risk to prioritise retention spend.
SELECT
    Contract,
    InternetService,
    CASE WHEN SeniorCitizen = 1 THEN 'Senior' ELSE 'Non-senior' END AS senior_flag,
    COUNT(*)                                                   AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)             AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2)                              AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS monthly_revenue_at_risk
FROM telco_churn
GROUP BY Contract, InternetService, senior_flag
HAVING COUNT(*) >= 50
ORDER BY monthly_revenue_at_risk DESC
LIMIT 15;
