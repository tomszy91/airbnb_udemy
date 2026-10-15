select
    *
from
    {{ ref("int_airbnb__listings_cleaned")}}
where minimum_nights < 1