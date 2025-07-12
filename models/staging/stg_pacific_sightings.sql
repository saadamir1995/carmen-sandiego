{{ config(materialized='view') }}

select
    row_number() over (order by sight_on, sighter, filer) as sighting_id,
    sight_on::date as date_witness,
    file_on::date as date_agent,
    sighter as witness,
    filer as agent,
    lat::decimal(10,5) as latitude,
    long::decimal(10,5) as longitude,
    town as city,
    nation as country,
    report_office as city_agent,
    case when has_weapon = 'true' then true else false end as has_weapon,
    case when has_hat = 'true' then true else false end as has_hat,
    case when has_jacket = 'true' then true else false end as has_jacket,
    behavior,
    'PACIFIC' as region
from {{ source('carmen_raw', 'pacific') }}
where sight_on is not null
  and sighter is not null
  and filer is not null