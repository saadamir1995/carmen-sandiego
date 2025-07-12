{{ config(materialized='view') }}

select
    row_number() over (order by date_witness, witness, agent) as sighting_id,
    date_witness::date as date_witness,
    date_agent::date as date_agent,
    witness,
    agent,
    latitude::decimal(10,5) as latitude,
    longitude::decimal(10,5) as longitude,
    city,
    country,
    region_hq as city_agent,
    case when has_weapon = 'true' then true else false end as has_weapon,
    case when has_hat = 'true' then true else false end as has_hat,
    case when has_jacket = 'true' then true else false end as has_jacket,
    behavior,
    'AFRICA' as region
from {{ source('carmen_raw', 'africa') }}
where date_witness is not null
  and witness is not null
  and agent is not null