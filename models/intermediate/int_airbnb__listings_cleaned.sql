with
source as (
    select * from {{ ref("stg_airbnb__listings") }}
),

cleaned as (
    select
        listing_id,
        listing_url,
        listing_name,
        room_type,
        case
            when minimum_nights = 0
                then 1
                else minimum_nights
        end as minimum_nights,
        host_id,
        price,
        created_at,
        updated_at
    from
        source
)

select * from cleaned