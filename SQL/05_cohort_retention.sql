
-- PROJECT: Product Funnel, Conversion & Customer Retention Analytics
-- ANALYSIS 05: Customer Retention and Cohort Analysis
-- OBJECTIVE: Measure monthly user retention based on first observed activity.

WITH user_activity AS (

    SELECT DISTINCT
        user_pseudo_id,

        DATE_TRUNC(
            PARSE_DATE('%Y%m%d', event_date),
            MONTH
        ) AS activity_month

    FROM
        `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

    WHERE
        user_pseudo_id IS NOT NULL
),

user_cohorts AS (

    SELECT
        user_pseudo_id,
        MIN(activity_month) AS cohort_month

    FROM user_activity

    GROUP BY user_pseudo_id
),

cohort_activity AS (

    SELECT
        c.cohort_month,
        a.activity_month,

        DATE_DIFF(
            a.activity_month,
            c.cohort_month,
            MONTH
        ) AS months_since_first_seen,

        COUNT(DISTINCT a.user_pseudo_id) AS active_users

    FROM user_activity a

    JOIN user_cohorts c
        USING (user_pseudo_id)

    GROUP BY
        c.cohort_month,
        a.activity_month,
        months_since_first_seen
),

cohort_sizes AS (

    SELECT
        cohort_month,
        COUNT(DISTINCT user_pseudo_id) AS cohort_size

    FROM user_cohorts

    GROUP BY cohort_month
)

SELECT
    a.cohort_month,
    a.months_since_first_seen,
    s.cohort_size,
    a.active_users,

    ROUND(
        100.0 * a.active_users / s.cohort_size,
        2
    ) AS retention_rate_pct

FROM cohort_activity a

JOIN cohort_sizes s
    USING (cohort_month)

ORDER BY
    a.cohort_month,
    a.months_since_first_seen;
