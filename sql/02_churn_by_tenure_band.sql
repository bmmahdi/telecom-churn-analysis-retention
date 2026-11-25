-- Business question: At which point in the customer lifecycle is churn highest?
-- Buckets tenure into lifecycle bands and measures churn rate and average charges.
SELECT
    CASE
        WHEN tenure <= 6  THEN '01 - 0-6 months'
        WHEN tenure <= 12 THEN '02 - 7-12 months'
        WHEN tenure <= 24 THEN '03 - 13-24 months'
        WHEN tenure <= 48 THEN '04 - 25-48 months'
        ELSE                   '05 - 49+ months'
    END                                                        AS tenure_band,
    COUNT(*)                                                   AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)             AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2)                              AS avg_monthly_charges
FROM telco_churn
GROUP BY tenure_band
ORDER BY tenure_band;
