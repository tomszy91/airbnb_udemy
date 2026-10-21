{{
    config(
        schema='mart'
        ) 
}}

with
listings as (
    select
        *
    from
        {{ ref("int_airbnb__listings_cleaned") }}
),
hosts as (
    select
        *
    from
        {{ ref("int_airbnb__hosts_cleaned", v=2) }}
)

select
        l.listing_id,
        l.listing_name,
        l.room_type,
        l.minimum_nights,
        l.price,
        l.price_str,
        h.host_id,
        h.host_name,
        h.is_superhost as host_is_superhost,
        l.created_at,
        greatest(l.updated_at , h.updated_at) as updated_at
from listings as l
    left join hosts as h
        on l.host_id = h.host_id