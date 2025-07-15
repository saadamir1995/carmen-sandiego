{{ config(materialized='view') }}

select
    sight_on::date as date_witness,
    file_on::date as date_agent,
    sighter as witness,
    filer as agent,
    lat::decimal(10,5) as latitude,
    long::decimal(10,5) as longitude,
    town as city,
    nation as country,
    report_office as city_agent,
    {{ standardize_boolean('has_weapon') }} as has_weapon,
    {{ standardize_boolean('has_hat') }} as has_hat,
    {{ standardize_boolean('has_jacket') }} as has_jacket,
    behavior,
    'PACIFIC' as region
from {{ ref('pacific') }}
where sight_on is not null
  and sighter is not null
  and filer is not null