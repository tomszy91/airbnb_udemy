with
source as (
    select room_type from {{ ref("int_airbnb__listings_cleaned") }}
)

select
    distinct room_type from source