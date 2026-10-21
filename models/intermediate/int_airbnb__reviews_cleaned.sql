{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail',
        tags = ['fact'],
        event_time="review_date",
        partition_by = {
            'field': 'review_date',
            'data_type': 'timestamp',
            'granularity': 'year'
        },
        schema='mart'
    )
}}
with source as (
    select * from {{ ref("stg_airbnb__reviews") }}
)

select
    {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id,
    *
from
    source
where
    review_text is not null

{% if is_incremental() %}
    {% if var("start_date", False) and var("end_date", False) %}
        {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end date: ' ~ var("end_date"), info=True) }}
        and review_date >= '{{ var("start_date") }}'
        and review_date < '{{ var("end_date") }}'
    {% else %}
        and review_date > coalesce((select max(review_date) from {{ this }}), '1900-01-01')
        {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True) }}
    {% endif %}
{% endif %}