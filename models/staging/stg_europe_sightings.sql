{{ config(materialized='view') }}

select
    row_number() over (order by date_witness, witness, agent) as sighting_id,
    date_witness::date as date_witness,
    date_filed::date as date_agent,
    witness,
    agent,
    lat_::decimal(10,5) as latitude,
    long_::decimal(10,5) as longitude,
    city,
    country,
    region_hq as city_agent,
    case when "armed?" = 'true' then true else false end as has_weapon,
    case when "chapeau?" = 'true' then true else false end as has_hat,
    case when "coat?" = 'true' then true else false end as has_jacket,
    observed_action as behavior,
    'EUROPE' as region
from {{ source('carmen_raw', 'europe') }}
where date_witness is not null
  and witness is not null
  and agent is not null