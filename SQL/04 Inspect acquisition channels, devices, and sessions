
SELECT
    traffic_source.source AS acquisition_source,
    device.category AS device_type,

    COUNT(*) AS total_events,

    COUNT(DISTINCT user_pseudo_id)
        AS unique_users,

    COUNTIF(event_name = 'purchase')
        AS purchase_events,

    COUNTIF(
        EXISTS (
            SELECT 1
            FROM UNNEST(event_params) AS ep
            WHERE ep.key = 'ga_session_id'
        )
    ) AS events_with_session_id

FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

GROUP BY
    acquisition_source,
    device_type

ORDER BY
    total_events DESC

LIMIT 30;
