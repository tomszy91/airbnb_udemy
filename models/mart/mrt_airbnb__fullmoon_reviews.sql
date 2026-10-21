{{ 
    config(
        materialized = 'incremental',
        incremental_strategy = 'microbatch',
        event_time="review_date",
        begin="2009-06-20",
        batch_size="year",
        partition_by = {
            'field': 'review_date',
            'data_type': 'timestamp',
            'granularity': 'year'
        },
        schema='mart'
)}}

with 
reviews as (
    select * from {{ ref("int_airbnb__reviews_cleaned") }}
),
full_moon as (
    select * from {{ ref("seed_full_moon_dates") }}
),
joined as (
    select
        r.*,
        fm.full_moon_date is not null as is_full_moon
    from
        reviews as r
            left join full_moon as fm
            -- we assume that reviews are written one day later
            on date(r.review_date) = date_add(fm.full_moon_date, interval 1 day)
)

select * from joined