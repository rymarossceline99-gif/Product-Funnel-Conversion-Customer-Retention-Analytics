
-- Project: Product Funnel, Conversion & Customer Retention Analytics
-- Analysis 01: Event Distribution and User Activity
-- Objective: Identify the most frequent events and unique users.

SELECT
    event_name,
    COUNT(*) AS total_events,
    COUNT(DISTINCT user_pseudo_id) AS unique_users
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY
    event_name
ORDER BY
    total_events DESC;
