{{
  config(
    materialized = 'table',
    )
}}

with
source as (
    select * from {{ ref("stg_airbnb__hosts") }}
),

cleaned as (
    select    
        host_id,
        ifnull(host_name, 'N/A') as host_name,
        ifnull(is_superhost, false) as is_superhost, -- if unknown, set to false as nulls are not wanted in this boolean column
        created_at,
        updated_at
    from
        source
)

select * from cleaned