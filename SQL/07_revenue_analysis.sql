-- PROJECT: Product Funnel, Conversion & Customer Retention Analytics
-- ANALYSIS 07: Revenue Analysis
-- OBJECTIVE: Measure overall revenue and purchasing activity.

SELECT
    COUNTIF(event_name = 'purchase')
        AS purchase_events,

    COUNT(DISTINCT IF(
        event_name = 'purchase',
        user_pseudo_id,
        NULL
    )) AS unique_purchasing_users,

    COUNT(DISTINCT IF(
        event_name = 'purchase',
        ecommerce.transaction_id,
        NULL
    )) AS unique_transaction_ids,

    ROUND(
        SUM(IF(
            event_name = 'purchase',
            ecommerce.purchase_revenue_in_usd,
            0
        )),
        2
    ) AS total_revenue_usd,

    ROUND(
        AVG(IF(
            event_name = 'purchase',
            ecommerce.purchase_revenue_in_usd,
            NULL
        )),
        2
    ) AS average_revenue_per_purchase_event

FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;
