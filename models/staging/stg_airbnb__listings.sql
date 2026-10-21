with
    source as (select * from {{ source("airbnb_raw", "listings") }}),

    renamed as (
        select
            cast(id as int64) as listing_id,
            cast(listing_url as string) as listing_url,
            cast(name as string) as listing_name,
            cast(room_type as string) as room_type,
            cast(minimum_nights as int64) as minimum_nights,
            cast(host_id as int64) as host_id,
            cast(price as int64) as price,
            concat('$', cast(price as string)) as price_str,
            cast(created_at as timestamp) as created_at,
            cast(updated_at as timestamp) as updated_at
        from
            source
    )
select *
from renamed
