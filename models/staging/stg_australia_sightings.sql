{{ config(materialized='view') }}

select
    row_number() over (order by witnessed, observer, field_chap) as sighting_id,
    witnessed::date as date_witness,
    reported::date as date_agent,
    observer as witness,
    field_chap as agent,
    lat::decimal(10,5) as latitude,
    long::decimal(10,5) as longitude,
    place as city,
    nation as country,
    interpol_spot as city_agent,
    case when has_weapon = 'true' then true else false end as has_weapon,
    case when has_hat = 'true' then true else false end as has_hat,
    case when has_jacket = 'true' then true else false end as has_jacket,
    state_of_mind as behavior,
    'AUSTRALIA' as region
from {{ source('carmen_raw', 'australia') }}
where witnessed is not null
  and observer is not null
  and field_chap is not null