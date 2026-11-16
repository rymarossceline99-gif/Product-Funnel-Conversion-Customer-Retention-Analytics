
-- PROJECT: Product Funnel, Conversion & Customer Retention Analytics
-- ANALYSIS 02: Dataset Overview
-- OBJECTIVE: Understand the dataset's date range, size and user count.

SELECT
    MIN(event_date) AS first_date,
    MAX(event_date) AS last_date,
    COUNT(DISTINCT event_date) AS number_of_days,
    COUNT(*) AS total_events,
    COUNT(DISTINCT user_pseudo_id) AS unique_users
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;
