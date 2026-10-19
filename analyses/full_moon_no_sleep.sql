with
full_moon_reviews as (
    select * from {{ ref('mrt_airbnb__fullmoon_reviews') }}
)

select
    is_full_moon,
    review_sentiment,
    count(*) as reviews,
    round(safe_divide(count(*), sum(count(*)) over (partition by is_full_moon)) * 100, 2) as pct_share_in_sentiment
from
    full_moon_reviews
group by
    is_full_moon,
    review_sentiment
order by 
    is_full_moon,
    review_sentiment