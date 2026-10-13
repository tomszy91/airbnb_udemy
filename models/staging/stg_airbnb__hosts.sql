with
    source as (select * from {{source("airbnb_raw", "hosts") }} ),

    renamed as (
        select
            cast(id as int64) as host_id,
            cast(name as string) as host_name,
            cast(is_superhost as boolean) as is_superhost,
            cast(created_at as timestamp) as created_at,
            cast(updated_at as timestamp) as updated_at
        from
            source
    )
select * from renamed