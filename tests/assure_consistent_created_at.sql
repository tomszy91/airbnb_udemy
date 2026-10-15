with
reviews as (
    select
        listing_id,
        review_date
    from
        {{ ref("int_airbnb__reviews_cleaned") }}
),

listings as (
    select
        listing_id,
        created_at
    from
        {{ ref("int_airbnb__listings_cleaned") }}
),

joined as (
    select
        l.listing_id,
        l.created_at as listing_created_at,
        r.review_date
    from
        listings as l
            inner join reviews as r on l.listing_id = r.listing_id
    where
        l.created_at > r.review_date
)

select * from joined