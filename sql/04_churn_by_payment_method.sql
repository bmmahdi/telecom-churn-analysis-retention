-- Business question: Which payment methods and billing preferences correlate with churn?
-- Compares churn rate and average tenure across payment methods.
SELECT
    PaymentMethod,
    PaperlessBilling,
    COUNT(*)                                                   AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)             AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(tenure), 1)                                      AS avg_tenure_months,
    ROUND(AVG(MonthlyCharges), 2)                              AS avg_monthly_charges
FROM telco_churn
GROUP BY PaymentMethod, PaperlessBilling
ORDER BY churn_rate_pct DESC;
