with
    source as (select * from {{ source("airbnb_raw", "reviews") }}),

    renamed as (
        select
            cast(listing_id as int64) as listing_id,
            cast(date as timestamp) as review_date,
            cast(reviewer_name as string) as reviewer_name,
            cast(comments as string) as review_text,
            cast(sentiment as string) as review_sentiment
        from source
    )
select *
from renamed
