{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}
with source as (
    select * from {{ ref("stg_airbnb__reviews") }}
)

select
    *
from
    source
where
    review_text is not null

{% if is_incremental() %}
    and review_date >= coalesce((select max(review_date) from {{ this }}), '1900-01-01')
{% endif %}