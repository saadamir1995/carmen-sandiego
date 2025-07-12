{{ config(materialized='view') }}

select
    row_number() over (order by sighting, citizen, officer) as sighting_id,
    sighting::date as date_witness,
    "报道"::date as date_agent,
    citizen as witness,
    officer as agent,
    "纬度"::decimal(10,5) as latitude,
    "经度"::decimal(10,5) as longitude,
    city,
    nation as country,
    city_interpol as city_agent,
    case when has_weapon = 'true' then true else false end as has_weapon,
    case when has_hat = 'true' then true else false end as has_hat,
    case when has_jacket = 'true' then true else false end as has_jacket,
    behavior,
    'ASIA' as region
from {{ source('carmen_raw', 'asia') }}
where sighting is not null
  and citizen is not null
  and officer is not null